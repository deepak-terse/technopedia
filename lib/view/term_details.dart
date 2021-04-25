import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share/share.dart';

import '../model/term_model.dart';
import '../view/customWebView.dart';

class TermDetails extends StatefulWidget {
	TermDetails(this.term);

	final Term term;

	@override
  	TermDetailsState createState() => TermDetailsState();
}

class TermDetailsState extends State<TermDetails> {

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: buildAppBar(),
			body: Container(
				decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
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
											data:markDown,
											styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(textScaleFactor: 1.2, h4: TextStyle(color: Colors.transparent, height: 2)),
											onTapLink: (text, url, title) { /* some changes in params */
												Navigator.push(
													context,
													MaterialPageRoute(builder: (context) => Center(
														child: CustomWebView(text, url)
													))
												);
											}
										)
									);
								}
							)
						]
					)
				// )	
			),
			floatingActionButton: buildFloatingActionButton()
		);
	}

	Widget buildAppBar() {
		return  AppBar(
			title: Text("Technopedia"),
		);
	}

	Widget buildFloatingActionButton() {
		return FloatingActionButton(
			onPressed: () {
				final RenderBox box = context.findRenderObject();

				Share.share(widget.term.title + ' : \n' + widget.term.descriptionUrl,
								subject: widget.term.title,
								sharePositionOrigin:
									box.localToGlobal(Offset.zero) &
										box.size);
			},
			child: Icon(Icons.share),
			backgroundColor: Theme.of(context).primaryColor,
			foregroundColor: Colors.white
		);
	}

	Widget buildTitleSection() {
		return Center(
			child: Text(
				"\n" + widget.term.title,
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