import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewActivity extends StatefulWidget {
  String url;
  String title;

  WebViewActivity(this.url, {this.title});

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebViewActivity> {

  var items = ['刷新','收藏','返回'];

  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: new Text(widget.title),
          elevation: 0.0,
          actions: <Widget>[
            PopupMenuButton(
              tooltip: "更多",
              offset: Offset(0.0,45.0),
              itemBuilder: (context){
                return items.map((item){
                  return new PopupMenuItem(
                      child: FlatButton(
                          child: Text(item),
                          onPressed: () async{
                            if(item == '刷新'){
                              _controller.reload();
                            }else if(item == '收藏'){

                            }else if(item == '返回'){
                                if(await _controller.canGoBack()){
                                  await _controller.goBack();
                                }else{
                                  print("退出");
                                  Navigator.pop(context);
                                }
                            }
                          },
                      )
                  );
                }).toList();
              },
              icon: Icon(Icons.more_horiz),
            )
          ],
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller){
            _controller = controller;
          },
        ),
      );
  }
}
