import 'package:flutter/material.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/view/MainScreen/screen.dart';
import 'shared.dart';

class LoginWidget extends StatefulWidget {
	@override
	LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> 
{
	final formKeyLogin = GlobalKey<FormState>();

	final User user = new User();

	bool rememberMe = false;
	bool showPassword = false;

	@override
	Widget build(BuildContext context) => SingleChildScrollView(child: Form(
		key: formKeyLogin,
		child: Container(
			height: 550,
			padding: EdgeInsets.symmetric(horizontal: 25.0),
			child: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children:[
					emailField((value) => user.email = value),
					SizedBox(height: 30.0),
					passwordField(showPassword, (value) => setState(() => showPassword = value), (value) => user.password = value),
					SizedBox(height: 10.0),
					submitBtn()
				],
			)
		),
	));

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
			onPressed: () {
				if (formKeyLogin.currentState.validate()){
					//TODO - REQUEST LOGIN
					if(true){

						Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
					}
					else
      // ignore: dead_code
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Invalido')));
				}
				else
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Formulario Invalido')));
			},
			child: Text("Logar", style: submitButtonStyle),
		),
	);
}