import 'package:flutter/material.dart';
import 'package:flutter_app/view/MainScreen/screen.dart';
import 'shared.dart';

class LoginWidget extends StatefulWidget {
	@override
	LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> 
{
	final formKeyLogin = GlobalKey<FormState>();

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
					emailField(),
					SizedBox(height: 30.0),
					passwordField(showPassword: showPassword, onShowPasswordChange: (value) { setState(() => showPassword = value); }),
					SizedBox(height: 10.0),
					rememberMeCheckbox(),
					submitBtn("Entrar", formKeyLogin)
				],
			)
		),
	));

	Widget submitBtn(String btnText, GlobalKey<FormState> formKey) => Container(
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
				if (formKey.currentState.validate()){
					Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logando')));
				}
				else
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Invalido')));
			},
			child: Text(
				btnText, 
				style: submitButtonStyle
			),
		),
	);

	Widget rememberMeCheckbox() => Container(
		height: 20.0,
		child: Row(
			children: [
				Theme(
					data: ThemeData(unselectedWidgetColor: Colors.white),
					child: Checkbox(
					value: rememberMe,
						checkColor: Colors.green,
						activeColor: Colors.white,
						onChanged: (value) { setState(() => rememberMe = value); },
					),
				),
				Text('Lembrar', style: fieldLabelStyle),
			],
		),
	);
}