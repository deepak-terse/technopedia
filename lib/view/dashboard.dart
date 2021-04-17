import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
	@override
  	DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
	@override
	Widget build(BuildContext context){
		return Container(
			child: Text("Dashboard")
		);
	}
}