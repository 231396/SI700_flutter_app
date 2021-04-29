import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/view/Recipes/recipeCreate.dart';
import 'shared.dart';

class HomeWidget extends StatelessWidget 
{
	@override
	Widget build(BuildContext context) => DefaultTabController(
		length: 2,
		initialIndex: 0,
		child: Container(
			//decoration: containerBackground, 
			child: Scaffold(
				backgroundColor: Colors.transparent,
				appBar: appBarTabsOnly(
					tabs: [
						Tab(child: Text("Suas Receitas", style: tabTextStyle)),
						Tab(child: Text("Ver Receita", style: tabTextStyle)),
					],
				),
				body: TabBarView(
					children: [
						buildUserRecipesList(context),
					],
				),
			),
		)
	);


	Widget buildUserRecipesList(BuildContext context)	
	{
		final recipes = <SingleRecipe>[
			new SingleRecipe(recipeID: "0", imagesUrl: "https://picsum.photos/250?image=9", recipeTitle:  "Bolo de Cenoura", author: "Carlos da Cunha"),
			new SingleRecipe(recipeID: "1", imagesUrl:"https://picsum.photos/250?image=7",recipeTitle: "Bolo de Pave",  author: "Gistlan"),
			new SingleRecipe(recipeID: "2", imagesUrl: "https://picsum.photos/250?image=6", recipeTitle: "Bolo Molhado",  author: "Englandt"),
		];

		return Column(children: [
			listViewRecipesBuild(recipes, (context, recipe) => RecipeCreateScreen(recipe: recipe)),
			ElevatedButton(
				onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeCreateScreen())),
				child: Icon(Icons.add),
				style: ElevatedButton.styleFrom(				
					elevation: 5,
					primary: Colors.blue[200]
				),
			)
		]);
	}
}