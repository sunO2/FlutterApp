import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home/login.dart';
import 'package:flutter_demo/home/page/coustom_banner.dart';
import 'package:flutter_demo/widget/banner/banner_entity.dart';
import 'package:transparent_image/transparent_image.dart';


class HomePage extends StatelessWidget{

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  void _login(BuildContext context,int index) async{
    print("index  ----》》》》 ： $index");
    var resul = await Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context)
        => new LoginActivity(index: index)
        ));

    print("登录数据 $resul");
    if(null != resul){
      key.currentState.showSnackBar(SnackBar(content: Text(resul.toString())));
    }
  }




  Future<List<BannerEntity>> _getBanner() async {

    var http = HttpClient();
    var uri = Uri.http("www.wanandroid.com","/banner/json");
    var request = await http.getUrl(uri);
    var response = await request.close();
    var body = await response.transform(Utf8Decoder()).join();

    Map<String,dynamic> jsonStr = json.decode(body);
    List list = jsonStr['data'];
    return list.map((item){
      var itemEntity = SimpleEntity.fromJson(item);
      print("DATAS = 发送请求 数据 $item  -->>>>  ${itemEntity.runtimeType}");
      return itemEntity;

    }).toList();


  }

  //  @override
//  State<StatefulWidget> createState() => _HomePageState();
  Widget getListItem(BuildContext context,int index){
    return InkWell(
      onTap: (){
        key.currentState.hideCurrentSnackBar();
        key.currentState.showSnackBar(
            SnackBar(
              content: Text("点击了第 $index 条"),
            )
        );
      },
      onLongPress: (){
        key.currentState.hideCurrentSnackBar();
        key.currentState.showSnackBar(
            SnackBar(
              content: Text("长按 $index 条"),
            )
        );
      },
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8.0,top: 4.0,right: 8.0,bottom: 4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child:Container(
                        child:SizedBox(
                          width: 64.0,
                          height: 64.0,
                          child:Hero(
                            tag: "head_$index",
                            child: Image.network("https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1528432446&di=37a006e7cccf4abb450090dfc1143c25&src=http://pic35.photophoto.cn/20150509/0010023742301768_b.jpg"),
                          ),
                        ),
                      ),
                      onTap: (){
                        _login(context,index);
                      },
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text("我的女王大人",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text("傻宝宝喔",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: const Color(0xFF737272)
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("18:00",
                            style: TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF737272)
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: const Color(0xFF737272),
                  width: double.maxFinite,
                  height: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WeChat"),
      ),
      key:  key,

      body: FutureBuilder(
        future: _getBanner(),
          builder: (context,connectionState){
        if(connectionState.connectionState == ConnectionState.done){
          if(null == connectionState.data){
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          return ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              if(index == 0){
                print("创建 banner");
                return CoustomBanner(
                  data: connectionState.data,
                  delayTime: 3500,
                  duration: 500,
//              bannerPress: (position, entity){
//                print("点击了");
//                key.currentState.showSnackBar(SnackBar(content: Text("点击 ($entity)")));
//              },
                  itemBuilder: (position, entity) {
                    return Card(
                      elevation: 3.5,
                      margin: const EdgeInsets.all(12.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: entity.bannerUrl.toString(),
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                );
              }
              return getListItem(context,index);
            },
          );
        }else if(connectionState.connectionState == ConnectionState.active){
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }else if(connectionState.connectionState == ConnectionState.waiting){
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }else if(connectionState.connectionState == ConnectionState.none){
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
      }),
    );
  }

}

class SimpleEntity extends BannerEntity {
  final String obj;
  final String imageUrl;
  final String title;
  final String url;

  SimpleEntity({this.obj, this.imageUrl, this.title,this.url});

  SimpleEntity.fromJson(Map<String,dynamic> json,{this.obj}):
        imageUrl = json['imagePath'],
        url = json["url"],
        title = json['title'];

  @override
  get bannerUrl => imageUrl;

  @override
  get bannerTitle => title;

  @override
  get actionUrl => url;

}

