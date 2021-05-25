import 'dart:async';
import 'dart:io';
import 'package:flutter_app/model/person.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLocal {
	/* Singleton */
	static DatabaseLocal helper = DatabaseLocal._createInstance();
	DatabaseLocal._createInstance();

	static Database _database;

	static const String dbName = "database";

	static const String personTable = "person_table";
	static const String colId = "id";
	static const String colName = "name";
	static const String colEmail = "email";
	static const String colGender = "gender";
	static const String colPassword = "password";

	Future<Database> get database async {
		if (_database == null)
			_database = await initializeDatabase();
		return _database;
	}

	Future<Database> initializeDatabase() async {
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + dbName + ".db";

		Database notesDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return notesDatabase;
	}

	_createDb(Database db, int newVersion) async {
		await db.execute("CREATE TABLE $personTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colEmail TEXT, $colGender TEXT, $colPassword TEXT)");
	}
	
	//#region PersonDB 
	// INSERT
	Future<int> insertPerson(Person person) async {
		Database db = await this.database;
		int result = await db.insert(personTable, person.toTableMap());
		notify();
		return result;
	}

	// UPDATE
	Future<int> updatePerson(Person person) async {
		Database db = await this.database;
		var result = await db.update(
			personTable,
			person.toTableMap(),
			where: "$colId = ?",
			whereArgs: [person.id],
		);
		notify();
		return result;
	}

	// DELETE
	Future<int> deletePerson(int id) async {
		Database db = await this.database;
		int result = await db.rawDelete("DELETE FROM $personTable WHERE $colId=$id");
		notify();
		return result;
	}

	/* QUERYS */
	Future<List<Person>> getAllPerson() async {
		Database db = await this.database;
		var query = await db.rawQuery("SELECT * FROM $personTable");

		List<Person> list = [];
		for (int i = 0; i < query.length; i++)
			list.add(new Person.fromMap(query[i]));
		return list;
	}

	Future<Person> getPersonByLogin(String email, String password) async {
		Database db = await this.database;
		var query = await db.rawQuery("SELECT * FROM $personTable WHERE $colEmail=$email AND $colName=$password");

		return (query.length > 0) ? Person.fromMap(query[0]) : null;
	}

	Future<Person> getPersonByID(int id) async {
		Database db = await this.database;
		var query = await db.rawQuery("SELECT * FROM $personTable WHERE $colId=$id");
		
		return (query.length > 0) ? Person.fromMap(query[0]) : null;
	}
	//#endregion

	/* STREAM */
	void notify() async {
		if (_controller != null) {
			var response = await getAllPerson();
			_controller.sink.add(response);
		}
	}

	Stream get stream {
		if (_controller == null)
			_controller = StreamController();
		return _controller.stream.asBroadcastStream();
	}

	void dispose() {
		if (!_controller.hasListener) {
			_controller.close();
			_controller = null;
		}
	}

	static StreamController _controller;
}