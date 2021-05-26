import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/logic/login/login_bloc.dart';
import 'package:flutter_app/logic/singup/singup_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login.dart';
import 'singup.dart';

class LoginSingupScreen extends StatelessWidget
{
	@override
	Widget build(BuildContext context) => DefaultTabController(
		length: 2,
		initialIndex: 0,
		child: Container(
			decoration: containerBackground, 
			child: Scaffold(
				backgroundColor: Colors.transparent,
				appBar: AppBar(
					centerTitle: true,
					title: Text("Receitas Ínicio"),
					bottom: TabBar(
						tabs: [
							Tab(child: Text("Logar", style: tabTextStyle)),
							Tab(child: Text("Cadastrar", style: tabTextStyle)),
						],
					),
				),
				body: TabBarView(
					children: [
						BlocProvider(
							create: (context) => LoginBloc(),
							child: LoginWidget()
						),
						BlocProvider(
							create: (context) => SingupBloc(),
							child: SingupWidget()
						),
					],
				),
			),
		),
	);

	final containerBackground = BoxDecoration(
		gradient: LinearGradient(
			begin: Alignment.topCenter,
			end: Alignment.bottomCenter,
			colors: [
				Colors.blue.shade500,
				Colors.blue.shade700,
			],
		)
	);
}