import 'package:flutter/material.dart';	
import 'package:flutter_app/global.dart';	

Widget defaultField(String title, void Function(String) onSave) => Column(
	crossAxisAlignment: CrossAxisAlignment.start,
	children: [
		Text(title, style: fieldLabelStyle),
		Container(
			margin: EdgeInsets.only(top: 5.0),
			alignment: Alignment.centerLeft,
			decoration: fieldBoxDecoration,
			height: 55.0,
			child: TextFormField(
				validator: basicValidator,
				onSaved: onSave,
				keyboardType: TextInputType.name,
				style: TextStyle(color: Colors.white),
				decoration: InputDecoration(
					contentPadding: EdgeInsets.only(left: 15),
					border: InputBorder.none,
					hintText: 'Escreva seu $title',
					hintStyle: hintTextStyle,
				),
			),
		),
	],
);


Widget passwordField(bool showPassword, void Function(bool) onShowPasswordChange, void Function(String) onSave) => Column(
	crossAxisAlignment: CrossAxisAlignment.start,
	children: [
		Text('Senha', style: fieldLabelStyle),
		Container(
			margin: EdgeInsets.only(top: 5.0),
			alignment: Alignment.centerLeft,
			decoration: fieldBoxDecoration,
			height: 55.0,
			child: TextFormField(
				validator: (passStr) {
					if(basicStringValidation(passStr) || passStr.length < 6)
						return "Senha com menos de 6 caracteres";
					return null;
				},
				onSaved: onSave,
				obscureText: !showPassword,
				keyboardType: TextInputType.visiblePassword,
				style: TextStyle(color: Colors.white),
				decoration: InputDecoration(
					contentPadding: EdgeInsets.only(top: 15, left: 15),
					border: InputBorder.none,
					suffixIcon: Icon(Icons.lock, color: Colors.white),
					hintText: 'Escreva seu Senha',
					hintStyle: hintTextStyle,
				),
			),
		),
		Row(
			children: [
				Switch( 
					activeColor: Colors.yellow,
					value: showPassword, 
					onChanged: onShowPasswordChange,
				),
				Text("Mostrar Senha", style: fieldLabelStyle),
			],
		)
	],
);

Widget emailField(void Function(String) onSave) =>  Column(
	crossAxisAlignment: CrossAxisAlignment.start,
	children: [
		Text('Email', style: fieldLabelStyle),
		Container(
			margin: EdgeInsets.only(top: 5.0),
			alignment: Alignment.centerLeft,
			decoration: fieldBoxDecoration,
			height: 55.0,
			child: TextFormField(
				validator: (emailStr) {
					bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(emailStr);
					return emailValid ? null : "Email Invalido"; 
				},
				onSaved: onSave,
				keyboardType: TextInputType.emailAddress,
				style: TextStyle(color: Colors.white),
				decoration: InputDecoration(
					contentPadding: EdgeInsets.only(top: 15, left: 15),
					border: InputBorder.none,
					suffixIcon: Icon(Icons.email, color: Colors.white),
					hintText: 'Escreva seu Email',
					hintStyle: hintTextStyle,
				),
			),
		),
	],
);


const hintTextStyle = TextStyle(
	color: Colors.white54,
);

const fieldLabelStyle = TextStyle(
	color: Colors.white,
	fontSize: 16,
	fontWeight: FontWeight.bold,
);

final fieldBoxDecoration = BoxDecoration(
	color: Color(0xFF6CA8F1),
	borderRadius: BorderRadius.circular(10.0),
	boxShadow: [
		BoxShadow(
			color: Colors.black12,
			blurRadius: 6.0,
			offset: Offset(0, 2),
		),
	],
);

const submitButtonStyle = TextStyle(
	color: Color(0xFF527DAA),
	letterSpacing: 1.5,
	fontSize: 18.0,
	fontWeight: FontWeight.bold,
);