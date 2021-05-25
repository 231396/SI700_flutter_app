import 'package:flutter/material.dart';
import 'package:flutter_app/model/person.dart';
import 'shared.dart';

class LoginWidget extends StatefulWidget {
	@override
	LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> 
{
	final formKeyLogin = GlobalKey<FormState>();

	Person person;

	bool rememberMe = false;
	bool showPassword = false;

	@override
	Widget build(BuildContext context){
		person = new Person();
		return SingleChildScrollView(child: Form(
			key: formKeyLogin,
			child: Container(
				height: 550,
				padding: EdgeInsets.symmetric(horizontal: 25.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children:[
						emailField((value) => person.email = value),
						SizedBox(height: 30.0),
						passwordField(showPassword, (value) => setState(() => showPassword = value), (value) => person.password = value),
						SizedBox(height: 10.0),
						// submitBtn()
					],
				)
			),
		));
	}

	// Widget submitBtn() => Container(
	// 	padding: EdgeInsets.symmetric(vertical: 25.0),
	// 	width: double.infinity,
	// 	child: BlocListener<LoginScreenBloc, LoginScreenState>(
	// 		listener: (context, state) {
	// 			// if(state is LoginScreenLoginState && state.person != null)
	// 			// 	Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileWidget(person: state.person)));
			  	
	// 			return ElevatedButton(
	// 				style: ElevatedButton.styleFrom(
	// 					elevation: 5,
	// 					primary: Colors.white,
	// 					padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
	// 					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
	// 				),
	// 				onPressed: () {
	// 					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tentando Logar')));
	// 					if (formKeyLogin.currentState.validate()){
	// 						formKeyLogin.currentState.save();
	// 						BlocProvider.of<LoginScreenBloc>(context).add(LoginEvent(person: person));
	// 					}
	// 					else
	// 						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Invalido')));
	// 				},
	// 				child: Text(
	// 					"Entrar", 
	// 					style: submitButtonStyle
	// 				),
	// 			);
	// 		},
	// 	),
	// );
}