/// a file which lets you creat a ListView to list *Terms*
import 'package:flutter/material.dart';
import '../model/term_model.dart';
import 'term_list_item.dart';

///Creates a ListView object
class TermList extends StatefulWidget {
	TermList(this.terms);

	final List<Term> terms;

	TermListState createState() => TermListState();
}

class TermListState extends State<TermList> {
	@override
	Widget build(BuildContext context) {
		return ListView.separated(
			shrinkWrap: true,
			separatorBuilder: (context, index) => Divider(
				height: 1.0
			),
			itemCount: widget.terms.length,
			itemBuilder: (context, index) => Container(
				color: Theme.of(context).canvasColor,
				child: TermListItem(
					index: index,
					term: widget.terms[index]
				)
			)
		);
	}
}