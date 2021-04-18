///The startup file of the application
import 'package:flutter/material.dart';
import 'view/home.dart';
import 'util/database.dart';

void main() async {
	await syncTermsData();

	runApp(
		Technopedia()
	);
}

class Technopedia extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Technopedia',
			debugShowCheckedModeBanner: false,
			theme: ThemeData(
				brightness: Brightness.light,
				primaryColor: Colors.indigo[400],
				accentColor: Colors.indigo[200],
				backgroundColor: Colors.indigo[50],
				canvasColor: Colors.indigo[50],
				fontFamily: 'Roboto'
			),
			home: Home()
		);
	}
}
