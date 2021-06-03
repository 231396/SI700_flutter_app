class Person 
{
	static const String ID = "id";
	static const String NAME = "name";
	static const String EMAIL = "email";
	static const String GENDER = "gender";
	static const String PASSWORD = "password";

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
	
	Person(){
		_id = -1;
		_name = "";
		_email= "";
		_password= "";
		_gender = "";
	}

	Person.fromJson(Map<String, Object> map) {
		_id = map[ID];
		_name = map[NAME];
		_email = map[EMAIL];
		_password = map[PASSWORD];
		_gender = map[GENDER];
	}

	Map<String, Object> toJson() {
		var map = <String, Object>{
			NAME: _name,
			EMAIL: _email,
			PASSWORD: _password,
			GENDER: _gender,
		};
		if(_id > -1)
			map[ID] = _id;
		return map;
	}

	void printPerson() => print("[ $_id, $_name, $_email, $_password, $_gender ]");
}
