class SingleRecipe
{
	static const String UID = "uidRecipe";
	static const String AUTOR_UID = "uidAuthor";
	static const String IMAGE_URL = "imageUrl";
	static const String TITLE = "title";
	static const String DESCRIPTION = "description";

	String uidRecipe;
	String uidAuthor;
	String imagesUrl;
	String recipeTitle;

	String description;

	SingleRecipe({this.uidRecipe = "", this.uidAuthor = "", this.imagesUrl = "", this.recipeTitle = "", this.description = ""});

	String toString(){
		return "[$uidRecipe, $uidAuthor, $imagesUrl, $recipeTitle]\n[$description]";
	}
}