import 'package:flutter/material.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/model/user_data.dart';
import 'package:flutter_app/view/Recipes/shared.dart';
import 'package:provider/provider.dart';

class RecipeVizualizerScreen extends StatelessWidget
{
	final Recipe recipe;

	RecipeVizualizerScreen(this.recipe);

	@override
	Widget build(BuildContext context)
	{ 
		return Scaffold(
			appBar: AppBar(
				title: Text("Vizualizando Receita"),
			),
			body: Container(
				width: double.infinity,
				padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
				child: SingleChildScrollView(child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children:[
						urlToImage(recipe.imageUrl),
						SizedBox(height: 20),
						Text(recipe.title,
							textAlign: TextAlign.center,
							style: TextStyle(fontSize: 30.0),
						),
						SizedBox(height: 15),
						Container(
							width: double.infinity,
							margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
							padding: const EdgeInsets.all(10.0),
							decoration: myTextBoxDecoration,
							child: Text(recipe.description,
								style: TextStyle(fontSize: 16.0),
							),
						),
						uidRecipe(context, recipe.uidRecipe)
					],
				))
			)
		);
	}

	final myTextBoxDecoration = BoxDecoration(
		border: Border.all(
			color: Colors.grey.shade500
		),
	);
}