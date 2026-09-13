"""Rebuild teaching CSVs from preserved sources; Python standard library only.

Run from any directory: python3 path/to/scripts/prepare_data.py
No downloads, imputation, simulated patients, or changes to source values.
"""
from pathlib import Path
import csv
import hashlib
import json
import shutil
import xml.etree.ElementTree as ET
import zipfile

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "instructor" / "source"
NS = {"s": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}


def worksheet(path, sheet="sheet1.xml"):
    with zipfile.ZipFile(path) as archive:
        strings = ["".join(x.itertext()) for x in ET.fromstring(
            archive.read("xl/sharedStrings.xml")).findall("s:si", NS)]
        rows = []
        for row in ET.fromstring(archive.read("xl/worksheets/" + sheet)).findall(
                "s:sheetData/s:row", NS):
            cells = {}
            for cell in row.findall("s:c", NS):
                value = cell.find("s:v", NS)
                if value is not None:
                    cells[cell.attrib["r"]] = (strings[int(value.text)]
                        if cell.get("t") == "s" else value.text)
            rows.append(cells)
        return rows


def write_csv(path, fields, rows):
    with path.open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields, lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def main():
    (ROOT / "data").mkdir(exist_ok=True)
    cells = {k: v for row in worksheet(SOURCE / "excel_data.xlsx") for k, v in row.items()}
    assert cells["A7"] == "Healthy" and cells["B7"] == "AD"
    small = []
    for col, group in [("A", "Control"), ("B", "AD")]:
        for row in range(8, 18):
            small.append({"Teaching_ID": f"{group}_{row-7:02}", "Group": group,
                          "MMSE": cells[f"{col}{row}"]})
    write_csv(ROOT / "data/mmse_small.csv", ["Teaching_ID", "Group", "MMSE"], small)

    original = worksheet(SOURCE / "oasis_longitudinal_demographics.xlsx")
    headers = {"".join(filter(str.isalpha, k)): v for k, v in original[0].items()}
    source_rows = [{headers["".join(filter(str.isalpha, k))]: v for k, v in row.items()}
                   for row in original[1:]]
    assert len(source_rows) == 373
    with (SOURCE / "alzheimer_data.csv").open(newline="") as handle:
        legacy = list(csv.DictReader(handle))
    assert len(legacy) == 336
    tolerance = {"eTIV": 0.50001, "nWBV": 0.00050001, "ASF": 0.00050001}
    restored = []
    mapping = []
    for row in legacy:
        record = source_rows[int(row[""]) - 1]
        for column, value in row.items():
            if column == "":
                continue
            source_value = record.get("M/F" if column == "M.F" else column, "NA")
            if column in tolerance:
                assert abs(float(value) - float(source_value)) <= tolerance[column]
            else:
                assert value == source_value, (row[""], column, value, source_value)
        identifiers = {"Source_row": row[""], "Subject_ID": record["Subject ID"],
                       "Visit": record["Visit"]}
        mapping.append(identifiers)
        restored.append({**identifiers, **{k: v for k, v in row.items() if k}})
    assert {int(r[""]) for r in legacy} == {
        i for i, r in enumerate(source_rows, 1) if r["Group"] != "Converted"}
    baseline = [r for r in restored if r["Visit"] == "1"]
    assert len(baseline) == len({r["Subject_ID"] for r in baseline}) == 136
    assert sum(r["Group"] == "Demented" for r in baseline) == 64
    assert sum(r["Group"] == "Nondemented" for r in baseline) == 72
    fields = list(restored[0])
    write_csv(ROOT / "data/mmse_baseline.csv", fields, baseline)
    write_csv(ROOT / "instructor/source/visit_mapping.csv", list(mapping[0]), mapping)
    shutil.copyfile(SOURCE / "03_neurites_synthetic.csv", ROOT / "data/neurites.csv")
    audit = {"source_sha256": {p.name: hashlib.sha256(p.read_bytes()).hexdigest()
             for p in sorted(SOURCE.iterdir()) if p.suffix in {".csv", ".xlsx"}},
             "legacy_visits": len(legacy), "baseline_participants": len(baseline),
             "baseline_groups": {g: sum(r["Group"] == g for r in baseline)
                                  for g in ["Demented", "Nondemented"]},
             "baseline_missing": {k: sum(r[k] == "NA" for r in baseline) for k in fields},
             "small_scores": {g: [int(r["MMSE"]) for r in small if r["Group"] == g]
                              for g in ["Control", "AD"]}}
    (ROOT / "instructor/data_audit.json").write_text(json.dumps(audit, indent=2) + "\n")
    print(f"Prepared {len(small)} small-example rows and {len(baseline)} baseline participants.")


if __name__ == "__main__":
    main()
