<cfscript>

// SES v2 SendBulkEmail payload
// 
recipients = {
      "tom@tompeerconsulting.com" =  {
        "first"="consult","last"="consultlast", "id"=1
      },
      "tom@clik.com" =  {
        "first"="clik","last"="cliklast", "id"=2
      },
      "tom@digitalmethod.co.uk" =  {
        "first"="digital","last"="digitallast", "id"=3
      },
      "tom.peer@gmail.com" =  {
        "first"="tom","last"="glast", "id"=4
      }
};

BulkEmailEntries = [];
for (user in recipients) {
  BulkEmailEntries.append({
    "Destination" = { "ToAddresses" = [ user ]  },
    "ReplacementEmailContent" = {
        "ReplacementTemplate" = {
          "ReplacementTemplateData" =  SerializeJson( recipients[user] )
        }
      }
  });
}

templateContent  = {
  "Subject" = "Hello {{first}} {{last}} — your code is {{id}}",
  "Text"    = "Hi {{first}} {{last}},#newLine()##newLine()#Your code is {{id}}.#newLine()##newLine()#Thanks,#newLine()#Clik",
  "Html"    = "<p>Hi {{first}} {{last}},</p><p>Your code is <b>{{id}}</b>.</p><p>Thanks,<br>Clik</p>"
}; 

DefaultContent  = {

  "Template" = {
      "TemplateContent" = templateContent,
      // Optional default data if a recipient doesn't override a variable:
      "TemplateData" = serializeJSON( { "first"="", "id"="(missing)" } )
  }
}


payload = {
  "FromEmailAddress" = "message-responses@clikmessages.com",
  "BulkEmailEntries" = BulkEmailEntries,
  "DefaultContent" = DefaultContent
};

// writeOutput(htmlcodeFormat( serializeJSON(payload) ) );


res =  request.prc.aws.ses.sendBulkEmail( argumentCollection = payload );

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