"""Check local HTML links, embedded assets, source preservation, and student ZIP."""
from pathlib import Path
from html.parser import HTMLParser
from urllib.parse import urlsplit, unquote
import hashlib
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]


class Page(HTMLParser):
    def __init__(self):
        super().__init__()
        self.ids, self.links, self.assets = set(), [], []

    def handle_starttag(self, tag, attrs):
        data = dict(attrs)
        if "id" in data:
            self.ids.add(data["id"])
        if tag == "a" and "href" in data:
            self.links.append(data["href"])
        if tag in {"script", "img", "link"}:
            self.assets.append(data.get("src", data.get("href", "")))


def check_html(root):
    pages = {}
    for path in root.rglob("*.html"):
        page = Page()
        page.feed(path.read_text())
        pages[path.resolve()] = page
    checked = 0
    for path, page in pages.items():
        for target in page.links:
            url = urlsplit(target)
            if url.scheme or url.netloc or target == "#":
                continue
            destination = (path.parent / unquote(url.path)).resolve() if url.path else path
            assert destination.exists(), (path.name, target)
            if url.fragment and destination in pages:
                assert unquote(url.fragment) in pages[destination].ids, (path.name, target)
            checked += 1
        for asset in page.assets:
            url = urlsplit(asset)
            assert not url.netloc, ("External render dependency", path.name, asset)
            if asset and not url.scheme:
                assert (path.parent / unquote(url.path)).exists(), (path.name, asset)
    return len(pages), checked


before = {p: hashlib.sha256(p.read_bytes()).hexdigest()
          for p in list((ROOT / "data").glob("*.csv")) + [ROOT / "instructor/data_audit.json"]}
subprocess.run(["python3", str(ROOT / "scripts/prepare_data.py")], check=True)
assert all(hashlib.sha256(p.read_bytes()).hexdigest() == value for p, value in before.items())
print("Data preparation is deterministic and source comparisons passed.")
count, links = check_html(ROOT)
print(f"Checked {count} HTML pages and {links} local links/anchors.")
with zipfile.ZipFile(ROOT / "statistics_lab_student.zip") as archive:
    assert not any("/instructor/" in name or "/scripts/" in name for name in archive.namelist())
    with tempfile.TemporaryDirectory(prefix="statistics lab student ") as folder:
        archive.extractall(folder)
        count, links = check_html(Path(folder))
        print(f"Student ZIP: {count} HTML pages, {links} local links/anchors, no instructor files.")
assert not subprocess.check_output(["git", "diff", "main", "--name-only", "--diff-filter=MD"],
                                   cwd=ROOT, text=True).strip(), "An existing file was modified/deleted"
print("No tracked files from main were modified or deleted.")
