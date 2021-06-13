class SingleRecipe
{
	static const String ID = "id";
	static const String URL = "imageUrl";
	static const String TITLE = "title";
	static const String DESCRIPTION = "description";

	String recipeID;
	String imagesUrl;
	String recipeTitle;

	String description;

	SingleRecipe({this.recipeID = "", this.imagesUrl = "", this.recipeTitle = "", this.description = ""});

	void printRecipe(){
		print(recipeID + " " + imagesUrl + " " + recipeTitle);
		print(description);
	}
}