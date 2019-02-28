import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo/home/webView.dart';
import 'package:flutter_demo/utils/log.dart';
import 'package:flutter_demo/widget/banner/banner_entity.dart';


typedef IIndexedWidgetBuilder(int index,BannerEntity entity);

int maxCount = double.maxFinite.toInt() - 2;

int _currentPage = 0;
///自定义的 Banner 滑动页面
/// 可定时
class CoustomBanner extends StatefulWidget{

  final List<BannerEntity> data;

  final IIndexedWidgetBuilder itemBuilder;
   //滑动周期
  final int delayTime;

  final int duration;

  int _currentPage = 0;

  ///数据
  ///banner 内容构造器
  CoustomBanner({
    @required this.data,
    @required this.itemBuilder,
    this.delayTime = 1500,
    this.duration = 300
  }):assert(null != data),
     assert(null != itemBuilder);


  @override
  State<StatefulWidget> createState() => _BannerState();

}

class _BannerState extends State<CoustomBanner>{

  ///page 滑动控制器
  PageController _controller;

  ///定时器
  Timer _timer;

  @override
  void initState() {
    print("初始化页面状态");
    LogUtils.log("hahah");
    ///计算当前页面的值
    double current = (maxCount / 2) - ((maxCount / 2) % widget.data.length);
    _controller = PageController(initialPage: _currentPage);
    start();
    super.initState();
  }

  ///开启滑动
  void start(){
    stop();
    _timer = Timer.periodic(Duration(milliseconds: widget.delayTime),(timer){
      if(widget.data.length > 0) {
        _controller.animateToPage(_controller.page.toInt() + 1, //切换页面
            duration: Duration(milliseconds: widget.duration), //切换时间
            curve: Curves.decelerate); //切换方式 差值器
      }
    });
  }

  ///停止滑动
  void stop(){
    _timer?.cancel();
    _timer = null;
  }

  ///创建 Banner 的样式
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Stack(
        children: <Widget>[
          createViewPage()
        ],
      ),
    );
  }

  ///构建 ViewPage
  Widget createViewPage(){
    return PageView.builder(
      itemCount:widget.data.length>0?maxCount.toInt():0,
      controller: _controller,
      onPageChanged: (index){
        setState(() {

        });
      },
      itemBuilder: (context,index){
        print("构建页面");
        return InkWell(
          child: widget.itemBuilder(index,widget.data[index % widget.data.length]),
          onTap: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                WebViewActivity(widget.data[index % widget.data.length].bannerUrl,
                  title: widget.data[index % widget.data.length].bannerTitle,
                )
            ));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stop();
    _controller.dispose();
    print("销毁");
    super.dispose();

  }
}















