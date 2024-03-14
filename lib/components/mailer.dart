import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:nak_app/components/text.dart';

// Google NAK-App Password
// xrcr lrvs bthe olnw
sendEmail(BuildContext context, Map formCtl) async {
  String username = 'sandro.aguilar@nakinc.org';
  String password = 'xrcr lrvs bthe olnw';

  final smtpServer = gmail(username, password);

  final message = Message()
    ..from = Address(username, '${formCtl['name']}')
    ..recipients.add('sandro.aguilar@nakinc.org')
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
    ScaffoldMessenger.of(context)
      .showSnackBar(const SnackBar(
        content: Text('Report sent successfully!',)
      ));
  } on MailerException catch (e) {
    // Message not sent
    String msg = '';
    for (var p in e.problems) {
      // print('Problem: ${p.code}: ${p.msg}');
      msg += p.msg;
    }
    ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(
        content: Text('Error: $msg',))
      );
  }
}