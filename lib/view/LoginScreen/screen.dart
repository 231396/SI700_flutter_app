import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
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
					title: Text("Receitas de Bolo"),
					bottom: TabBar(
						tabs: [
							Tab(child: Text("Logar", style: tabTextStyle)),
							Tab(child: Text("Cadastrar", style: tabTextStyle)),
						],
					),
				),
				body: TabBarView(
					children: [
						LoginWidget(),
						SingupWidget(),
					],
				),
			),
		)
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