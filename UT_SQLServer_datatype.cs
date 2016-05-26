using System.Data;

/*
https://paultebraak.wordpress.com/2015/01/14/biml-xix-creating-a-staging-area-using-biml/
*/

public static class UT_SQLServer_datatype {

	public static string RowConversion(DataRow Row)
	{
		string _ret = "[" + Row["COLUMN_NAME"] + "] " + Row["DATA_TYPE"];
 
 
		switch (Row["DATA_TYPE"].ToString().ToUpper())
		{
			case "NVARCHAR":
			case "VARCHAR":
			case "NCHAR":
			case "CHAR":
			case "BINARY":
			case "VARBINARY":
				if (Row["CHARACTER_MAXIMUM_LENGTH"].ToString() == "-1")
					_ret += "(max)";
				else
					_ret += "(" + Row["CHARACTER_MAXIMUM_LENGTH"] + ")";
				break;
 
			case "NUMERIC":
			case "DECIMAL":
				_ret += "(" + Row["NUMERIC_PRECISION"] + "," + Row["NUMERIC_SCALE"] + ")";
				break;

			case "FLOAT":
				_ret += "(" + Row["NUMERIC_PRECISION"] + ")";
				break;
		}
   
		return _ret;
	}


	
	public static string SQLServerToBimlDatatype(string datatype)
	{
		string _ret = "";
 		switch (datatype.ToLower())
		{
			case "bigint": _ret="Int64"; break;
			case "binary": _ret="Binary"; break;
			case "bit": _ret="Boolean"; break;
			case "char": _ret="AnsiStringFixedLength"; break;
			case "date": _ret="Date"; break;
			case "datetime": _ret="DateTime"; break;
			case "datetime2": _ret="DateTime2"; break;
			case "datetimeoffset": _ret="DateTimeOffset"; break;
			case "decimal": _ret="Decimal"; break;
			case "float": _ret="Double"; break;
			case "geography": _ret="Object"; break;
			case "geometry": _ret="Object"; break;
			case "hierarchyid": _ret="Object"; break;
			case "image": _ret="Binary"; break;
			case "int": _ret="Int32"; break;
			case "money": _ret="Currency"; break;
			case "nchar": _ret="StringFixedLength"; break;
			case "ntext": _ret="String"; break;
			case "numeric": _ret="Decimal"; break;
			case "nvarchar": _ret="String"; break;
			case "real": _ret="Single"; break;
			case "rowversion": _ret="Binary"; break;
			case "smalldatetime": _ret="DateTime"; break;
			case "smallint": _ret="Int16"; break;
			case "smallmoney": _ret="Currency"; break;
			case "sql_variant": _ret="Object"; break;
			case "text": _ret="AnsiString"; break;
			case "time": _ret="Time"; break;
			case "timestamp": _ret="Binary"; break;
			case "tinyint": _ret="Byte"; break;
			case "uniqueidentifier": _ret="Guid"; break;
			case "varbinary": _ret="Binary"; break;
			case "varchar": _ret="AnsiString"; break;
			case "xml": _ret="Xml"; break;
		}
		return _ret;
	}


	
} 

