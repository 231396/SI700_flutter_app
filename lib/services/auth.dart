import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user_data.dart';
import 'package:flutter_app/services/database_firestone.dart';

class Authentication {

	static final Authentication service = Authentication._createInstance();
	Authentication._createInstance();

	final FirebaseAuth _auth = FirebaseAuth.instance;

	UserData firebaseUserToUserAuth(User user) {
		return user != null ? new UserData(uid: user.uid, email: user.email) : null;
	}

	Stream<UserData> get user {
		return _auth.authStateChanges().map(firebaseUserToUserAuth);
	}

	// Future<User> loginAnonymous() async {
	// 	try {
	// 		var result = await _auth.signInAnonymously();
	// 		return result.user;
	// 	} catch (e) {
	// 		print(e.toString());
	// 		return null;
	// 	}
	// }

	Future<UserData> loginEmailAndPassword(String email, String password) async {
		try {
			var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			return firebaseUserToUserAuth(result.user);
		} catch (error) {
			print(error.toString());
			return null;
		} 
	}

	Future<UserData> signupEmailAndPassword(String email, String password, String name, String gender) async {
		try {
			var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			var user = firebaseUserToUserAuth(result.user);
			if(user != null){
				user.name = name;
				user.gender = gender;
				await Database.helper.updateUserData(user);
			}
			return user;
		} catch (error) {
			print(error.toString());
			return null;
		} 
	}

	Future<void> signOut() async {
		try {
			await _auth.signOut();
		} catch (error) {
			print(error.toString());
		}
	}
}