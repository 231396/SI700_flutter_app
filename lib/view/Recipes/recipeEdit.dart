import 'package:flutter/material.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/model/singleRecipe.dart';

class RecipeEditScreen extends StatefulWidget
{
	final SingleRecipe recipe;

	RecipeEditScreen(this.recipe);

	@override
	RecipeEditScreenState createState() => RecipeEditScreenState(recipe: recipe);
}

class RecipeEditScreenState extends State<RecipeEditScreen>
{
	final formKey = GlobalKey<FormState>();

	final urlFieldController = TextEditingController();

	final SingleRecipe recipe;

	RecipeEditScreenState({this.recipe});

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
						urlToImage(recipe.imagesUrl),
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
							initialValue: recipe.recipeTitle,
							// onChanged: (str) => recipe.recipeTitle = str,
							onSaved: (str) => recipe.recipeTitle = str,
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
							// onChanged: (str) => recipe.description = str,
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

	Widget urlToImage(String imgUrl){
		try {
		  return Image.network(imgUrl,
				width: 250,
				height: 250,
				errorBuilder: imageErrorHandler,
			);
		} catch (e) {
			return Icon(Icons.image);
		}
	}


	@override
	void dispose() {
		urlFieldController.dispose();
		super.dispose();
	}

	void loadImageURL()
	{
		setState(() => recipe.imagesUrl = urlFieldController.text);
	}

	void saveRecipe()
	{
		if(formKey.currentState.validate()){
			formKey.currentState.save();
			recipe.printRecipe();
			//TODO - SAVE RECIPE IN DB
			ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enviado ao servidor')));
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