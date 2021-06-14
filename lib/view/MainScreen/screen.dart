import 'package:flutter/material.dart';
import 'profile.dart';
import 'my_recipes.dart';
import 'search_recipe.dart';

class HomeScreen extends StatefulWidget
{
	@override
	HomeScreenStatefulState createState() => HomeScreenStatefulState();
}

class HomeScreenStatefulState extends State<HomeScreen> 
{
  	int currentNavIndex = 2;
	  
  	final List<Widget> navOptions = [
		  SeacrhRecipesWidget(),
		  MyRecipesWidget(),
		  ProfileWidget(),
  	];

	void onNavItemTap(int index) => setState(() => currentNavIndex = index);

  	@override
  	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('Receitas'), centerTitle: true),
			body: navOptions[currentNavIndex],
			bottomNavigationBar: BottomNavigationBar(
				type: BottomNavigationBarType.fixed,
				currentIndex: currentNavIndex,
				selectedItemColor: Colors.amber[800],
				onTap: onNavItemTap,
				items: const <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.search),
						label: 'Pesquisar',
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.collections_bookmark),
						label: 'Biblioteca',
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.account_circle),
						label: 'Perfil',
					),
				],
			),
		);
	}
}