<cfscript>

function getMailboxValidation(required string email) {

  var res = request.prc.aws.ses.validateEmail(arguments.email);

  writeDump(res);abort;
  if (res.statusCode != 200) {
    throw(
      type    = "SES.GetEmailAddressInsightsFailed",
      message = "GetEmailAddressInsights failed (HTTP #res.statusCode#)",
      detail  = res.rawData
    );
  }

  var data = deserializeJSON(res.rawData);

  // data.MailboxValidation contains the verdict + evaluations
  return data.MailboxValidation;
}

// e.w.u.z.e.d.a.zu.w.4.4@gmail.com
// ofok.i.holaw.0.4@gmail.com
// i.ve.w.o.c.ahu1.48@gmail.com
// olofub.oco.s85@gmail.com

// Example
mv = getMailboxValidation("e.w.u.z.e.d.a.zu.w.4.4@gmail.com");
writeDump(mv);

// Typical fields you’ll use:
// overall = mv.IsValid.ConfidenceVerdict;                 // HIGH / MEDIUM / LOW (string)
// exists  = mv.Evaluations.MailboxExists.ConfidenceVerdict;
// syntax  = mv.Evaluations.HasValidSyntax.ConfidenceVerdict;
// dns     = mv.Evaluations.HasValidDnsRecords.ConfidenceVerdict;
// role    = mv.Evaluations.IsRoleAddress.ConfidenceVerdict;
// disp    = mv.Evaluations.IsDisposable.ConfidenceVerdict;
// rand    = mv.Evaluations.IsRandomInput.ConfidenceVerdict;
</cfscript>