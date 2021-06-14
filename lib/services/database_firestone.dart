import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/model/singleRecipe.dart';
import 'package:flutter_app/model/user_auth.dart';
import 'package:flutter_app/model/user_data.dart';

class Database{

	static final Database helper = Database._createInstance();
	Database._createInstance();

	final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
	final CollectionReference recipesCollection = FirebaseFirestore.instance.collection("recipes");
	
	Future<void> updateUserData(String uid, String name, String gender) async {
		return await userCollection.doc(uid).set({
			UserData.NAME: name,
			UserData.GENDER: gender,
		});
	}

	//#region recipes operations
	Future<DocumentReference<Object>> addRecipe(String uid, String title, String imageUrl, String description) async {
		return await recipesCollection.add({
			SingleRecipe.UID: uid,
			SingleRecipe.TITLE: title,
			SingleRecipe.IMAGE_URL: imageUrl,
			SingleRecipe.DESCRIPTION: description,
		});
	}	
	Future<void> updateRecipe(String uidRecipe, String title, String imageUrl, String description) async {
		return await recipesCollection.doc(uidRecipe).set({
			SingleRecipe.TITLE: title,
			SingleRecipe.IMAGE_URL: imageUrl,
			SingleRecipe.DESCRIPTION: description,
		});
	}
	Future<void> deleteRecipe(String uidRecipe) async {
		return await recipesCollection.doc(uidRecipe).delete();
	}	
	//#endregion

	Future<UserData> getUserData(UserAuth user) async{
		if (user != null){
			var doc = await userCollection.doc(user.uid).get();
			return new UserData(name: doc[UserData.NAME], gender: doc[UserData.GENDER]);
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