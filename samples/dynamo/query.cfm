<cfscript>
table = "articles_test2";


// NB here difference to documentation. Specifying the datatype doesn't seem to work.
ExpressionAttributeValues = {
	":s1" : "1",
	":s2" : "2"
}

stopwatch variable="timer" {
		data = request.prc.aws.dynamodb.query(TableName=table,KeyConditionExpression="sites_id = :s1 and section_id = :s2",ExpressionAttributeValues=ExpressionAttributeValues, projectionExpression='articles_id, headline, pubdate, strapline', indexName='section_id-index', consistentRead=true);
}

writeDump(data);
writeDump(timer);

</cfscript>