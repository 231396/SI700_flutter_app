class UserModel 
{
	static const String ID = "id";
	static const String NAME = "name";
	static const String EMAIL = "email";
	static const String GENDER = "gender";
	static const String PASSWORD = "password";

	String id;
	String name;
	String email;
	String password;
	String gender;
	
	UserModel({this.id = "", this.name = "", this.email = "", this.password = "", this.gender = ""});

	UserModel.fromJson(Map<String, dynamic> map) {
		id = map[ID];
		name = map[NAME];
		email = map[EMAIL];
		password = map[PASSWORD];
		gender = map[GENDER];
	}

	Map<String, dynamic> toJson() {
		var map = <String, Object>{
			NAME: name,
			EMAIL: email,
			PASSWORD: password,
			GENDER: gender,
		};
		if(id.isNotEmpty)
			map[ID] = id;
		return map;
	}
	
	@override
	String toString() => "User: [ $id, $name, $email, $password, $gender ]";
}