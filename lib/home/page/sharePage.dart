import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home/webView.dart';

class SharePage extends StatelessWidget {
//  @override
//  State<StatefulWidget> createState() => _SharePageState();

  Future<List> _getItemDate() async {
    var client = HttpClient();
    var uri = Uri.https("timeline-merger-ms.juejin.im", "/v1/get_entry_by_rank",
        {"src": "web", "limit": "20", "category": "5562b410e4b00c57d9b94a92"});
    var request = await client.getUrl(uri);
    print("分享页面数据  数据刷新 发送请求");
    var response = await request.close();
    var body = await response.transform(Utf8Decoder()).join();
    print("分享页面数据  数据刷新" + body);
    Map map = json.decode(body);

    return map["d"]["entrylist"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分享"),
      ),
      body: FutureBuilder(
        future: _getItemDate(),
        builder: (context, data) {
          switch (data.connectionState) {
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
              break;
            case ConnectionState.active:
              print("active");
              return Container(
                child: Center(
                  child: Text("active"),
                ),
              );
            case ConnectionState.done:
              if (null != data.data) {
                List dataList = data.data;
                List<Widget> items = dataList.map((item) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new WebViewActivity(item["originalUrl"],
                                      title: item["title"])));

                      // launch('https://www.baidu.com', forceWebView: true,
                      //        forceSafariVC: true);
                      //    Navigator.of(context).pushNamed("web");
                    },
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(item["title"].toString().substring(0, 1)),
                    ),
                    title: Text(
                      item["title"],
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      item["content"],
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  );
                }).toList();
                return ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children:
                        ListTile.divideTiles(context: context, tiles: items)
                            .toList());
              }
              return Text("哈哈哈哈");
            case ConnectionState.none:
              return Container(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}

//class _SharePageState extends State<SharePage>{
//
//  Future<List> _dataFuture;
//
//  Future<List> _getItemDate() async{
//    var client = HttpClient();
//    var uri = Uri.https("timeline-merger-ms.juejin.im", "/v1/get_entry_by_rank",{"src":"web","limit":"20","category":"5562b410e4b00c57d9b94a92"});
//    var request = await client.getUrl(uri);
//    print("分享页面数据  数据刷新 发送请求");
//    var response = await request.close();
//    var body = await response.transform(Utf8Decoder()).join();
//    print("分享页面数据  数据刷新" + body);
//    Map map = json.decode(body);
//
//    return map["d"]["entrylist"];
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    _dataFuture = _getItemDate();
//  }
