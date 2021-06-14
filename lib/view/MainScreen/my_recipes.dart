import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/model/singleRecipe.dart';
import 'package:flutter_app/view/Recipes/recipeEdit.dart';
import 'package:flutter_app/view/Recipes/recipeVizualizer.dart';

class MyRecipesWidget extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => new MyRecipesWidgetState();
}


class MyRecipesWidgetState extends State<MyRecipesWidget> 
{
	final recipes = <SingleRecipe>[];

	@override
	void initState() {
		super.initState();
		loadRecipes();
	}

	void loadRecipes(){
		//TODO - GET RECIPES FROM DB
	}

	@override
	Widget build(BuildContext context) 
	{ 
		return Scaffold(
			backgroundColor: Colors.transparent,
			body: SingleChildScrollView(child: Column(children: [
					listViewRecipesBuild(context, recipes),
					ElevatedButton(
						onPressed: () async {
							var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(new SingleRecipe())));
							print(result);
							//setState(() => recipes.add(newRecipe));

							if(result != null){
								setState(loadRecipes);
							}
						},
						child: Icon(Icons.add),
						style: ElevatedButton.styleFrom(				
							elevation: 5,
							primary: Colors.blue[300]
						),
					)
				]))
		);
	}

	ListView listViewRecipesBuild(BuildContext context, List<SingleRecipe> recipes) => ListView.separated(
		shrinkWrap: true,
		padding: const EdgeInsets.all(8),
		itemCount: recipes.length,
		separatorBuilder: (BuildContext context, int index) => const Divider(),
		itemBuilder: (BuildContext context, int index) => Container(
			padding: EdgeInsets.only(top: 10, left: 10),
			height: 75,
			decoration: BoxDecoration(
				color: Colors.yellow[700],
				borderRadius: BorderRadius.all(Radius.circular(8.0)),
			),
			child: ListTile(
				leading: ClipRRect(
					borderRadius: BorderRadius.circular(10.0),
					child: Image.network(
						recipes[index].imagesUrl, 
						width: 50, 
						height: 50,
						fit: BoxFit.cover, 
						errorBuilder: imageErrorHandler
					),
				),
				title: Text("${recipes[index].recipeTitle}", style: TextStyle(fontSize: 24), overflow: TextOverflow.ellipsis),
				onTap: () => showRecipeDialog(recipes[index]),
				),
			),
	);

	Future<void> showRecipeDialog(SingleRecipe recipe) async 
	{
		return showDialog<void>(
			context: context,
			barrierDismissible: true,
			builder: (BuildContext context) => AlertDialog(
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
							onPressed: () async {
								Navigator.of(context).pop();
								final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(recipe)));
								print(result);
								if(result != null){
									setState(loadRecipes);
								}
							},
						),
					],
				),
		);
	}

}