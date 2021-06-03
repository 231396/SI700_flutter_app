import 'package:flutter/material.dart';
import 'package:flutter_app/data/database_web_server.dart';
import 'package:flutter_app/logic/login/login_bloc.dart';
import 'package:flutter_app/logic/login/login_bloc_event.dart';
import 'package:flutter_app/logic/login/login_bloc_state.dart';
import 'package:flutter_app/model/person.dart';
import 'package:flutter_app/view/MainScreen/profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
	void initState(){
		super.initState();
		DatabaseWebServer.helper.getAllPerson().then((value) {
			print(value.length);
			for (var i = 0; i < value.length; i++) 
				value[i].printPerson();
		});
	}

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
						submitBtn()
					],
				)
			),
		));
	}

	Widget submitBtn() => Container(
		padding: EdgeInsets.symmetric(vertical: 25.0),
		width: double.infinity,
		child: BlocListener<LoginBloc, LoginState>(
			listener: (context, state) {
				if(state is LoginSucessState){
					ScaffoldMessenger.of(context).hideCurrentSnackBar();
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Realizado com Sucesso')));
					Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileWidget(person: state.person)));
				}
			},
			child: ElevatedButton(
					style: ElevatedButton.styleFrom(
						elevation: 5,
						primary: Colors.white,
						padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
						shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
					),
					onPressed: () {
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tentando Logar')));
						if (formKeyLogin.currentState.validate()){
							formKeyLogin.currentState.save();
							BlocProvider.of<LoginBloc>(context).add(LoginEvent(person: person));
						}
						else
							ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Invalido')));
					},
					child: Text(
						"Entrar", 
						style: submitButtonStyle
					),
				),
		),
	);
}