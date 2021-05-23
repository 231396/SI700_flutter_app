import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';

class RecipeVizualizerScreen extends StatelessWidget
{
	final SingleRecipe recipe;

	RecipeVizualizerScreen({this.recipe});

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
						Image.network(recipe.imagesUrl,
							width: 250,
							height: 250,
							errorBuilder: imageErrorHandler,
						),
						SizedBox(height: 20),
						Text(recipe.recipeTitle,
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
						Container(
							padding: const EdgeInsets.all(10.0),
							alignment: Alignment.centerLeft,
							child: Text("ID: ${recipe.recipeID}"),
						),
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