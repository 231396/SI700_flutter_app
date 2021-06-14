import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/view/page_selector.dart';

void main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp();
  	runApp(MainApp());
}

class MainApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) => MaterialApp(
		theme: ThemeData(primaryColor: Colors.yellow.shade700),
		home: PageSelector(),
	);
}