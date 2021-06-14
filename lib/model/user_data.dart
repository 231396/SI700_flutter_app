class UserData 
{
	static const String NAME = "name";
	static const String GENDER = "gender";

	String name;
	String gender;
	
	UserData({this.name = "", this.gender = ""});

	UserData.fromJson(Map<String, dynamic> map) {
		name = map[NAME];
		gender = map[GENDER];
	}

	Map<String, dynamic> toJson() {
		var map = <String, Object>{
			NAME: name,
			GENDER: gender,
		};
		return map;
	}

	String toString() => "[ $name, $gender ]";
}