import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class WebViewWidget extends StatelessWidget {

  final String url;
  final String title;

  WebViewWidget({
    @required this.url,
    this.title = ''
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

}