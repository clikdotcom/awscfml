<cfscript>
cfsetting(requesttimeout="5000" );
param name="url.last_entry" default="";
response = request.prc.aws.s3.listBucket("Bucket"="alexcartoon","Marker"=url.last_entry,maxKeys=0);
outputFolder = expandPath("_output/");
outputText = [];
processed = {};
response.data.Contents.each(
	function( cartoon ) {
	local.image = {"S3Object": {"Bucket"="alexcartoon","Name"=arguments.cartoon.Key }};
	local.text = request.prc.aws.rekognition.detectText(local.image);
	if (local.text.keyExists("statusCode") && local.text.statusCode == 200) {
		local.res = [];
		for (local.textDetection in local.text.data.TextDetections) {
			if (! local.textDetection.keyExists("parentID")) {
				local.res.append(local.textDetection.detectedText);
			}
		}
		local.status = "ok";
		try {
			FileWrite(outputFolder & arguments.cartoon.Key & ".txt", res.toList( newLine() ) );
		}
		catch (any e) {
			writeOutput("unable to write file #arguments.cartoon.Key#<br>");	
		}
	}
	else {
		local.status = "failed";
	}
	processed[arguments.cartoon.Key] = 1;
	outputText.append(arguments.cartoon.Key & " " & local.status);
},true, 20);

entries = structKeyArray(processed);
writeDump(entries);
arraySort(entries,"textnocase");
lastEntry = arrayLast(entries);

writeOutput("<pre>" & outputText.toList(newLine()) & "</pre>");

writeOutput("<p><a href='?last_entry=#lastEntry#'>Next</a></p>");


</cfscript>
