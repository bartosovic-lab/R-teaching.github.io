# Day 2 data

`alzheimer_data.csv` is a subset of the OASIS-2 longitudinal dementia study
(Marcus et al., 2010; https://sites.wustl.edu/oasisbrains/home/oasis-2/), as used
in this course for several years. Values are unchanged. One row is one
**MRI visit**; the same person can appear in several rows (336 rows from 136
participants), and subject IDs were removed from this copy. For the Day 2
exercises every row is treated as an independent observation; this is a
simplification to mention in your limitations. Participants of the study's "Converted"
group are not included.

| Column | Meaning | Type |
|---|---|---|
| (first, unnamed) | Row number | identifier |
| `Group` | `Demented` or `Nondemented` (study classification) | nominal |
| `M.F` | Sex, `M` or `F` | nominal |
| `Age` | Age in years at the visit | numeric |
| `EDUC` | Years of education | numeric |
| `SES` | Socioeconomic status, 1 (highest) to 5 (lowest); 19 missing values | ordinal |
| `MMSE` | Mini-Mental State Examination, 0–30, higher is better; 2 missing values | bounded score |
| `CDR` | Clinical Dementia Rating: 0 none, 0.5 very mild, 1 mild, 2 moderate | ordinal |
| `eTIV` | Estimated total intracranial volume, mm³ | numeric |
| `nWBV` | Normalised whole-brain volume (fraction of eTIV) | numeric |
| `ASF` | Atlas scaling factor | numeric |

Import with `read.csv("data/alzheimer_data.csv", row.names = 1)`.
