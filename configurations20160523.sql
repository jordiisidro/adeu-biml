USE [master]
GO
/****** Object:  Database [Configurations]    Script Date: 5/23/2016 8:59:17 PM ******/
CREATE DATABASE [Configurations]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Configurations', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Configurations.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Configurations_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Configurations_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Configurations] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Configurations].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Configurations] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Configurations] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Configurations] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Configurations] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Configurations] SET ARITHABORT OFF 
GO
ALTER DATABASE [Configurations] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Configurations] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Configurations] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Configurations] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Configurations] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Configurations] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Configurations] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Configurations] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Configurations] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Configurations] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Configurations] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Configurations] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Configurations] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Configurations] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Configurations] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Configurations] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Configurations] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Configurations] SET RECOVERY FULL 
GO
ALTER DATABASE [Configurations] SET  MULTI_USER 
GO
ALTER DATABASE [Configurations] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Configurations] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Configurations] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Configurations] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Configurations] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Configurations', N'ON'
GO
USE [Configurations]
GO
/****** Object:  Schema [biml]    Script Date: 5/23/2016 8:59:17 PM ******/
CREATE SCHEMA [biml]
GO
/****** Object:  Schema [trash]    Script Date: 5/23/2016 8:59:17 PM ******/
CREATE SCHEMA [trash]
GO
/****** Object:  UserDefinedFunction [dbo].[UFN_SEPARATES_COLUMNS]    Script Date: 5/23/2016 8:59:17 PM ******/
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
/****** Object:  Table [biml].[project]    Script Date: 5/23/2016 8:59:17 PM ******/
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
/****** Object:  Table [biml].[source]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_column]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_column_flatFile_fixed]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_database]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_database_table]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_database_table_index]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_database_table_index_column]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_detail]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_excel]    Script Date: 5/23/2016 8:59:18 PM ******/
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
 CONSTRAINT [pk_biml_source_excel] PRIMARY KEY CLUSTERED 
(
	[source_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [biml].[source_excel_table]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_extract_type]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_flatFile]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_FlatFile_folder]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [biml].[source_type]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  Table [trash].[flatFile]    Script Date: 5/23/2016 8:59:18 PM ******/
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
/****** Object:  StoredProcedure [dbo].[fn_generateColumnsFF]    Script Date: 5/23/2016 8:59:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [dbo].[fn_generateColumnsFF](@separator varchar(50), @endLine varchar(50), @1strowcol bit, @sourceDetailId int)
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
USE [master]
GO
ALTER DATABASE [Configurations] SET  READ_WRITE 
GO
