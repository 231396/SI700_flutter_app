import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_data.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

import 'LoginScreen/screen.dart';
import 'MainScreen/screen.dart';

class PageSelector extends StatelessWidget {
	@override
	Widget build(BuildContext context) 
	{
		return StreamProvider<UserData>.value(
			initialData: null, 
			value: Authentication.service.user, 
			child: PageSelectorWrapper(),
		);
	}
}

class PageSelectorWrapper extends StatelessWidget
{
	@override
	Widget build(BuildContext context) 
	{
		final user = Provider.of<UserData>(context);
		return user == null ? LoginSingupScreen() : HomeScreen();
	}
}