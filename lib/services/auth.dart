import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/services/database_firestone.dart';

class Authentication {

	static final Authentication service = Authentication._createInstance();
	Authentication._createInstance();

	final FirebaseAuth _auth = FirebaseAuth.instance;

	UserModel firebaseUserToUserModel(User user) {
		if (user != null) {
			//TODO - GET GENDER AND NAME
			return new UserModel(id: user.uid, email: user.email, name: "", gender: "");
		} else {
			return null;
		}
	}

	Stream<UserModel> get user {
		return _auth.authStateChanges().map(firebaseUserToUserModel);
	}
	
	Stream<User> get firebaseUser {
		return _auth.authStateChanges();
	}

	Future<User> loginAnonymous() async {
		try {
			var result = await _auth.signInAnonymously();
			return result.user;
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	Future<User> loginEmailAndPassword(String email, String password) async {
		try {
			var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			return result.user;
		} catch (error) {
			print(error.toString());
			return null;
		} 
	}

	Future<User> signupEmailAndPassword(String email, String password, String name, String gender) async {
		try {
			var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			var user = result.user;
			if(user != null)
				await Database.helper.updateUserData(user.uid, name, gender);
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