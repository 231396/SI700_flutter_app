import 'dart:async';
import 'package:flutter_app/model/person.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseWebServer {
	/* Singleton */
	static final DatabaseWebServer helper = DatabaseWebServer._createInstance();
	DatabaseWebServer._createInstance();

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
		String dbPath = await getDatabasesPath();
		String path = dbPath + dbName + ".db";
		return await openDatabase(path, version: 1, onCreate: _createDb);
	}

	FutureOr<void> _createDb(Database db, int newVersion) async {
		await db.execute("CREATE TABLE $personTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colEmail TEXT, $colGender TEXT, $colPassword TEXT)");
	}
	
	//#region PersonDB 
	// INSERT
	Future<int> insertPerson(Person person) async {
		final Database db = await this.database;
		return await db.insert(personTable, person.toMap());
	}

	// UPDATE
	Future<int> updatePerson(Person person) async {
		final Database db = await this.database;
		return await db.update(
			personTable,
			person.toMap(),
			where: "$colId = ?",
			whereArgs: [person.id],
		);
	}

	// DELETE
	Future<int> deletePerson(int id) async {
		final Database db = await this.database;
		return await db.rawDelete("DELETE FROM $personTable WHERE $colId=$id");
	}

	/* QUERYS */
	Future<List<Person>> getAllPerson() async {
		final Database db = await this.database;
		var query = await db.rawQuery("SELECT * FROM $personTable");

		List<Person> list = [];
		for (int i = 0; i < query.length; i++)
			list.add(new Person.fromMap(query[i]));
		return list;
	}

	Future<List<Person>> getPersonByLogin(String email, String password) async {
		final Database db = await this.database;
		var query = await db.rawQuery('SELECT * FROM $personTable WHERE $colEmail="$email" AND $colPassword="$password"');

		List<Person> list = [];
		for (int i = 0; i < query.length; i++)
			list.add(new Person.fromMap(query[i]));
		return list;
	}

	Future<Person> getPersonByID(int id) async {
		final Database db = await this.database;
		var query = await db.rawQuery("SELECT * FROM $personTable WHERE $colId=$id");
		
		return (query.length > 0) ? Person.fromMap(query[0]) : null;
	}
	//#endregion
}