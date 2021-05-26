import 'package:flutter_app/data/database_local.dart';

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
	
	Person(){
		_id = null;
		_name = "";
		_email= "";
		_password= "";
		_gender = "";
	}

	Person.fromMap(Map<String, Object> map) {
		this._id = map[DatabaseLocal.colId];
		this._name = map[DatabaseLocal.colName];
		this._email = map[DatabaseLocal.colEmail];
		this._password = map[DatabaseLocal.colPassword];
		this._gender = map[DatabaseLocal.colGender];
	}

	Map<String, Object> toMap() {
		var map = <String, Object>{
			DatabaseLocal.colName: _name,
			DatabaseLocal.colEmail: _email,
			DatabaseLocal.colPassword: _password,
			DatabaseLocal.colGender: _gender,
		};
		if(_id != null)
			map[DatabaseLocal.colId] = _id;
		return map;
	}

	void printPerson() => print("[ $_id, $_name, $_email, $_password, $_gender ]");
}
