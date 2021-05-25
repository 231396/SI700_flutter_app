class Person 
{
	int _id;
	String _name;
	String _email;
	String _password;
	String _gender;

	int get id => _id;
	String get name => _name;
	String get email => _email;
	String get password => _password;
	String get gender => _gender;

	set id(int number) {
		this._id = number;
	}
	set name(String str) {
		if (str.isNotEmpty)
			this._name = str;
	}
	set email(String str) {
		if (str.isNotEmpty)
			this._email = str;
	}
	set password(String str) {
		if (str.isNotEmpty)
			this._password = str;
	}

	set gender(String str) {
		if (str.isNotEmpty)
			this._gender = str;
	}
	
	Person.fromMap(Map<String, Object> map) {
		this._id = map["id"];
		this._name = map["name"];
		this._email = map["email"];
		this._password = map["password"];
		this._gender = map["gender"];
	}

	Map<String, Object> toMap() {
		var map = new Map<String, Object>();
		map["id"] = _id;
		map["name"] = _name;
		map["email"] = _email;
		map["password"] = _password;
		map["gender"] = _gender;
		return map;
	}
}
