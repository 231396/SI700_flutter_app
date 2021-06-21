import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/model/user_data.dart';
import 'package:flutter_app/services/database_firestone.dart';
import 'package:flutter_app/view/Recipes/recipe_edit.dart';
import 'package:flutter_app/view/Recipes/recipe_vizualizer.dart';
import 'package:provider/provider.dart';

class MyRecipesWidget extends StatelessWidget
{
	@override
	Widget build(BuildContext context) 
	{ 
		var user = Provider.of<UserData>(context);
		return StreamProvider<List<Recipe>>.value(
			initialData: null,
			value: Database.helper.getRecipeListStream(user),
			child: Scaffold(
					backgroundColor: Colors.transparent,
					body: SingleChildScrollView(
							child: Column(children: [
								_RecipeList(),
								ElevatedButton(
									onPressed: () => createNewRecipe(context, user),
									child: Icon(Icons.add),
									style: ElevatedButton.styleFrom(				
										elevation: 5,
										primary: Colors.blue[300]
									),
								)
							])),
			),
		);
	}

	void createNewRecipe(BuildContext context, UserData user){
		Recipe recipe = new Recipe(uidAuthor: user.uid);
		Database.helper.addRecipe(recipe).then((value) => 
			Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(new Recipe(uidRecipe: value.id))))
		);
	}

}

class _RecipeList extends StatelessWidget
{
	@override
	Widget build(BuildContext context) {
		var recipes = Provider.of<List<Recipe>>(context);
		if (recipes == null)
			return Container();
		return ListView.separated(
			itemCount: recipes.length,
			shrinkWrap: true,
			padding: const EdgeInsets.all(8),
			separatorBuilder: (BuildContext context, int index) => const Divider(),
			itemBuilder: (BuildContext context, int index) {
				return Container(
						height: 75,
						padding: EdgeInsets.only(top: 10, left: 10),
						decoration: BoxDecoration(
							color: Colors.yellow[700],
							borderRadius: BorderRadius.all(Radius.circular(8.0)),
						),
						child:ListTile(
							title: Text("${recipes[index].title}", style: TextStyle(fontSize: 24), overflow: TextOverflow.ellipsis),
							onTap: () => _showRecipeDialog(context, recipes[index]),
							leading: ClipRRect(
									borderRadius: BorderRadius.circular(10.0),
									child: networkImage(recipes[index].imageUrl, 50, 50),
									),
						),
				);
			},
		);
	}

	void _showRecipeDialog(BuildContext context, Recipe recipe) => showDialog<void>(
		context: context,
		barrierDismissible: true,
		builder: (context) => AlertDialog(
				title: Text('Editar ou Vizualizar'),
				actions: <Widget>[
					TextButton(
						child: Text('Vizualizar'),
						onPressed: () {
							Navigator.of(context).pop();
							Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeVizualizerScreen(recipe)));
						},
					),
					TextButton(
						child: Text('Editar'),
						onPressed: () {
							Navigator.of(context).pop();
							Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(recipe)));
						},
					),
				],
		),
	);
}