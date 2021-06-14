import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/model/user_data.dart';

class Database{

	static final Database helper = Database._createInstance();
	Database._createInstance();

	final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference _recipesCollection = FirebaseFirestore.instance.collection("recipes");
	
	Future<void> updateUserData(UserData user) async {
		return await _userCollection.doc(user.uid).set(user.toMapNoAuth());
	}

	//#region recipes operations
	Future<DocumentReference<Object>> addRecipe(Recipe recipe) async {
		return await _recipesCollection.add(recipe.toMap(false, true));
	}	

	Future<void> updateRecipe(Recipe recipe) async {
		return await _recipesCollection.doc(recipe.uidRecipe).set(recipe.toMap(false, false));
	}

	Future<void> deleteRecipe(Recipe recipe) async {
		return await _recipesCollection.doc(recipe.uidRecipe).delete();
	}	
	//#endregion

	Stream<UserData> getUserDataStream(UserData user) {
		return _userCollection.doc(user.uid).snapshots().map((ss) => UserData.fromMapUID(user.uid, user.email, ss.data()));
	}

	Stream<Recipe> getRecipeStream(Recipe recipe) {
		return _recipesCollection.doc(recipe.uidRecipe).snapshots().map((ss) => Recipe.fromMapUID(recipe.uidRecipe, ss.data()));
	}

	List<Recipe> _recipesFromSnapshot(QuerySnapshot snapshot) => 
		snapshot.docs.map((doc) => Recipe.fromMap(doc.data())).toList();
	Stream<List<Recipe>> getRecipesStream() {
		return _recipesCollection.snapshots().map(_recipesFromSnapshot);
	}


}