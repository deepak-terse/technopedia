import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

import '../model/term_model.dart';
import '../widget/term_list.dart';

class Terms extends StatefulWidget {
	@override
  	TermsState createState() => TermsState();
}

class TermsState extends State<Terms>  with TickerProviderStateMixin {
	TextEditingController controller = new TextEditingController();
	String searchKeyword = "";
	stt.SpeechToText speech;
	bool available = false;
	String hintText = "Search";

	@override
	void initState() {
		super.initState();
	}

	void initSpeech() async{
		speech = stt.SpeechToText();
		speech.initialize( onStatus: null, onError: null ).then((value) {
			available = value;
			onPressed();
		});
	}

	@override
	Widget build(BuildContext context){
		return new Scaffold(
			body: new NestedScrollView(
				headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
				return <Widget>[
					new SliverAppBar(
						floating: true, pinned: false, snap: true,
						bottom: PreferredSize(
							preferredSize: Size.fromHeight(25.0),
							child: Container(
								color: Theme.of(context).primaryColor,
								child: new Padding(
									padding: const EdgeInsets.all(8.0),
									child: new Card(
										child: new ListTile(
											leading: new Icon(Icons.search),
											title: new TextField(
												controller: controller,
												decoration: new InputDecoration(
													hintText: hintText, 
													border: InputBorder.none
												),
												onChanged: onSearchTextChanged,					
											),
											trailing: new IconButton(
												icon: searchKeyword == "" ? new Icon(Icons.mic) : new Icon(Icons.cancel), 
												onPressed: onPressed
											)
										),
									),
								),
							),
						)
					),
				];
				},
				body: FutureBuilder(
					future: fetchTerms(searchKeyword),
					builder: (context, snapshot) {
						if(snapshot.connectionState != ConnectionState.done) {
							// return: progress indicator object
						}
						if(snapshot.hasError) {
							// return: show error widget
						}

						final List<Term> terms = snapshot.data ?? [];						
						return TermList(terms);
					}
				),
			)
		);
	}

	onSearchTextChanged(String text) async {
		setState(() {
			searchKeyword = text;
		});
  	}

	void resultListener(SpeechRecognitionResult result) {
		if (result.finalResult) {
			setState(() {
				searchKeyword = result.recognizedWords;
				controller.text = searchKeyword;
				hintText = "Search";
			});
		}								
  	}

	void onPressed() {
		if (!available) {
			initSpeech(); 
		}
		else {
			if (searchKeyword == "") {
				setState(() { hintText = "Listening..."; });
				available ? speech.listen(onResult: resultListener) : setState(() { hintText = "Search"; });
			} else {
				controller.clear();
				onSearchTextChanged('');
			}
		}
	}
}