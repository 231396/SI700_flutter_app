import 'package:flutter/material.dart';
import 'package:flutter_app/services/auth.dart';
import 'shared.dart';

class SingupWidget extends StatefulWidget {
	@override
	SingupWidgetState createState() => SingupWidgetState();
}

class SingupWidgetState extends State<SingupWidget> 
{
	final formKeySingup = GlobalKey<FormState>();

	String name = "";
	String email = "";
	String password = "";
	String gender = "";

	static const genderDropdownList = [
		DropdownMenuItem(value: 'M', child: Text('M')),
		DropdownMenuItem(value: 'F', child: Text('F')),
	];

	String genderDropdownChoice = genderDropdownList[0].value;
	bool showPassword = false;

	@override
	Widget build(BuildContext context) => SingleChildScrollView(
		padding: EdgeInsets.only(top: 20),
		child: Form(
			key: formKeySingup,
			child: Container(
				height: 550,
				padding: EdgeInsets.symmetric(horizontal: 25.0),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children:[
							defaultField("Nome", (value) => name = value),
							SizedBox(height: 30.0),
							emailField((value) => email = value),
							SizedBox(height: 30.0),
							genderDropdown((value) => gender = value),
							SizedBox(height: 30.0),
							passwordField(showPassword, (value) => setState(() => showPassword = value), (value) => password = value),
							submitBtn()
					],
				)
			),
		)
	);

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
				if (formKeySingup.currentState.validate()){
					formKeySingup.currentState.save();
					var user = Authentication.service.signupEmailAndPassword(email, password, name, gender);
					if (user != null)
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastrado com Sucesso')));
					else
						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastrado Falhou')));
				}
				else
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Formulario Invalido')));
			},
			child: Text("Cadastrar", 
				style: submitButtonStyle
			),
		),
	);

		Widget genderDropdown(void Function(String) onSave) => Row(
		mainAxisAlignment: MainAxisAlignment.start,
		crossAxisAlignment: CrossAxisAlignment.center,
		children: [
			Text("Gênero", style: fieldLabelStyle),
			SizedBox(width: 10),
			Container(
				padding: EdgeInsets.only(left: 10),
				decoration: fieldBoxDecoration,
				child: SizedBox(width: 40, child: DropdownButtonFormField<String>(
					value: genderDropdownChoice,
					iconSize: 24,
					style: const TextStyle(color: Colors.black),
					onChanged: (value) {
						setState(() => genderDropdownChoice = value);
					},
					onSaved: onSave,
					items: genderDropdownList,
				))
			),
		] 
	);
}