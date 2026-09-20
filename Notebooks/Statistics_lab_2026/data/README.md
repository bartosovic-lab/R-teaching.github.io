# Teaching data

`mmse_small.csv` transcribes the existing `../../../data/excel_data.xlsx`, sheet
“Mini Mental State exam”, cells A8:A17 (Healthy, relabelled Control) and B8:B17 (AD).
All 20 score values and their within-column order are preserved. `id`
contains newly created labels, not recovered patient identifiers. The workbook
labels these as patient scores but does not establish provenance, sampling,
clinical criteria or pairing. Treat this as an educational example, not evidence
about a clinical population. For the exercises only, assume 20 separate people.

| Variable | Meaning |
|---|---|
| id | Unique artificial row label; nominal |
| group | Control or AD; nominal teaching group |
| MMSE | Bounded integer score, 0–30; score points, not a ratio of cognitive ability |

`neurites.csv` is a byte-for-byte copy of `../../../data/03_neurites_synthetic.csv`.
It contains 20 synthetic values for each of control, condition_1 and condition_2.
Units and generation details are not documented in the source, so figures say
“synthetic measurement (units unspecified)”. The independent-group design is an
explicit teaching assumption. Positions in adjacent columns do not imply pairs;
one wide row holds one entry from each group, not one shared biological unit.
Do not infer a common cell, culture or animal from a row number.

Missing-value and outlier activities use separate demonstration vectors.
The correlation example is a seeded simulation of 30 independent teaching units;
its variables are arbitrary assay signals, not patient measurements. The categorical
and paired extensions are explicitly invented examples. None modifies source data.
The larger dementia CSV belongs to Day 2 and is not used for Day 1 inference.
