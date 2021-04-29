import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';

class RecipeCreateScreen extends StatefulWidget
{
	final SingleRecipe recipe;

	RecipeCreateScreen({this.recipe});

	@override
	RecipeCreateScreenState createState() => RecipeCreateScreenState(recipe: recipe);
}

class RecipeCreateScreenState extends State<RecipeCreateScreen>
{
	final formKey = GlobalKey<FormState>();

	SingleRecipe recipe;

	RecipeCreateScreenState({this.recipe}){
		if(recipe == null)
			recipe = new SingleRecipe();
	}

	@override
	Widget build(BuildContext context)
	{ 
		return Scaffold(
			appBar: AppBar(
				title: Text("Create Recipe"),
			),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
				child: SingleChildScrollView(child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children:[
						Image.network(recipe.imagesUrl,
							errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
								return Text('Imagem não pode ser carregada', style: TextStyle(color: Colors.red));
							},
						),
						SizedBox(height: 20),
						TextFormField(
							// onChanged: (str) => _url = recipe.imagesUrl,
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
									onPressed: OnSave,
								),
								ElevatedButton(
									child: Icon(Icons.update), 
									onPressed: Update,
								),
							],
						)
					],
				))
			)
		);
	}

	void Update()
	{
		// print(_url);
		// setState(() => recipe.imagesUrl = _url);
	}

	void OnSave()
	{

	}

}