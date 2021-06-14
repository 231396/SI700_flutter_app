import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user_auth.dart';
import 'package:flutter_app/services/database_firestone.dart';

class Authentication {

	static final Authentication service = Authentication._createInstance();
	Authentication._createInstance();

	final FirebaseAuth _auth = FirebaseAuth.instance;

	UserAuth firebaseUserToUserAuth(User user) {
		return user != null ? new UserAuth.fromFirebaseUser(user) : null;
	}

	Stream<UserAuth> get user {
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

	Future<UserAuth> loginEmailAndPassword(String email, String password) async {
		try {
			var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			return firebaseUserToUserAuth(result.user);
		} catch (error) {
			print(error.toString());
			return null;
		} 
	}

	Future<UserAuth> signupEmailAndPassword(String email, String password, String name, String gender) async {
		try {
			var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			var user = result.user;
			if(user != null)
				await Database.helper.updateUserData(user.uid, name, gender);
			return firebaseUserToUserAuth(result.user);
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