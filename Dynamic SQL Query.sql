DECLARE @QryColumns NVARCHAR(MAX);
DECLARE @CheckColumns NVARCHAR(MAX);
DECLARE @WhereClause NVARCHAR(MAX);
DECLARE @EndQuery NVARCHAR(MAX);

Select @QryColumns = STRING_AGG(QUOTENAME(Column_Name), ', ')
    From Information_Schema.Columns
    Where Table_Name = 'Table'
        AND Column_Name Like 'Column%';

Select @CheckColumns = STRING_AGG('Case When [' + Column_Name + '] = ''Y'' Then ''' + Column_Name + ''' END', ', ')
    From Information_Schema.Columns
    Where Table_Name = 'Table'
        AND Column_Name LIKE 'Column%'

Select @WhereClause = STRING_AGG('[' + Column_Name + '] = ''y'' THEN ''' + Column_Name = ''' END', ', ')
    From Information_Schema.Columns
    Where Table_Name = 'Table'
        And Column_Name LIKE 'Column%'

Set @EndQuery = 'SELECT Column,' + @QryColumns + 'From Table where Column = '' '' AND (' + @WhereClause + ')';

Exec (@EndQuery)
