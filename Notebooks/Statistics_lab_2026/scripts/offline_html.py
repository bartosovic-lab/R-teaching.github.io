"""Remove the unused external MathJax loader from previously rendered HTML.

New builds use mathjax: null in R Markdown. This one-time-compatible cleanup
changes no notebook content, code output, or figures and needs no R runtime.
"""
from pathlib import Path
import re

root = Path(__file__).resolve().parents[1]
pattern = re.compile(r'<!-- dynamically load mathjax for compatibility with self-contained -->\s*'
                     r'<script>.*?</script>', re.S)
changed = 0
for path in root.rglob("*.html"):
    original = path.read_text()
    updated, count = pattern.subn("", original)
    assert count <= 1, path
    updated = "\n".join(line.rstrip() for line in updated.splitlines()).rstrip() + "\n"
    if updated != original:
        path.write_text(updated)
    if count:
        changed += 1
print(f"Removed unused external MathJax loaders from {changed} rendered files.")
