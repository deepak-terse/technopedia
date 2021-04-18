import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:technopedia/model/term_model.dart';

import '../model/term_model.dart';
import '../util/dateTime.dart';

class Trending extends StatefulWidget {
	final Term term = Term(
		id: 1,
		title: 'HTML',
		subTitle:'Markup Language',
		category: 'Programming Language',
		descriptionUrl: 'https://raw.githubusercontent.com/deepak-terse/wysa-backend/main/README.md'
	);

	@override
  	TrendingState createState() => TrendingState();
}

class TrendingState extends State<Trending> {
	@override
	Widget build(BuildContext context){
		return ListView(
			padding: EdgeInsets.all(10.0),
			children: [
				Container(
					height: 550,
					child: 
						Card(	
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(15.0),
							),
							child: Padding(
								padding: EdgeInsets.all(16.0),
								child: Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									children: [
										buildHeaderSection(),
										buildTitleSection(),
										buildSubtitleSection(),
										FutureBuilder(
											future: getData(),
											builder: (context, snapshot) {
												if(snapshot.connectionState != ConnectionState.done) {
													// return: progress indicator object
												}
												if(snapshot.hasError) {
													// return: show error widget
												}

												final String markDown = snapshot.data ?? "";						
												return Expanded(
													child: Markdown(
														data: markDown
													)
												);
											}
										)
									]
								)
							)
					)
				)
			]
		);
	}

	Widget buildHeaderSection() {
		return Row(
			children: [
				Expanded(child: Text(getTodaysFormattedDate())),
				Expanded(child: Text(
					"Term of the Day",
					textAlign: TextAlign.right
				))
			]
		);
	}

	Widget buildTitleSection() {
		return Center(
			child: Text(
				widget.term.title,
				style: TextStyle(
					fontSize: 30.0,
					fontWeight: FontWeight.bold
				),
			),
		);
	}

	Widget buildSubtitleSection() {
		return Center(
			child: Text(
				widget.term.subTitle,
				style: TextStyle(
					fontSize: 20.0,
					fontWeight: FontWeight.bold
				),
			),
		);
	}

	Future<String> getData() async {
		return await http.read(widget.term.descriptionUrl);
	}
}
