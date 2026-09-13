"""Create a portable student project without instructor notes or answer keys."""
from pathlib import Path
import re
import zipfile

root = Path(__file__).resolve().parents[1]
paths = [root / "Statistics_lab.Rproj", root / "index.html"]
for directory in ["notebooks", "data", "figures"]:
    paths.extend(p for p in (root / directory).iterdir()
                 if p.suffix in {".Rmd", ".html", ".csv", ".png"})
with zipfile.ZipFile(root / "statistics_lab_student.zip", "w", zipfile.ZIP_DEFLATED) as archive:
    for path in sorted(paths):
        name = "Statistics_lab_2026/" + str(path.relative_to(root))
        if path.name == "index.html":
            # The extracted project should not link to a ZIP that is outside it.
            content = re.sub(r'<a href="statistics_lab_student.zip">.*?</a>',
                             'This is your downloaded student project', path.read_text(), flags=re.S)
            archive.writestr(name, content)
        else:
            archive.write(path, name)
    archive.writestr("Statistics_lab_2026/outputs/", "")
print(f"Packaged {len(paths)} student files; instructor files excluded.")
