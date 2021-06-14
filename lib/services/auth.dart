import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/model/user.dart';

class Authentication {

	static final Authentication service = Authentication._createInstance();
	Authentication._createInstance();

	final FirebaseAuth _auth = FirebaseAuth.instance;

	UserModel _firebaseUserToLocalUser(User user) {
		return user != null ? new UserModel(id: user.uid, email: user.email) : null;
	}

	Stream<UserModel> get user {
		return _auth.authStateChanges().map(_firebaseUserToLocalUser);
	}

	Future<dynamic> loginAnonymous() async {
		try {
			var result = await _auth.signInAnonymously();
			return _firebaseUserToLocalUser(result.user);
		} catch (e) {
			print(e.toString());
			return null;
		}
	}

	Future<dynamic> loginEmailAndPassword(String email, String password) async {
		try {
			var result = await _auth.signInWithEmailAndPassword(email: email, password: password);
			var user = result.user;
			return user;
		} catch (error) {
			print(error.toString());
			return null;
		} 
	}

	Future<dynamic> signupEmailAndPassword(String email, String password) async {
		try {
			var result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
			var user = result.user;
			// await Database.helper(uid: user.uid).updateUserData('0','new crew member', 100);
			return _firebaseUserToLocalUser(user);
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