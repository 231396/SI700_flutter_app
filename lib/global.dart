import 'package:flutter/material.dart';

final tabTextStyle = TextStyle(
	fontSize: 16,
	color: Colors.black54,
);

String basicValidator(String str){
	if (str == null || str.isEmpty)
		return 'Please enter some text';
    return null;
}


class SingleRecipe
{
	String recipeID;
	String imagesUrl;
	String recipeTitle;
	String author;

	String description;

	SingleRecipe({this.recipeID = "", this.imagesUrl = "", this.recipeTitle = "", this.author = ""});

	String getDescription()
	{
		description = "Not implemented";
		return description;
	}
}