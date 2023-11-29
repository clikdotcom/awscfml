<cfscript>
buckets = request.prc.aws.s3.listBuckets();
writeDump(buckets);
</cfscript>