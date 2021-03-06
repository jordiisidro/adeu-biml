USE [Configurations]
GO
/****** Object:  Schema [biml]    Script Date: 6/28/2016 9:27:02 PM ******/
CREATE SCHEMA [biml]
GO
/****** Object:  Schema [trash]    Script Date: 6/28/2016 9:27:02 PM ******/
CREATE SCHEMA [trash]
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_SEPARATES_COLUMNS]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[UFN_SEPARATES_COLUMNS](
 @TEXT      varchar(8000)
,@COLUMN    tinyint
,@SEPARATOR char(1)
)RETURNS varchar(8000)
AS
  BEGIN
       DECLARE @POS_START  int = 1
       DECLARE @POS_END    int = CHARINDEX(@SEPARATOR, @TEXT, @POS_START)

       WHILE (@COLUMN >1 AND @POS_END> 0)
         BEGIN
             SET @POS_START = @POS_END + 1
             SET @POS_END = CHARINDEX(@SEPARATOR, @TEXT, @POS_START)
             SET @COLUMN = @COLUMN - 1
         END 

       IF @COLUMN > 1  SET @POS_START = LEN(@TEXT) + 1
       IF @POS_END = 0 SET @POS_END = LEN(@TEXT) + 1 

       RETURN SUBSTRING (@TEXT, @POS_START, @POS_END - @POS_START)
  END


