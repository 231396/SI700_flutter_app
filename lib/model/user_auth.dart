import 'package:firebase_auth/firebase_auth.dart';

class UserAuth
{
	static const String UID = "uid";
	static const String EMAIL = "email";

	String uid;
	String email;
	
	UserAuth({this.uid = "", this.email = ""});

	UserAuth.fromFirebaseUser(User user){
		uid = user.uid;
		email = user.email;
	}

	UserAuth.fromJson(Map<String, dynamic> map) {
		uid = map[UID];
		email = map[EMAIL];
	}

	Map<String, dynamic> toJson() {
		var map = <String, Object>{
			UID: uid,
			EMAIL: email,
		};
		return map;
	}

	String toString() => "User: [ $uid, $email]";
}