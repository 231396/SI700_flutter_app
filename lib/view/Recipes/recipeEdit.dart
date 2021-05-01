import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';

class RecipeEditScreen extends StatefulWidget
{
	final SingleRecipe recipe;
	final bool isNewRecipe;


	RecipeEditScreen({this.recipe, this.isNewRecipe = false});

	@override
	RecipeEditScreenState createState() => RecipeEditScreenState(recipe: recipe, isNewRecipe: isNewRecipe);
}

class RecipeEditScreenState extends State<RecipeEditScreen>
{
	final formKey = GlobalKey<FormState>();

	final urlFieldController = TextEditingController();

	final SingleRecipe recipe;
	final bool isNewRecipe;

	RecipeEditScreenState({this.recipe, this.isNewRecipe = false});

	@override
	Widget build(BuildContext context)
	{ 
		urlFieldController.text = recipe.imagesUrl;
		return Scaffold(
			appBar: AppBar(
				title: Text("Editando Receita"),
			),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
				child: SingleChildScrollView(child: Form (key: formKey, child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children:[
						Image.network(recipe.imagesUrl,
							width: 250,
							height: 250,
							errorBuilder: imageErrorHandler,
						),
						SizedBox(height: 20),
						TextFormField(
							controller: urlFieldController,
							// onChanged: (str) => _url = recipe.imagesUrl,
							// initialValue: _recipe.imagesUrl,
							keyboardType: TextInputType.url,
							style: TextStyle(color: Colors.blue[900]),
							decoration: InputDecoration(
								contentPadding: EdgeInsets.only(top: 15, left: 15),
								focusedBorder: OutlineInputBorder(
											borderRadius: BorderRadius.all(Radius.circular(5.0)),
											borderSide: BorderSide(color: Colors.blue)
								),
								border: OutlineInputBorder(
									borderRadius: BorderRadius.all(Radius.circular(5.0)),
								),
								suffixIcon: Icon(Icons.lock, color: Colors.white),
								hintText: 'Escreva a url da imagem',
							),
						),
						SizedBox(height: 20),
						TextFormField(
							initialValue: recipe.recipeTitle,
							onChanged: (str) => recipe.recipeTitle = str,
							maxLength: 30,
							keyboardType: TextInputType.text,
							style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
							decoration: InputDecoration(
								contentPadding: EdgeInsets.only(top: 15, left: 15),
								focusedBorder: OutlineInputBorder(
											borderRadius: BorderRadius.all(Radius.circular(5.0)),
											borderSide: BorderSide(color: Colors.blue)
								),
								border: OutlineInputBorder(
									borderRadius: BorderRadius.all(Radius.circular(5.0)),
								),
								suffixIcon: Icon(Icons.lock, color: Colors.white),
								hintText: 'Escreva o nome da receita',
							),
						),
						SizedBox(height: 15),
						TextFormField(
							initialValue: recipe.description,
							onChanged: (str) => recipe.description = str,
							keyboardType: TextInputType.multiline,
  							maxLines: null,
							style: TextStyle(color: Colors.black),
							decoration: InputDecoration(
								contentPadding: EdgeInsets.only(top: 15, left: 15),
								focusedBorder: OutlineInputBorder(
											borderRadius: BorderRadius.all(Radius.circular(5.0)),
											borderSide: BorderSide(color: Colors.blue)
								),
								border: OutlineInputBorder(
									borderRadius: BorderRadius.all(Radius.circular(5.0)),
								),
								suffixIcon: Icon(Icons.lock, color: Colors.white),
								hintText: 'Escreva sua receita',
							),
						),
						SizedBox(height: 10),
						Row(
							mainAxisAlignment: MainAxisAlignment.spaceEvenly,
							children: [
								ElevatedButton(
									child: Text("Salvar"),
									onPressed: onSave,
								),
								ElevatedButton(
									child: Icon(Icons.update), 
									onPressed: redraw,
								),
							],
						)
					],
				))
			))
		);
	}

	@override
	void dispose() {
		urlFieldController.dispose();
		super.dispose();
	}

	void redraw()
	{
		// print(_url);
		setState(() => recipe.imagesUrl = urlFieldController.text);
	}

	void onSave()
	{
		ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enviando ao servidor')));
	}

}