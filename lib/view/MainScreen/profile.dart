import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget 
{
	@override
	Widget build(BuildContext context) {
		var user = Provider.of<UserModel>(context);
		return Container(
			width: double.infinity,
			decoration: containerBackground, 
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				crossAxisAlignment: CrossAxisAlignment.center,
				children:[
					boxedText("Nome", user.name),
					SizedBox(height: 30.0),
					boxedText("Email", user.email),
					SizedBox(height: 30.0),
					boxedText("Sexo", user.gender),
					SizedBox(height: 30.0),
					ElevatedButton(
						onPressed: () => logout(context), 
						child: Text("Logout", style: TextStyle(color: Colors.black),), 
						style: ElevatedButton.styleFrom(				
							elevation: 5,
							primary: Colors.white54
						),
					),
				],
			)
		);
	}

	void logout(BuildContext context) async{
		await Authentication.service.signOut();
	}

	Widget boxedText(String title, String text) => Column(
		crossAxisAlignment: CrossAxisAlignment.start,
		children:[
			Text("$title:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 )),
			Container(
				margin: EdgeInsets.symmetric(vertical: 6),
				padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
				width: 250.0,
				decoration: new BoxDecoration(
					color: Colors.white38,
					shape: BoxShape.rectangle,
					border: new Border.all(
						color: Colors.black,
						width: 1.0,
					),
				),
				child: Text("$text", style: TextStyle(fontSize: 14))
			)
		],
	);
	
	final containerBackground = BoxDecoration(
		gradient: LinearGradient(
			begin: Alignment.topCenter,
			end: Alignment.bottomCenter,
			colors: [
				Colors.green.shade400,
				Colors.green.shade800,
			],
		)
	);
}