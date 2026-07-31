# Dataset
This project uses the publicly available IMDb Non-Commercial Datasets.

## Source
https://datasets.imdbws.com/

## Tables Used
| Table | Description |
|--------|-------------|
| `title_basics` | Movie metadata including title, release year, runtime, and genres |
| `title_ratings` | IMDb average ratings and number of votes |
| `title_crew` | Directors and writers associated with each title |
| `name_basics` | Information about directors and other people in the IMDb database |

## Data Preparation
The original TSV files were imported into MySQL. Relevant tables were joined to create a consolidated `movies` table used throughout the analysis.

## Note
The raw IMDb dataset is **not included** in this repository because it is publicly distributed by IMDb and can be downloaded directly from the official source.
