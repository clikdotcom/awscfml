<cfscript>
filePath = expandPath("./demo.eml");

// Read raw RFC822 bytes
rawBytes = fileReadBinary(filePath);

props   = createObject("java","java.util.Properties").init();
mailsession = createObject("java","javax.mail.Session").getInstance(props);

input   = createObject("java","java.io.ByteArrayInputStream").init( rawBytes );
msg     = createObject("java","javax.mail.internet.MimeMessage").init(mailsession, input);


// writeDump( msg.getClass().getName() );
// 
RecipientType = createObject("java","javax.mail.Message$RecipientType");

// Basic headers
from    = msg.getFrom();              // array of Address
to      = msg.getRecipients( RecipientType.TO );
subject = msg.getSubject();
sentOn  = msg.getSentDate();

result = { plain="", html="" };
extractParts(msg, result);

result.from = isNull(from) ? [] : addrArrayToStrings(from);
result.to = isNull(to) ? [] : addrArrayToStrings(to);
result.subject = subject;
result.sentOn = sentOn;

writeDump(result);

// convert Java Native array to CFML array object
function addrArrayToStrings(addrs) {
  if (isNull(addrs)) return [];
  var out = [];
  for (a in addrs) arrayAppend(out, a.toString());
  return out;
}


function extractParts(part, result) {
    var ctype = lcase(part.getContentType());

    if (findNoCase("multipart/", ctype)) {
        var mp = part.getContent();
        for (var i=0; i < mp.getCount(); i++) {
            extractParts(mp.getBodyPart(i), result);
        }
        return;
    }

    if (findNoCase("text/plain", ctype)) {
        result.plain &= part.getContent();
        return;
    }

    if (findNoCase("text/html", ctype)) {
        result.html &= part.getContent();
        return;
    }
}


</cfscript>