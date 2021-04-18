///A file which specifies all database related configuration.
///It provides methods to provide initialisation and sync operation on the database.
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/term_model.dart';
import '../util/gsheets.dart';

Database db;

Future<Database> get database async {
    if (db != null) {
      return db;
    }

    db = await initDatabase();
    return db;
}

///To initialise the database and create a schema
///Called everytime the application is launched 
initDatabase() async {
	///To avoid errors caused by flutter upgrade.
	///Importing 'package:flutter/widgets.dart' is required.
	WidgetsFlutterBinding.ensureInitialized();

	///Note: Using the `join` function from the `path` package is best practice to ensure the path is correctly constructed for each platform.
	String path = join(await getDatabasesPath(), 'technopedia_database.db');

	///Setup database
	return await openDatabase(
		path,	///Set the path to the database.
		version: 1,	///Set the version. This executes the onCreate function and provides a path to perform database upgrades and downgrades.
		onCreate: onCreate	// When the database is first created, create a table to store Terms.
	);
}

void onCreate(Database db, int version) async {
	await db.execute('CREATE TABLE terms(id INTEGER PRIMARY KEY, title TEXT, subTitle TEXT, category TEXT, descriptionUrl TEXT)');
}

///to sync the local data stored in SQLite with the data store in the Google sheets
///It ensures that the local database is always up to date with the Google sheets
Future syncTermsData() async{
	///Fetches all records from the Google sheets
	var remoteData = await fetchsheet();
	///It updates the local records with the new one.
	remoteData.forEach((element) async {
		final id = int.parse(element[0]);

		var termData = Term(
			id: id,
			title: element[1],
			subTitle: element[2],
			category: element[3],
			descriptionUrl: element[4]
		);
		await insertTerm(termData);
	});    
}