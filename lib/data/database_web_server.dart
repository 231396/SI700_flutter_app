import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/model/person.dart';

class DatabaseWebServer {
	/* Singleton */
	static final DatabaseWebServer helper = DatabaseWebServer._createInstance();
	DatabaseWebServer._createInstance();

	Dio _dio = Dio();

	static const databaseUrl = "http://192.168.0.102:3000/notes"; 

	//#region PersonDB 
	// INSERT
	Future<bool> insertPerson(Person person) async {
		var response = await _dio.post(databaseUrl,
				options: Options(headers: {"Accept": "application/json"}),
				data: jsonEncode(person),
			);
		if(response != null)
			return true;
		return false;
	}

	// UPDATE
	Future<int> updatePerson(Person person) async {

	}

	// DELETE
	Future<int> deletePerson(int id) async {

	}

	/* QUERYS */
	Future<List<Person>> getAllPerson() async {
		Response response = await _dio.get(databaseUrl,
				options: Options(
					headers: { "Accept": "application/json"}
					)
			);
		List<Person> list = [];
		for (int i = 0; i < response.data.length; i++){
			var data = jsonDecode(response.data[i]);
			list.add(Person.fromJson(data));
		}
		return list;
	}

	Future<List<Person>> getPersonByLogin(String email, String password) async {
		Response response = await _dio.get(databaseUrl,
				options: Options(
					headers: { "Accept": "application/json"}
					),
				queryParameters: { Person.EMAIL : email, Person.PASSWORD : password }
			);

		List<Person> list = [];
		for (int i = 0; i < response.data.length; i++){
			var data = jsonDecode(response.data[i]);
			list.add(Person.fromJson(data));
		}
		return list;
	}

	Future<List<Person>> getPersonByID(int id) async {
		Response response = await _dio.get(databaseUrl,
				options: Options(
					headers: { "Accept": "application/json"}
					),
				queryParameters: { Person.ID: id}
			);

		List<Person> list = [];
		for (int i = 0; i < response.data.length; i++){
			var data = jsonDecode(response.data[i]);
			list.add(Person.fromJson(data));
		}
		return list;
	}
	//#endregion
}