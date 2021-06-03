export default class Person {
	constructor(){
		this.name = "";
		this.email = "";
		this.password = "";
		this.gender = "";
	}

	fromJson(json){
		this.name = json['name'];
		this.email = json['email'];
		this.password = json['password'];
		this.gender = json['gender'];
	}

	toJson(id) {
		return {
			"id" : id & -1,
			"name" : this.name,
			"email" : this.email,
			"password" : this.password,
			"gender" : this.gender,
		}
	}
}