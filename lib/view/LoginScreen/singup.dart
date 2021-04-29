import 'package:flutter/material.dart';
import 'shared.dart';

class SingupWidget extends StatefulWidget {
	@override
	SingupWidgetState createState() => SingupWidgetState();
}

class SingupWidgetState extends State<SingupWidget> 
{
	final formKeySingup = GlobalKey<FormState>();
	String genderDropdownChoise = genderDropdownList[0].value;
	bool showPassword = false;

	static const genderDropdownList = [
		DropdownMenuItem(value: 'M', child: Text('M')),
		DropdownMenuItem(value: 'F', child: Text('F')),
	];

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
						defaultField("Nome"),
						SizedBox(height: 30.0),
						emailField(),
						SizedBox(height: 30.0),
						genderDropdown(),
						SizedBox(height: 30.0),
						passwordField(showPassword: showPassword, onShowPasswordChange: (value) { setState(() => showPassword = value); }),
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
				print('Login Button Pressed');
				if (formKeySingup.currentState.validate())
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tentando Cadastrar...')));
				else
					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastro Invalido')));
			},
			child: Text(
				"Cadastrar", 
				style: submitButtonStyle
			),
		),
	);

	Widget genderDropdown() => Row(
		mainAxisAlignment: MainAxisAlignment.start,
		crossAxisAlignment: CrossAxisAlignment.center,
		children: [
			Text("Gênero", style: fieldLabelStyle),
			SizedBox(width: 10),
			Container(
				padding: EdgeInsets.only(left: 10),
				decoration: fieldBoxDecoration,
				child: DropdownButton<String>(
					underline: SizedBox(),
					value: genderDropdownChoise,
					iconSize: 24,
					style: const TextStyle(color: Colors.black),
					onChanged: (value) {
						setState(() => genderDropdownChoise = value);
					},
					items: genderDropdownList,
				)
			),
		] 
	);
}