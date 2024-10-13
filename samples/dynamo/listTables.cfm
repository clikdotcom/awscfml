<cfscript>
tables = request.prc.aws.dynamodb.listTables();
writeDump(tables);
for (table in tables.data.tableNames) {
	tabledata = request.prc.aws.dynamodb.describeTable(table);
	writeDump(tabledata);
}
</cfscript>