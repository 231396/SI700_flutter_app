import 'package:flutter/material.dart';
import 'package:flutter_app/model/user_auth.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'shared.dart';

class LoginWidget extends StatefulWidget {
	@override
	LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> 
{
	final formKeyLogin = GlobalKey<FormState>();

	String email = "";
	String password = "";

	bool showPassword = false;

	@override
	Widget build(BuildContext context) {
		var user = Provider.of<UserAuth>(context);
		print("AAA " + user.toString());
	  return SingleChildScrollView(child: Form(
		key: formKeyLogin,
		child: Container(
			height: 550,
			padding: EdgeInsets.symmetric(horizontal: 25.0),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children:[
					emailField((value) => email = value),
					SizedBox(height: 30.0),
					passwordField(showPassword, (value) => setState(() => showPassword = value), (value) => password = value),
					SizedBox(height: 10.0),
					submitBtn()
				],
			)
		),
	));
	}

	Widget submitBtn() => Container(
		padding: EdgeInsets.symmetric(vertical: 25.0),
		width: double.infinity,
		child: ElevatedButton(
			style: ElevatedButton.styleFrom(
				elevation: 5,
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
				shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
			),
			onPressed: () async {
				if (formKeyLogin.currentState.validate()){
					formKeyLogin.currentState.save();
					// var user = await Authentication.service.loginAnonymous();
					var user = await Authentication.service.loginEmailAndPassword(email, password);
					if(user != null){
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Bem Sucedido')));
					}
					else
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Invalido')));
				}
				else
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Formulario Invalido')));
			},
			child: Text("Logar", style: submitButtonStyle),
		),
	);
}