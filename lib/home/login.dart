import 'package:flutter/material.dart';

class LoginActivity extends StatefulWidget {
  int index;

  LoginActivity({this.index});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<LoginActivity> {
  GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  TextEditingController _userNameEditingController = TextEditingController();
  TextEditingController _passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var index = widget.index;
    print("index ： $index");
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("登录"),
        leading: IconButton(
          icon: Icon(Icons.backup),
          onPressed: () {
            Navigator.pop(context, "登陆失败");
          },
        ),
      ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: EdgeInsets.all(16.0),
        child: Card(
            elevation: 8.0,
            child: SingleChildScrollView(
//            reverse: true,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16.0),
                  ),
                  SizedBox(
//                      width: 64.0,
//                      height: 64.0,
                      child: Hero(
                          tag: "head_$index",
                          child: new Image.network(
                              "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1528432446&di=37a006e7cccf4abb450090dfc1143c25&src=http://pic35.photophoto.cn/20150509/0010023742301768_b.jpg"))),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      autovalidate: true,
                      child: Column(children: <Widget>[
                        Material(
                            type: MaterialType.canvas,
                            shape: new StadiumBorder(
                                side: new BorderSide(
                                    color: Colors.green,
                                    style: BorderStyle.solid)),
                            child: TextFormField(
                              controller: _userNameEditingController,
                              autofocus: false,
                              key: _formStateKey,
                              validator: (userName) {
                                if (userName.length < 6) {
                                  return "用户名必须6位";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                isDense: true,
                                icon: Icon(Icons.verified_user),
                                hintText: "输入用户名",
                                labelText: "用户名",
                                suffixIcon: IconButton(
                                  icon: new Icon(Icons.close),
                                  onPressed: () {
                                    _userNameEditingController.text = "";
                                  },
                                ),
                                labelStyle: new TextStyle(),
                              ),
                            )),
                        TextFormField(
                          autofocus: false,
                          controller: _passwordEditingController,
                          validator: (userName) {
                            if (userName.length < 5) {
                              return "密码长度不对";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            icon: Icon(Icons.verified_user),
                            hintText: "输入密码",
                            labelText: "密码",
                            suffixIcon: IconButton(
                              icon: new Icon(Icons.close),
                              onPressed: () {
                                _passwordEditingController.text = "";
                              },
                            ),
                          ),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  print("点击了");
                                  Navigator.of(context).pop('登陆失败');
                                },
                                child: Text("注册"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pop('登陆成功');
                                },
                                child: Text("登录"),
                              )
                            ],
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
