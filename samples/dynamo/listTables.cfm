<cfscript>
tables = request.prc.aws.dynamodb.listTables();
writeDump(tables);
</cfscript>