import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../view/terms.dart';
import '../view/dashboard.dart';
import '../view/settings.dart';

class Home extends StatefulWidget {
	@override
	HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
		int currentPosition = 1;

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Technopedia'),
			),
			bottomNavigationBar: FancyBottomNavigation(
				tabs: [
					TabData(iconData: tabs[0].icon, title: tabs[0].title),
					TabData(iconData: tabs[1].icon, title: tabs[1].title),
					TabData(iconData: tabs[2].icon, title: tabs[2].title),
				],
				initialSelection: 1,
				onTabChangedListener: (position) {
					setState(() {
						currentPosition = position;
					});
				},
			),
			body: buildLayout(),
		);
	}

	Widget buildLayout() {
		return Container(
			decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
			child: tabs[currentPosition].widget
		);
	}
}

///Creates a widget configuration object
class CustomWidget {
	const CustomWidget({this.title, this.icon, this.widget});

	final String title;
	final IconData icon;
	final Widget widget;
}

///It specifies all tabs used on the Home page
///These are referred using the index of the List
List<CustomWidget> tabs = <CustomWidget>[
	CustomWidget(title: "Terms", icon: MdiIcons.fromString('file-word-box-outline'), widget: Terms()),
	CustomWidget(title: "Dashboard", icon: MdiIcons.fromString('view-dashboard'), widget: Dashboard()),
	CustomWidget(title: "Settings", icon: MdiIcons.fromString('cog'), widget: Settings()),
];