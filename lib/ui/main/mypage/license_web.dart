import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  WebViewApp(this.uri,{Key? key}) : super(key: key);
  String uri;

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        //centerTitle: false,
        elevation: 0,
        title:  Text('라이센스 링크', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),),
      ),
      body: WebView(
        initialUrl: widget.uri,
      ),
    );
  }
}