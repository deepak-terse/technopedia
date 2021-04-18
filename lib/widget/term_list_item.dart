/// a file which lets you creat a ListItem to show *Term* details
import 'package:flutter/material.dart';

import '../model/term_model.dart';
import '../view/term_details.dart';

///Creates a ListTile object
class TermListItem extends StatelessWidget {
	TermListItem({
		this.index,
		this.term,
	});

	final int index;
	final Term term;

	@override
	Widget build(BuildContext context) {
		return ListTile(
			title: Text(
				term.title,
				style: TextStyle(
					fontSize: 20.0,
				),
			),
			visualDensity: VisualDensity(horizontal: 0, vertical: -4),
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => Center(
						child: TermDetails(term)
					))
				);						
			}
		);
	}
}
