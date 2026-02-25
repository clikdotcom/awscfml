<cfscript>

// SES v2 SendEmail payload
payload = {
  "FromEmailAddress" = "message-responses@clikmessages.com",
  "Destination" = {
    "ToAddresses" = [ "tom@tompeerconsulting.com" ]
  },
  "Content" = {
    "Simple" = {
      "Subject" = { "Data" = "Hello from Lucee + SES", "Charset" = "UTF-8" },
      "Body" = {
        "Text" = { "Data" = "Plain-text body", "Charset" = "UTF-8" },
        "Html" = { "Data" = "<h1>HTML body</h1><p>Hi there.</p>", "Charset" = "UTF-8" }
      }
    }
  }
};

res =  request.prc.aws.ses.sendEmail( argumentCollection = payload );

if ( res.statusCode != 200 ) {
  // SES returns useful error info in rawData for non-200 responses
  throw(
    type = "SES.SendEmailFailed",
    message = "SES sendEmail failed (HTTP #res.statusCode#)",
    detail = res.rawData
  );
}

// success response includes MessageId
writeDump(res.data);


</cfscript>