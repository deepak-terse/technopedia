///A file that defines 'Term' model and its properties.
///It provides methods to perform all CRUD operations on the model
import 'package:sqflite/sqflite.dart';
import '../util/database.dart';

///*Term* model
class Term{
	final int id;	
	final String title;
	final String subTitle;
	final String category;
	final String descriptionUrl;

	Term({
		this.id,
		this.title,
		this.subTitle,
		this.category,
		this.descriptionUrl
	});

	///Convert a Term into a Map
	Map<String, dynamic> toMap() {
		return {
			'id': id,
			'title': title,
			'subTitle': subTitle,
			'category': category,
			'descriptionUrl': descriptionUrl
		};
	}

	/// Implement toString to make it easier to see information about each Term when using the print statement.
	@override
	String toString() {
		return 'Term{id: $id, title: $title, descriptionUrl: $descriptionUrl}';
	}
}

///Create record
Future<void> insertTerm(Term term) async {
	final Database db = await database;

	///*ConflictAlgorithm.replace* replaces old record if it is already present in the database.
	///And inserts a new record if it is not present.
	await db.insert(
		'terms',
		term.toMap(),
		conflictAlgorithm: ConflictAlgorithm.replace,
	);
}

///Read records
Future<List<Term>> fetchTerms(String searchKeyword) async {
	final Database db = await database;
	var whereQuery = searchKeyword.isEmpty ? null : "title LIKE \'%" + searchKeyword + "%\'";


	///Executes the query and stores reslut in *maps*
	final List<Map<String, dynamic>> maps = await db.query(
		'terms',
		columns: ['id','title','subTitle','category','descriptionUrl'],
		where: whereQuery,
		orderBy: "title"
	);

	// Convert the List<Map<String, dynamic> into a List<Term>.
	return List.generate(maps.length, (i) {
		return Term(
			id: maps[i]['id'],
			title: maps[i]['title'],
			subTitle: maps[i]['subTitle'],
			category: maps[i]['category'],
			descriptionUrl: maps[i]['descriptionUrl']
		);
	});
}
