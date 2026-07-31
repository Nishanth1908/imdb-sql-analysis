# IMDb SQL Analysis

This directory contains the SQL scripts used for an end-to-end exploratory analysis of the IMDb dataset.

The project investigates how characteristics such as runtime, genre, release period, audience engagement, and directors are associated with audience reception using SQL.

## Project Workflow

1. Create the required database tables.
2. Import the IMDb datasets into MySQL.
3. Prepare and consolidate the data into a `movies` table.
4. Perform exploratory data analysis to answer the project questions.

## Files

| File | Description |
|------|-------------|
| `01_create_tables.sql` | Creates the database schema for the IMDb tables. |
| `02_import_data.sql` | Imports the IMDb TSV datasets into MySQL. |
| `03_create_movies_table.sql` | Joins and prepares the data for analysis. |
| `04_imdb_analysis.sql` | SQL queries used to answer the analysis questions and generate insights. |

## Dataset

This project uses the publicly available **IMDb Non-Commercial Datasets**.

For details about the datasets and tables used, see the [`dataset`](../dataset) directory.

## Related Documentation

The complete project report, methodology, findings, and conclusions are available in the repository's main **README.md**.
