import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import 'package:open_mail_app/open_mail_app.dart';

//Navigation to next screen
void callNextScreen(BuildContext context, StatefulWidget nextScreen) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}

void removeAndCallNextScreen(BuildContext context, StatefulWidget nextScreen) {

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => nextScreen),
  );
}


void sendMail(String emailAddress, BuildContext context) async {
  var apps = await OpenMailApp.getMailApps();
  if (apps.isEmpty) {
    showNoMailAppsDialog(context);
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return MailAppPickerDialog(
          mailApps: apps,
          emailContent: EmailContent(
            to: [ emailAddress.toString()],
            subject: 'Hello!',
            body: '',
          ),
        );
      },
    );
  }
}

void showNoMailAppsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Open Mail App"),
        content: Text("No mail apps installed"),
        actions: <Widget>[
          TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    },
  );
}

void callFromApp(dataContact) {
  UrlLauncher.launch("tel://$dataContact");
}