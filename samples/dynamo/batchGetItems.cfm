<cfscript>
table = "articles_test2";

keys = [];

for (articles_id =1 ; articles_id lt 10 ; articles_id++) {
	keys.append({
		"sites_id" = 1,
		"articles_id" = articles_id
	});
}

keys.append({
	"sites_id" = 100018,
	"articles_id" = 1764535
});

RequestItems = {
	"#table#" = {
		"Keys" = keys,
		"ProjectionExpression" = "articles_id, headline, pubdate"
	},
}

writeDump(RequestItems);

data = request.prc.aws.dynamodb.batchGetItem(TableName=table,RequestItems=RequestItems, consistentRead=true);

writeDump(data);


</cfscript>