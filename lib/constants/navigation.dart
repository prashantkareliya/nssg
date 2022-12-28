import 'package:flutter/material.dart';

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
