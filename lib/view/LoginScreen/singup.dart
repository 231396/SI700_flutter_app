import 'package:flutter/material.dart';
import 'package:flutter_app/model/person.dart';
import 'shared.dart';

class SingupWidget extends StatefulWidget {
	@override
	SingupWidgetState createState() => SingupWidgetState();
}

class SingupWidgetState extends State<SingupWidget> 
{
	final formKeySingup = GlobalKey<FormState>();

	final Person person = new Person();

	static const genderDropdownList = [
		DropdownMenuItem(value: 'M', child: Text('M')),
		DropdownMenuItem(value: 'F', child: Text('F')),
	];

	String genderDropdownChoise = genderDropdownList[0].value;
	bool showPassword = false;
	
	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			padding: EdgeInsets.only(top: 20),
			child: Form(
				key: formKeySingup,
				child: Container(
					height: 550,
					padding: EdgeInsets.symmetric(horizontal: 25.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children:[
							defaultField("Nome", (value) => person.name = value),
							SizedBox(height: 30.0),
							emailField((value) => person.email = value),
							SizedBox(height: 30.0),
							genderDropdown((value) => person.gender = value),
							SizedBox(height: 30.0),
							passwordField(showPassword, (value) => setState(() => showPassword = value), (value) => person.password = value),
							// submitBtn()
						],
					)
				),
			)
		);
	}

	// Widget submitBtn() => Container(
	// 	padding: EdgeInsets.symmetric(vertical: 25.0),
	// 	width: double.infinity,
	// 	child: BlocListener<LoginScreenBloc, LoginScreenState>(
	// 		listener: (context, state) {
	// 			// if(state is LoginScreenSingupState && state.person != null)
	// 			// 	ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastrado com Sucesso')));

	// 			return ElevatedButton(
	// 				style: ElevatedButton.styleFrom(
	// 					elevation: 5,
	// 					primary: Colors.white,
	// 					padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
	// 					shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
	// 				),
	// 				onPressed: () {
	// 					ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Tentando Cadastrar...')));
	// 					if (formKeySingup.currentState.validate()){
	// 						formKeySingup.currentState.save();
	// 						BlocProvider.of<LoginScreenBloc>(context).add(SingupEvent(person: person));
	// 					}
	// 					else
	// 						ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Cadastro Invalido')));
	// 				},
	// 				child: Text(
	// 					"Cadastrar", 
	// 					style: submitButtonStyle
	// 				),
	// 			);
	// 		}
	// 	),
	// );

	Widget genderDropdown(Function(String) onSave) => Row(
		mainAxisAlignment: MainAxisAlignment.start,
		crossAxisAlignment: CrossAxisAlignment.center,
		children: [
			Text("Gênero", style: fieldLabelStyle),
			SizedBox(width: 10),
			Container(
				padding: EdgeInsets.only(left: 10),
				decoration: fieldBoxDecoration,
				child: SizedBox(width: 40, child: DropdownButtonFormField<String>(
					value: genderDropdownChoise,
					iconSize: 24,
					style: const TextStyle(color: Colors.black),
					onChanged: (value) {
						setState(() => genderDropdownChoise = value);
					},
					onSaved: onSave,
					items: genderDropdownList,
				))
			),
		] 
	);
}