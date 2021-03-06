import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/home/page/AnimatedListSample.dart';
import 'package:flutter_demo/home/page/homePage.dart';
import 'package:flutter_demo/home/page/searchPage.dart';
import 'package:flutter_demo/home/page/sharePage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //页面
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _key = GlobalKey();
//  Widget[] _bottomItems

  List<Widget> _pages = <Widget>[
    new HomePage(),
    new SharePage(),
    new SearchPage(),
    new AnimatedListSample()
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      key: _key,
      body: getCurrentPage(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _login,
        tooltip: '登录',
        disabledElevation: 8.0,
        child: Text(
          "登录",
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
        onTap: (select) {
          setState(() {
            print("刷新界面");
            _currentIndex = select;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(
              icon: Icon(Icons.import_contacts), title: Text("分享")),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text("搜索")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity), title: Text("我"))
        ],
      ),
      drawer: Drawer(
        elevation: 80.0,
        child: Column(
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: UserAccountsDrawerHeader(
                accountName: Text("hezhihu89"),
                accountEmail: Text("hezihu89@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  minRadius: 80.0,
                  backgroundImage: NetworkImage("http://img5.duitang.com/uploads/item/201409/23/20140923094045_BNYji.thumb.700_0.png"),
                ),
                otherAccountsPictures:<Widget>[
                  CircleAvatar(backgroundImage: NetworkImage("http://img5.duitang.com/uploads/item/201409/27/20140927095143_YaZAM.jpeg"),),
                  CircleAvatar(backgroundImage: NetworkImage("http://img4.duitang.com/uploads/item/201412/24/20141224224554_SuYth.thumb.700_0.jpeg"),),
                  CircleAvatar(backgroundImage: NetworkImage("http://img5.duitang.com/uploads/item/201410/05/20141005082835_2RTzn.thumb.700_0.jpeg"),),
                ],
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("http://img15.3lian.com/2015/f2/57/d/93.jpg"),
                      fit: BoxFit.fitHeight
                  )
                ),
              ),
            ),
            Expanded(
                flex: 5,
                child: ListView(
                  children: <Widget>[
                    ListTile(leading: CircleAvatar(child: Icon(Icons.add_alert)),title: Text("我的提醒")),
                    ListTile(leading: CircleAvatar(child: Icon(Icons.access_time)),title: Text("时间导航")),
                    ListTile(leading: CircleAvatar(child: Icon(Icons.access_alarm)),title: Text("闹钟集合")),
                    ListTile(leading: CircleAvatar(child: Icon(Icons.account_balance)),title: Text("时间组织")),
                    ListTile(leading: CircleAvatar(child: Icon(Icons.airport_shuttle)),title: Text("时间装载")),
              ],
            ))
          ],
        ),
      ),
    );
  }

  //登录
  void _login() async {
//    try {
//      var platform = await const MethodChannel('flutter_batterylevl');
//      var result = platform.invokeMethod("start");
//      print("返回数据 ： $result");
//    }catch(e){
//      print( "错误 ：$e" );
//    }

    final result = await Navigator.of(context).pushNamed("login");
    print('$result');
    if (result != null) {
      _key.currentState.showSnackBar(SnackBar(content: Text("$result")));
    }
  }

  // 获取当前界面
  Widget getCurrentPage() {
    return new IndexedStack(
      children: _pages,
      index: _currentIndex,
    );
  }
}
