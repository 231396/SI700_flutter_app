import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/view/Recipes/recipeEdit.dart';
import 'package:flutter_app/view/Recipes/recipeVizualizer.dart';

class MyRecipesWidget extends StatefulWidget {
	@override
	State<StatefulWidget> createState() => new MyRecipesWidgetState();
}


class MyRecipesWidgetState extends State<MyRecipesWidget> 
{
	static const defaultDescr = "1/2 xícara (chá) de óleo\r\n3 cenouras médias raladas\r\n4 ovos\r\n2 xícaras (chá) de açúcar\r\n2 e 1/2 xícaras (chá) de farinha de trigo\r\n1 colher (sopa) de fermento em pó";

	final recipes = <SingleRecipe>[
		new SingleRecipe(recipeID: "0", imagesUrl: "https://picsum.photos/250?image=9", recipeTitle:  "Bolo de Cenoura", description: defaultDescr),
		new SingleRecipe(recipeID: "1", imagesUrl:"https://picsum.photos/250?image=7",recipeTitle: "Bolo de Pave", description: defaultDescr),
		new SingleRecipe(recipeID: "2", imagesUrl: "https://picsum.photos/250?image=6", recipeTitle: "Bolo Molhado", description: defaultDescr),
	];

	@override
	Widget build(BuildContext context) 
	{ 
		return Scaffold(
			backgroundColor: Colors.transparent,
			body: SingleChildScrollView(child: Column(children: [
					listViewRecipesBuild(context, recipes),
					ElevatedButton(
						onPressed: () async {
							var newRecipe = new SingleRecipe();
							await Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(recipe: newRecipe, isNewRecipe: true)));
							setState(() => recipes.add(newRecipe));
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
		itemBuilder: (BuildContext context, int index) => GestureDetector(
			onTap: () => showRecipeDialog(context, recipes[index]),
			child: Container(
				height: 75,
				decoration: BoxDecoration(
					color: Colors.yellow[700],
					borderRadius: BorderRadius.all(Radius.circular(8.0)),
				),
				child: Row(
						children: [
							Padding(
								padding: EdgeInsets.symmetric(horizontal: 15), 
								child: ClipRRect(
    								borderRadius: BorderRadius.circular(10.0),
									child: Image.network(
										recipes[index].imagesUrl, 
										width: 50, 
										height: 50,
										fit: BoxFit.cover, 
										errorBuilder: imageErrorHandler
									),
								)
							),
							Text("${recipes[index].recipeTitle}", style: TextStyle(fontSize: 24), overflow: TextOverflow.ellipsis),
						],
					)
			)
		),
	);

	Future<void> showRecipeDialog(BuildContext context, SingleRecipe recipe) async 
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
								Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeVizualizerScreen(recipe: recipe)));
							},
						),
						TextButton(
							child: Text('Editar'),
							onPressed: () {
								Navigator.of(context).pop();
								Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeEditScreen(recipe: recipe)));
							},
						),
					],
				),
		);
	}

}