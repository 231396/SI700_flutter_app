import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/model/user_data.dart';

class Database{

	static final Database helper = Database._createInstance();
	Database._createInstance();

	final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference _recipesCollection = FirebaseFirestore.instance.collection("recipes");
	
	//#region operations
	Future<void> updateUserData(UserData user) async {
		return await _userCollection.doc(user.uid).set(user.toMapNoAuth());
	}

	Future<DocumentReference<Object>> addRecipe(Recipe recipe) async {
		return await _recipesCollection.add(recipe.toMap(false));
	}	

	Future<void> updateRecipe(Recipe recipe) async {
		return await _recipesCollection.doc(recipe.uidRecipe).set(recipe.toMap(false));
	}

	Future<void> deleteRecipe(Recipe recipe) async {
		return await _recipesCollection.doc(recipe.uidRecipe).delete();
	}	
	//#endregion

	//#region streams
	Future<UserData> getUserData(UserData user) async {
		var doc = await _recipesCollection.doc(user.uid).get();
		if(!doc.exists)
			return null;
		return UserData.fromMapUID(user.uid, user.email, doc.data());
	}
	Future<Recipe> getRecipe(Recipe recipe) async {
		var doc = await _recipesCollection.doc(recipe.uidRecipe).get();
		if(!doc.exists)
			return null;
		return Recipe.fromMapUID(recipe.uidRecipe, doc.data());
	}

	Stream<UserData> getUserDataStream(UserData user) {
		return _userCollection.doc(user.uid).snapshots().map((ss) => UserData.fromMapUID(user.uid, user.email, ss.data()));
	}

	Stream<Recipe> getRecipeStream(Recipe recipe) {
		return _recipesCollection.doc(recipe.uidRecipe).snapshots().map((ss) => Recipe.fromMapUID(recipe.uidRecipe, ss.data()));
	}
	Stream<List<Recipe>> getRecipeListStream(UserData user) {
		return _recipesCollection.where(Recipe.AUTOR_UID, isEqualTo: user.uid).snapshots().map((ss) => 
		ss.docs.map((doc) => Recipe.fromMapUID(doc.id, doc.data())).toList());
	}
	Stream<List<Recipe>> getAllRecipesStream() {
		return _recipesCollection.snapshots().map((ss) => 
		ss.docs.map((doc) => Recipe.fromMapUID(doc.id, doc.data())).toList());
	}
	//#endregion

}