GO
/****** Object:  Table [biml].[folder]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[folder](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[path_origin] [varchar](500) NULL,
	[path_destination] [varchar](500) NULL,
	[pattern] [varchar](50) NULL,
	[expression_date] [varchar](50) NULL,
	[var_days] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[ftp]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[ftp](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[server] [varchar](15) NULL,
	[username] [varchar](50) NULL,
	[password] [varchar](50) NULL,
	[port] [tinyint] NULL,
	[type] [varchar](50) NULL,
	[path_destination] [varchar](500) NULL,
	[pattern] [varchar](50) NULL,
	[expression_date] [varchar](50) NULL,
	[var_days] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[project]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[project](
	[project_id] [smallint] IDENTITY(1,1) NOT NULL,
	[project_name] [varchar](200) NULL,
	[project_short_name] [varchar](10) NULL,
	[sa_connection_name] [varchar](200) NULL,
	[sa_connection_string] [varchar](4000) NULL,
	[dwh_connection_name] [varchar](200) NULL,
	[dwh_connection_string] [varchar](4000) NULL,
	[sa_hasParameter] [bit] NULL,
 CONSTRAINT [pk_biml_project] PRIMARY KEY CLUSTERED 
(
	[project_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source](
	[source_id] [smallint] IDENTITY(1,1) NOT NULL,
	[project_id] [smallint] NULL,
	[source_name] [varchar](200) NULL,
	[source_type] [tinyint] NULL,
	[short_name] [varchar](10) NULL,
	[hasParameter] [bit] NULL,
 CONSTRAINT [pk_biml_data_source] PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_column]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_column](
	[source_column_id] [smallint] IDENTITY(1,1) NOT NULL,
	[source_detail_id] [smallint] NULL,
	[column_name] [varchar](200) NULL,
	[data_type] [varchar](200) NULL,
	[character_maximum_length] [int] NULL,
	[numeric_precision] [smallint] NULL,
	[numeric_scale] [smallint] NULL,
	[ordinal_position] [smallint] NULL,
	[is_pk] [bit] NULL,
 CONSTRAINT [pk_source_column] PRIMARY KEY CLUSTERED 
(
	[source_column_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_column_flatFile_fixed]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biml].[source_column_flatFile_fixed](
	[source_column_id] [smallint] NOT NULL,
	[length] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[source_column_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [biml].[source_database]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_database](
	[source_id] [smallint] NOT NULL,
	[connectionString] [varchar](4000) NULL,
	[database_version] [varchar](300) NULL,
 CONSTRAINT [pk_biml_source_database] PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_database_table]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_database_table](
	[database_table_id] [smallint] NOT NULL,
	[database_id] [smallint] NULL,
	[table_name] [varchar](4000) NULL,
	[schema_name] [varchar](300) NULL,
 CONSTRAINT [PK_source_database_table] PRIMARY KEY CLUSTERED 
(
	[database_table_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_database_table_index]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_database_table_index](
	[database_table_index_id] [smallint] IDENTITY(1,1) NOT NULL,
	[database_table_id] [smallint] NOT NULL,
	[index_name] [varchar](500) NULL,
	[index_type] [varchar](500) NULL,
	[is_unique] [varchar](50) NULL,
 CONSTRAINT [PK_source_database_table_index] PRIMARY KEY CLUSTERED 
(
	[database_table_index_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_database_table_index_column]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biml].[source_database_table_index_column](
	[database_table_index_column_id] [smallint] IDENTITY(1,1) NOT NULL,
	[database_table_index_id] [smallint] NOT NULL,
	[column_id] [smallint] NULL,
	[column_ordinal] [smallint] NOT NULL,
	[is_include] [bit] NULL,
 CONSTRAINT [PK_source_database_table_index_column] PRIMARY KEY CLUSTERED 
(
	[database_table_index_column_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [biml].[source_detail]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [biml].[source_detail](
	[source_detail_id] [smallint] IDENTITY(1,1) NOT NULL,
	[source_id] [smallint] NULL,
	[extract_type] [smallint] NULL,
	[incremental_date_field] [smallint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [biml].[source_excel]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_excel](
	[source_id] [smallint] NOT NULL,
	[provider_name] [varchar](4000) NULL,
	[version_provider] [varchar](300) NULL,
	[file_connection_string] [varchar](300) NULL,
	[load_multiple_sheets] [bit] NULL,
 CONSTRAINT [pk_biml_source_excel] PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_excel_table]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_excel_table](
	[excel_table_id] [smallint] NOT NULL,
	[excel_id] [smallint] NULL,
	[sheet_name] [varchar](4000) NULL,
 CONSTRAINT [PK_source_excel_table] PRIMARY KEY CLUSTERED 
(
	[excel_table_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_extract_type]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_extract_type](
	[id_source_extract_type] [tinyint] IDENTITY(1,1) NOT NULL,
	[source_extract_type_name] [varchar](200) NULL,
 CONSTRAINT [pk_biml_source_extract_type] PRIMARY KEY CLUSTERED 
(
	[id_source_extract_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_flatFile]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_flatFile](
	[source_id] [smallint] NOT NULL,
	[path] [varchar](4000) NULL,
	[name] [varchar](4000) NULL,
	[type] [varchar](50) NULL,
	[text_qualifier] [char](1) NULL,
	[row_delimiter] [varchar](10) NULL,
	[header_rows_to_skip] [smallint] NULL,
	[is_column_names_first_row] [bit] NULL,
	[separator] [varchar](10) NULL,
	[is_unicode] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_FlatFile_folder]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_FlatFile_folder](
	[source_id] [smallint] NOT NULL,
	[pattern] [varchar](50) NULL,
	[traverse_subfolders] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_type]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[source_type](
	[id_source_type] [tinyint] IDENTITY(1,1) NOT NULL,
	[source_type_name] [varchar](200) NULL,
 CONSTRAINT [pk_biml_source_type] PRIMARY KEY CLUSTERED 
(
	[id_source_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[unzip]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [biml].[unzip](
	[id] [smallint] IDENTITY(1,1) NOT NULL,
	[path_application] [varchar](500) NULL,
	[path_file_compressed] [varchar](500) NULL,
	[pattern] [varchar](50) NULL,
	[expression_date] [varchar](50) NULL,
	[var_days] [smallint] NULL,
	[path_destination] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [trash].[flatFile]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [trash].[flatFile](
	[C1] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_generateColumnsFF]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[sp_generateColumnsFF](@separator varchar(50), @endLine varchar(50), @1strowcol bit, @sourceDetailId int)
as
declare @i smallint
declare @ln smallint
declare @1strow varchar(8000)

set @endLine = replace(@endLine, 'CR',char(10))
set @endLine = replace(@endLine, 'LF',char(13))

select top 1 @1strow=c1
from  trash.flatFile

select  @ln= len(@1strow )-len(replace(@1strow , @separator,''))+1
from  trash.flatFile



set @i =1
while (@i<=@ln) begin

insert into biml.source_column (source_detail_id, column_name, data_type, character_maximum_length, ordinal_position, is_pk)
select d.source_detail_id,
case when @1strowcol=1 then [dbo].[UFN_SEPARATES_COLUMNS] (@1strow, @i, @separator) else 'col'+cast(@i as varchar(20)) end , 'varchar', 8000,@i,0
from biml.source_detail d
where d.source_detail_id=@sourceDetailId
set @i =@i+1
end
GO
/****** Object:  StoredProcedure [dbo].[sp_generateSheetsExcel]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_generateSheetsExcel] (@sourceId int) as

-- Get table (worksheet) or column (field) listings from an excel spreadsheet
DECLARE @linkedServerName sysname = 'TempExcelSpreadsheet'
DECLARE @excelFileUrl nvarchar(1000)

select @excelFileUrl=file_connection_string
from biml.source_excel
where source_id=@sourceId

declare @sheetName varchar(100)


IF OBJECT_ID('tempdb..#MyTempTable') IS NOT NULL
DROP TABLE #MyTempTable;

-- Remove existing linked server (if necessary)
if exists(select null from sys.servers where name = @linkedServerName) begin
exec sp_dropserver @server = @linkedServerName, @droplogins = 'droplogins'
end

-- Add the linked server
-- ACE 12.0 seems to work for both xsl and xslx, though some might prefer the older JET provider
exec sp_addlinkedserver
@server = @linkedServerName,
@srvproduct = '',
@provider = 'Microsoft.ACE.OLEDB.12.0',
@datasrc = @excelFileUrl,
@provstr = 'Excel 12.0;HDR=Yes'

-- Grab the current user to use as a remote login
DECLARE @suser_sname NVARCHAR(256) = SUSER_SNAME()

-- Add the current user as a login
EXEC SP_ADDLINKEDSRVLOGIN
@rmtsrvname = @linkedServerName,
@useself = 'false',
@locallogin = @suser_sname,
@rmtuser = null,
@rmtpassword = null

-- Return the table info, each worksheet pbb gets its own unique name
SELECT * INTO #MyTempTable FROM OPENROWSET('SQLNCLI', 'Server=(local);Trusted_Connection=yes;',
'EXEC sp_tables_ex TempExcelSpreadsheet');


delete from biml.source_column 
where exists (
	select * 
	from biml.source_excel_table e 
	where e.excel_id=@sourceId
	and e.excel_id=source_column.source_detail_id)
delete from biml.source_excel_table where excel_id=@sourceId
delete from biml.source_detail where source_id=@sourceId


DECLARE db_cursor CURSOR FOR  
SELECT TABLE_NAME
FROM #MyTempTable

SELECT TABLE_NAME
FROM #MyTempTable

OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @sheetName  

WHILE @@FETCH_STATUS = 0  
BEGIN  
       insert into biml.source_detail (source_id, extract_type) 
	   select @sourceId, e.id_source_extract_type
	   from biml.source_extract_type e
	   where e.source_extract_type_name='Full'
	   insert into biml.source_excel_table values (IDENT_CURRENT('biml.source_detail'), @sourceId, @sheetName)
       FETCH NEXT FROM db_cursor INTO @sheetName  
END  

CLOSE db_cursor  
DEALLOCATE db_cursor 


-- Remove temp linked server
if exists(select null from sys.servers where name = @linkedServerName) begin
exec sp_dropserver @server = @linkedServerName, @droplogins = 'droplogins'
end

/*
select *
from biml.source_detail

select *
from biml.source_excel_table


select *
from biml.source_excel

*/
GO
/****** Object:  Trigger [biml].[trg_source_database_table]    Script Date: 6/28/2016 9:27:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create trigger [biml].[trg_source_database_table] on [biml].[source_database_table] instead of insert as
	 declare @database_id smallint
	 declare @table_name varchar(4000)
	 declare @schema_name varchar(300)

	dECLARE db_cursor CURSOR FOR  
	SELECT [database_id], [table_name],[schema_name]
	FROM inserted
	

	OPEN db_cursor  
	FETCH NEXT FROM db_cursor INTO @database_id , @table_name, @schema_name
		
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
		  insert into biml.source_detail (source_id) values  (@database_id)
		  insert into biml.source_database_table ([database_table_id],[database_id],[table_name],[schema_name])
		   values  (IDENT_CURRENT('biml.source_detail'), @database_id, @table_name,@schema_name  ) 

		   FETCH NEXT FROM db_cursor INTO @database_id , @table_name, @schema_name  
	END  

	CLOSE db_cursor  
	DEALLOCATE db_cursor 
GO
