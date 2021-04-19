import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
	CustomWebView(this.title, this.url);
	
	final String title;
	final String url;

	@override
  	WebViewState createState() => WebViewState();
}

class WebViewState extends State<CustomWebView> {
	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title: Text(this.widget.title),
			),
			body: WebView(
				initialUrl: this.widget.url,
				javascriptMode: JavascriptMode.unrestricted,
			),
        );
	}
}