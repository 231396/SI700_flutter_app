import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/recipe.dart';
import 'package:flutter_app/model/user_auth.dart';
import 'package:flutter_app/model/user_data.dart';

class Database{

	static final Database helper = Database._createInstance();
	Database._createInstance();

	final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference recipesCollection = FirebaseFirestore.instance.collection("recipes");
	
	Future<void> updateUserData(UserAuth auth, UserData data) async {
		return await userCollection.doc(auth.uid).set(data.toJson());
	}

	//#region recipes operations
	Future<DocumentReference<Object>> addRecipe(Recipe recipe) async {
		return await recipesCollection.add(recipe.toJson(false, true));
	}	

	Future<void> updateRecipe(Recipe recipe) async {
		return await recipesCollection.doc(recipe.uidRecipe).set(recipe.toJson(false, false));
	}

	Future<void> deleteRecipe(Recipe recipe) async {
		return await recipesCollection.doc(recipe.uidRecipe).delete();
	}	
	//#endregion

	Future<UserData> getUserData(UserAuth user) async{
		if (user != null){
			var doc = await userCollection.doc(user.uid).get();
			return new UserData.fromJson(doc.data());
		}
		return null;
	}


//   // brew list from snapshot
//   List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc){
// 		return Brew(
// 			name: doc.data['name'] ?? '',
// 			strength: doc.data['strength'] ?? 0,
// 			sugars: doc.data['sugars'] ?? '0'
// 		);
//     }).toList();
//   }

//   // user data from snapshots
//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return UserData(
// 		uid: uid,
// 		name: snapshot.data['name'],
// 		sugars: snapshot.data['sugars'],
// 		strength: snapshot.data['strength']
//     );
//   }

//   // get brews stream
//   Stream<List<Brew>> get brews {
//     return brewCollection.snapshots().map(_brewListFromSnapshot);
//   }

//   // get user doc stream
//   Stream<UserData> get userData {
//     return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
//   }

}