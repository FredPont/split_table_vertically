# Split table vertically

split_table_vertically split tables by rows into n sub-tables

- Tables must be in text format such as txt, csv, tsv...
- Keep the header for each sub-table
- Batch processing of any number of tables
- Can split huge tables on a small computer : line by line processing

# Manual

1. Install Julia (https://julialang.org/downloads/)
2. Test the software using the test files first
2. Copy the tables in the "data" directory
3. Start the software in the split_table_vertically directory with
    - julia main.jl number_of_tables
    - julia main.jl 4 # split the tables into 4 tables
4. Sub-tables are in the "results" directory

