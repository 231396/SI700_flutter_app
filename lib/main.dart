import 'package:flutter/material.dart';
import 'package:flutter_app/view/LoginScreen/screen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) => MaterialApp(
		theme: ThemeData(primaryColor: Colors.yellow.shade700),
		home: LoginSingupScreen(),
	);
}