import 'package:flutter/material.dart';

myPopUntilRouteName(BuildContext context, String routeName) {
  Navigator.of(context).popUntil((route) => route.settings.name == routeName);
}

mypopAndPushNamed(BuildContext context, String routeName) {
  Navigator.of(context).popAndPushNamed(routeName);
}
