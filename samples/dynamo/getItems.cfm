<cfscript>
table = "articles_test2";


key = {
	"sites_id" = 1,
	"articles_id" = 2
};

data = request.prc.aws.dynamodb.getitem(TableName=table,key=key, consistentRead=true);

writeDump(data);


</cfscript>