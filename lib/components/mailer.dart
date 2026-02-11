import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:nak_app/components/text.dart';

/// This mailer package requires that you enable "less secure app access" in the Gmail account settings for the email address you want to send from. This is not ideal, but it is a free and simple solution for sending emails from the app without setting up a backend server. For better security, consider using a backend service to handle email sending with proper authentication.

// Google NAK-App Password for incidentreport@nakinc.org
// safb ndlq kapy uiya
sendEmail(BuildContext context, Map formCtl) async {
  String username = 'incidentreport@nakinc.org';
  String password = 'safb ndlq kapy uiya';
  // String password = 'xrcr lrvs bthe olnw';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, '${formCtl['name']}')
    ..recipients.add('incidentreport@nakinc.org')
    ..subject = 'INCIDENT REPORT FORM: ${formCtl['nature']}'
    ..text = 'Hello ${formCtl['name']}, all is working well!'
    ..html = '<h2>INCIDENT REPORT FORM</h2>'
    '<p>From: ${formCtl['name']} &#60;${formCtl['email']}&#62;</p>'
    '<p>Subject: INCIDENT REPORT FORM: ${formCtl['nature']}</p>'
    '<p>Origin: submitted via the NAK APP.</p><br/>'
    '<p><b>Your Name:</b><br/> ${formCtl['name']}</p>'
    '<p><b>Your Email:</b><br/> ${formCtl['email']}</p>'
    '<p><b>Nature of Incident:</b><br/> ${formCtl['nature']}</p>'
    '<p><b>Urgency of Incident:</b><br/> ${formCtl['urgency']}</p>'
    '<p><b>Date of Incident:</b><br/> ${formCtl['date']}</p>'
    '<p><b>Location of Incident:</b><br/> ${formCtl['location']}</p>'
    '<p><b>Description of Incident:</b><br/> ${formCtl['desc']}</p>'
    '<p><b>Was a report filed with your campus or university?</b><br/> ${formCtl['uni']}</p>'
    '<p><b>Did police respond?</b><br/> ${formCtl['police']}</p>'
    '<p><b>Would like to receive a follow-up?</b><br/> ${formCtl['followUp']}</p>'
    '$confidentiality';

  try {
    // message sent
    await send(message, smtpServer);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(
        content: Text('Report sent successfully!',)
      ));
    }
  } on MailerException catch (e) {
    // Message not sent
    String msg = '';
    for (var p in e.problems) {
      // print('Problem: ${p.code}: ${p.msg}');
      msg += p.msg;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
        content: Text('Error: $msg',))
      );
    }
  }
}

// Sends an email using the form in the version screen.
// Google NAK-App Password for developer@nakinc.org
// qqsp njae ydbb ubcb
sendContactEmail(BuildContext context, Map formCtl) async {
  String username = 'developer@nakinc.org';
  String password = 'qqsp njae ydbb ubcb';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, '${formCtl['name']}')
    ..recipients.add('developer@nakinc.org')
    ..subject = 'NAK APP CONTACT: ${formCtl['subject'] ?? 'General Inquiry'}'
    ..text = '${formCtl['message'] ?? ''}\n\nFrom: ${formCtl['name']} <${formCtl['email']}> '
    ..html = '<h2>Contact Form Submission</h2>'
      '<p><b>From:</b> ${formCtl['name']} &#60;${formCtl['email']}&#62;</p>'
      '<p><b>Subject:</b> ${formCtl['subject'] ?? 'General Inquiry'}</p>'
      '<p><b>Message:</b><br/> ${formCtl['message'] ?? ''}</p>';

  try {
    await send(message, smtpServer);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Message sent successfully!'),
      ));
    }
  } on MailerException catch (e) {
    String msg = '';
    for (var p in e.problems) {
      msg += p.msg;
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error sending message: $msg'),
      ));
    }
  }
}