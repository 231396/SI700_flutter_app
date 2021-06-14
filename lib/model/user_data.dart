class UserData 
{

	static const String UID = "uid";
	static const String EMAIL = "email";
	
	static const String NAME = "name";
	static const String GENDER = "gender";

	String uid;
	String email;
	String name;
	String gender;
	
	UserData({this.uid = "", this.email = "", this.name = "", this.gender = ""});

	UserData.fromMapUID(String uid, String email, Map<String, dynamic> map) {
		this.uid = uid;
		this.email = email;
		name = map[NAME];
		gender = map[GENDER];
	}

	UserData.fromMap(Map<String, dynamic> map) {
		uid = map[UID];
		email = map[EMAIL];
		name = map[NAME];
		gender = map[GENDER];
	}

	Map<String, dynamic> toMapNoAuth() {
		var map = <String, Object>{
			NAME: name,
			GENDER: gender,
		};
		return map;
	}

	Map<String, dynamic> toMap() {
		var map = <String, Object>{
			UID: uid,
			EMAIL: email,
			NAME: name,
			GENDER: gender,
		};
		return map;
	}

	String toString() => "[ $uid, $email, $name, $gender ]";
}