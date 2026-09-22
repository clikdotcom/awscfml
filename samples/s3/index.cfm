<!---

Ad hoc testing script for various methods of S3 service

--->
<cfscript>

rootpath = "C:\git\clikpic\wwwroot\";
folder = "_common/_scripts/_adminScripts";

// test_listBigBucket();
//test_listBuckets();
// uploadedFiles = testMultiUpload();
// test_listSites();
// test_listBucket();
test_listBucketAll();
// test_deleteMulti( arraySlice(uploadedFiles,1,5) );
// test_getObject(uploadedFiles[6]);


function testMultiUpload() {
	keys = directoryList(path=rootpath & folder, recurse=false, listinfo="name");

	uploadedFiles = [];
	timings = [];
	
	for (i=1 ; i lte 10 ; i++ ) {
		ObjectKey = folder & "/" & keys[i];
		pathToFile = rootpath & ObjectKey;  
		uploadedFiles.append(ObjectKey);
		upload = request.prc.aws.s3.putObject( Bucket='cliksites-demo', ObjectKey=ObjectKey, fileContent=fileRead( pathToFile ), ContentType= fileGetMimeType( ObjectKey, false ) );
		timings.append(upload.responsetime);
	}

	writeOutput("<p>Average time:" & timings.avg() & "</p>");

	return uploadedFiles;
}

function test_getObject(filename) {
	object = request.prc.aws.s3.getObject( Bucket='cliksites-demo', ObjectKey=arguments.filename );
	writeDump(object);
}


function test_listBuckets() {
	buckets = request.prc.aws.s3.listBuckets();
	writeDump(buckets);
}

function test_listSites() {
	exists = request.prc.aws.s3.listBucket( Bucket='sample.clikpic.com', Delimiter="/" );
	writeDump(exists);
}

function test_listBucket() {
	exists = request.prc.aws.s3.listBucket( Bucket='cliksites-demo', Prefix="_common/" );
	
	for (i in exists.data.contents) {
		writeOutput(i.Key & "<br>");
	}
}

function test_listBucketAll() {
	exists = request.prc.aws.s3.listBucket( Bucket='cliksites-demo' );
	
	for (i in exists.data.contents) {
		writeOutput(i.Key & "<br>");
	}
}

function test_listBigBucket() {
	truncated = true;
	files = [];
	opts = {"Bucket"="preview.clikcraft.com", "region"="eu-west-1",prefix="_common"};
	while ( truncated ) {
		res =  request.prc.aws.s3.listBucketV2( argumentCollection = opts );

		if (res.data.keyCount ? : 0) {
			for (row in res.data.contents) {
				files.append(row.key);
			}
		}
		if (res.data.IsTruncated ? : false) {
			opts["ContinuationToken"] =  res.data.NextContinuationToken;
		}
		else {
			truncated = false;
		}
	}

	writeDump(files);
	// writeOutput(exists.len())
}

function test_deleteMulti(filenames) {
	delete = request.prc.aws.s3.deleteMultipleObjects( Bucket='cliksites-demo', ObjectKeys=arguments.filenames, Quiet=true );
	writeDump(delete);
}

function test_deleteObject(filename) {
	delete = request.prc.aws.s3.deleteObject( Bucket='cliksites-demo', ObjectKey=arguments.filename );
	writeDump(delete);
}




</cfscript>