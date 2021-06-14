import 'package:flutter/material.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/services/database_firestone.dart';
import 'package:flutter_app/view/Recipes/recipe_vizualizer.dart';

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
								keyboardType: TextInputType.text,
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

	void findAndOpenRecipe() async
	{
		var recipe = new Recipe(uidRecipe: idFieldController.text);
		recipe = await Database.helper.getRecipe(recipe);
		if(recipe != null)
			Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeVizualizerScreen(recipe)));
		else
			ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ID da receita não encontrado')));
	}

}