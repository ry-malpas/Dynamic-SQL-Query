# Dynamic-SQL-Query

A SQL Server script that dynamically builds a query using columns discovered from INFORMATION_SCHEMA.COLUMNS.

The script is designed for tables containing multiple similarly named columns, allowing those columns to be discovered automatically rather than having to manually specify every column in the query.

Requirements
Microsoft SQL Server
Permission to read the target database and table
Support for STRING_AGG
A table containing columns matching the configured naming pattern
How It Works

The script queries INFORMATION_SCHEMA.COLUMNS to identify columns belonging to the target table whose names match a specified pattern.

It then dynamically builds:

A list of columns to include in the query
CASE expressions for checking column values
A WHERE clause based on the matching columns
The final SQL query

The generated SQL is then executed using EXEC.

Configuration

The target table and column pattern are specified in the INFORMATION_SCHEMA.COLUMNS queries.

For example:

WHERE Table_Name = 'Table'
  AND Column_Name LIKE 'Column%'

This will find columns such as:

Column1
Column2
Column3
ColumnExample

The table name and column pattern can be changed to match your database.

Dynamic Column Selection

The script uses STRING_AGG to combine the matching column names into a single list.

For example, if the table contains:

ColumnA
ColumnB
ColumnC

the generated column list will be equivalent to:

[ColumnA], [ColumnB], [ColumnC]

QUOTENAME is used when generating the column list to safely delimit column names.

Dynamic SQL

The final query is constructed as a string and executed using:

EXEC (@EndQuery)

This allows the number of matching columns to change without requiring the query itself to be manually rewritten.

Example Use Case

This approach can be useful when a table contains a collection of similarly named indicator columns, such as:

Department_IT
Department_HR
Department_Finance
Department_Sales

Instead of manually checking every column, the script can discover the relevant columns and generate the query automatically.

Important Notes

This script generates SQL dynamically based on database metadata.

Before using it against production data, review the generated SQL carefully. During development, it can be useful to replace:

EXEC (@EndQuery)

with:

PRINT @EndQuery

or:

SELECT @EndQuery

This allows the generated query to be inspected before execution.

The generated SQL should be tested against a non-production database first.

Known Considerations

The current script is intended as a starting point and may require adjustments to the generated CASE expressions and WHERE clause depending on the exact table structure and desired filtering behaviour.

The comparison values are currently based around 'Y'/'y'. SQL Server's behaviour for these comparisons can depend on the database or column collation.
