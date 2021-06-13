class User 
{
	static const String ID = "id";
	static const String NAME = "name";
	static const String EMAIL = "email";
	static const String GENDER = "gender";
	static const String PASSWORD = "password";

	int id;
	String name;
	String email;
	String password;
	String gender;
	
	User({this.id = -1, this.name = "", this.email = "", this.password = "", this.gender = ""});

	User.fromJson(Map<String, dynamic> map) {
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
		if(id > -1)
			map[ID] = id;
		return map;
	}

	void printPerson() => print("[ $id, $name, $email, $password, $gender ]");
}