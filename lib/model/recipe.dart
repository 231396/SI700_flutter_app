class Recipe
{
	static const String RECIPE_UID = "uidRecipe";
	static const String AUTOR_UID = "uidAuthor";
	static const String IMAGE_URL = "imageUrl";
	static const String TITLE = "title";
	static const String DESCRIPTION = "description";

	String uidRecipe;
	String uidAuthor;
	String imageUrl;
	String title;

	String description;

	Recipe({this.uidRecipe = "", this.uidAuthor = "", this.imageUrl = "", this.title = "", this.description = ""});

	Recipe.fromMapUID(String uid, Map<String, dynamic> map) {
		uidRecipe = uid;
		uidAuthor = map[AUTOR_UID];
		imageUrl = map[IMAGE_URL];
		title = map[TITLE];
		description = map[DESCRIPTION];
	}

	Recipe.fromMap(Map<String, dynamic> map) {
		uidRecipe = map[RECIPE_UID];
		uidAuthor = map[AUTOR_UID];
		imageUrl = map[IMAGE_URL];
		title = map[TITLE];
		description = map[DESCRIPTION];
	}

	Map<String, dynamic> toMap(bool addRecipeUID, bool addAuthorUID) {
		var map = <String, Object>{
			IMAGE_URL: imageUrl,
			TITLE: title,
			DESCRIPTION: description, 
		};
		if(addRecipeUID)
			map[RECIPE_UID] = uidRecipe;
		if(addAuthorUID)
			map[AUTOR_UID] = uidAuthor;
		return map;
	}


	String toString(){
		return "[$uidRecipe, $uidAuthor, $imageUrl, $title]\n[$description]";
	}
}