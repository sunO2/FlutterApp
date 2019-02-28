import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewActivity extends StatefulWidget{

  String url;
  String title;

  WebViewActivity(this.url,{
    this.title
  });

  @override
  State<StatefulWidget> createState()  => _WebViewState();
}

class _WebViewState extends State<WebViewActivity>{
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
        url: widget.url,
        withJavascript: true,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.title,),
        ),
    );
  }

}