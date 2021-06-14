import 'package:flutter/material.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/services/database_firestone.dart';
import 'package:flutter_app/view/Recipes/shared.dart';

class RecipeEditScreen extends StatefulWidget
{
	final Recipe recipe;

	RecipeEditScreen(this.recipe);

	@override
	RecipeEditScreenState createState() => RecipeEditScreenState(recipe: recipe);
}

class RecipeEditScreenState extends State<RecipeEditScreen>
{
	final formKey = GlobalKey<FormState>();

	final urlFieldController = TextEditingController();

	final Recipe recipe;

	RecipeEditScreenState({this.recipe});

	@override
	Widget build(BuildContext context)
	{ 
		urlFieldController.text = recipe.imageUrl;
		return Scaffold(
			appBar: AppBar(
				title: Text("Editando Receita"),
			),
			body: Container(
				padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
				child: SingleChildScrollView(child: Form (key: formKey, child: Column(
					mainAxisAlignment: MainAxisAlignment.start,
					children:[
						urlToImage(recipe.imageUrl),
						SizedBox(height: 20),
						TextFormField(
							controller: urlFieldController,
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
							initialValue: recipe.title,
							onSaved: (str) => recipe.title = str,
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
							onSaved: (str) => recipe.description = str,
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
									onPressed: saveRecipe,
								),
								ElevatedButton(
									child: Icon(Icons.update), 
									onPressed: loadImageURL,
								),
								ElevatedButton(
									child: Text("Deletar"), 
									onPressed: showDeleteDialog,
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

	void loadImageURL()
	{
		setState(() => recipe.imageUrl = urlFieldController.text);
	}

	void saveRecipe()
	{
		if(formKey.currentState.validate()){
			formKey.currentState.save();
			print(recipe);
			//TODO - SAVE RECIPE IN DB
			//Database.helper.updateRecipe(uidRecipe, title, imageUrl, description)
			ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Receita Salva')));
		}
	}

	void removeRecipe()
	{
		//TODO - DELETE RECIPE FROM DB
		ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Remoção Solicitada')));
		Navigator.of(context).pop();
		Navigator.of(context).pop(true);
	}

	Future<void> showDeleteDialog() async 
	{
		return await showDialog<void>(
			context: context,
			barrierDismissible: true,
			builder: (BuildContext context) => AlertDialog(
					title: Text('Deseja Realmente exluir a receita? (não pode ser desfeito)'),
					actions: <Widget>[
						TextButton(
							child: Text('Sim'),
							onPressed: removeRecipe,
						),
						TextButton(
							child: Text('Não'),
							onPressed: () => Navigator.pop(context),
						),
					],
				),
		);
	}

}