import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraView extends StatefulWidget {
  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  final Completer <WebViewController> _controller =Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WebView(
        initialUrl: "http://192.168.43.31",
        javascriptMode:JavascriptMode.unrestricted ,
        onWebViewCreated:(WebViewController webViewController){
          _controller.complete(webViewController);
        } ,
      )
    );
  }
}
