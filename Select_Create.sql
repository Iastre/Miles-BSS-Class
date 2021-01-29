DECLARE @TableName VARCHAR(50);
SET @TableName = 'Tavern';

SELECT CONCAT('CREATE TABLE ', @TableName, '(')
UNION ALL
SELECT CONCAT(c.COLUMN_NAME, ' ', c.DATA_TYPE,
    (CASE WHEN c.CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN CONCAT('(', c.CHARACTER_MAXIMUM_LENGTH, ')') END),
	(CASE WHEN (tc.CONSTRAINT_TYPE = 'PRIMARY KEY') THEN
		' PRIMARY KEY'
	WHEN (tc.CONSTRAINT_TYPE = 'FOREIGN KEY') THEN
		CONCAT(' FOREIGN KEY REFERENCES ', key2.TABLE_NAME, '(', key2.COLUMN_NAME, ')')
		END),
	(CASE WHEN c.ORDINAL_POSITION IN (
	    SELECT COUNT(ORDINAL_POSITION) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = @TableName
	) THEN '' ELSE ',' END))
	--',')
	FROM INFORMATION_SCHEMA.COLUMNS c
	LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE key1 ON c.COLUMN_NAME = key1.COLUMN_NAME
	LEFT JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS rc ON key1.CONSTRAINT_NAME = rc.CONSTRAINT_NAME
	LEFT JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE key2 ON rc.UNIQUE_CONSTRAINT_NAME = key2.CONSTRAINT_NAME
	LEFT JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc ON key1.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
	WHERE c.TABLE_NAME = @TableName AND (key1.TABLE_NAME = @TableName OR key1.TABLE_NAME IS NULL)
UNION ALL
SELECT ');';
