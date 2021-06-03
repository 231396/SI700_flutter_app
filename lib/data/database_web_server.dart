import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app/model/person.dart';

class DatabaseWebServer {
	/* Singleton */
	static final DatabaseWebServer helper = DatabaseWebServer._createInstance();
	DatabaseWebServer._createInstance();

	Dio _dio = Dio();

	static const databaseUrl = "http://192.168.0.102:3000/person"; 

	// INSERT
	Future<bool> insertPerson(Person person) async {
		var response = await _dio.post(databaseUrl,
				options: Options(headers: {"Accept": "application/json"}),
				data: jsonEncode(person),
			);
		return response != null;
	}

	// UPDATE
	Future<bool> updatePerson(Person person) async {
  		var response = await _dio.put(databaseUrl + "/${person.id}",
						options: Options(headers: {"Accept": "application/json"}),
						data: jsonEncode(person)
					);
		return response != null;
	}

	// DELETE
	Future<bool> deletePerson(int id) async {
		var response = await _dio.delete(databaseUrl + "/$id",
			options: Options(
				method: "GET", 
				headers: { "Accept": "application/json",
			}));
		return response != null;
	}

	//#region Query
	Future<List<Person>> getAllPerson() async {
		Response response = await _dio.get(databaseUrl,
				options: Options(
					headers: { "Accept": "application/json"}
					)
			);
		List<Person> list = [];
		for (int i = 0; i < response.data.length; i++){
			list.add(Person.fromJson(response.data[i]));
		}
		return list;
	}

	Future<Person> getPersonByLogin(String email, String password) async {
		Response response = await _dio.get(databaseUrl + "/$email/$password",
				options: Options(
					headers: { "Accept": "application/json"}
				),
			);
		if(response.data is Map<String, dynamic>){
			return Person.fromJson(response.data);
		}
		return null;
	}

	Future<Person> getPersonByID(int id) async {
		Response response = await _dio.get(databaseUrl + "/$id",
				options: Options(
					headers: { "Accept": "application/json"}
					),
			);
		if(response.data is Map<String, dynamic>){
			return Person.fromJson(response.data);
		}
		return null;
	}
	//#endregion
}