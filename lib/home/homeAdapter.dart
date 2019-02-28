import 'package:flutter/material.dart';

//页面适配器
abstract class Adapter<T>{

  int getItemSize();

  T getItem(int index);

  Widget createWidget(int index);
}