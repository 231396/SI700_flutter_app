import 'package:flutter/material.dart';

final tabTextStyle = TextStyle(
	fontSize: 16,
	color: Colors.black54,
);

String basicValidator(String str){
	if (str == null || str.isEmpty)
		return 'Campo em branco';
    return null;
}

Widget imageErrorHandler(BuildContext context, Object exception, StackTrace stackTrace)
{
	return const Icon(Icons.insert_drive_file, size: 40,);
	//return const Text('Imagem não pode ser carregada', style: TextStyle(color: Colors.red));
}

class SingleRecipe
{
	String recipeID;
	String imagesUrl;
	String recipeTitle;

	String description;

	SingleRecipe({this.recipeID = "", this.imagesUrl = "", this.recipeTitle = "", this.description = ""});
}