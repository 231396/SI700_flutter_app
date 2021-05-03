import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/view/Recipes/recipeVizualizer.dart';

class SeacrhRecipesWidget extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => new SeacrhRecipesWidgetState();
}

class SeacrhRecipesWidgetState extends State<SeacrhRecipesWidget> 
{
	final idFieldController = TextEditingController();

	@override
	Widget build(BuildContext context) 
	{ 
		return Scaffold(
			backgroundColor: Colors.transparent,
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: [
					Container(
						color: Colors.grey[200],
						margin: EdgeInsets.symmetric(horizontal: 50), 
						child: TextField(
								controller: idFieldController,
								keyboardType: TextInputType.number,
								style: TextStyle(color: Colors.black),
								decoration: InputDecoration(
									contentPadding: EdgeInsets.only(top: 15, left: 15),
									border: InputBorder.none,
									hintText: 'Escreva ID da receita',
									hintStyle: TextStyle(color: Colors.black26),
								),
							),
					),
					ElevatedButton(
						onPressed: findAndOpenRecipe,
						child: Icon(Icons.search),
					),
				]
			),
		);
	}

	@override
	void dispose() {
		idFieldController.dispose();
		super.dispose();
	}

	void findAndOpenRecipe()
	{
		if(idFieldController.text == "1")
			Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeVizualizerScreen(recipe: new SingleRecipe())));
		else
			ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ID não encontrado')));
	}

}