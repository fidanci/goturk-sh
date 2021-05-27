import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class MyColor{
 static get carrotOrange =>  Color(0xffF4941C);
 static get niagaraGreen => Color(0xff04AC8C);
 static get nuggetOrange => Color(0xffD49424);
 static get oceanGreen => Color(0xff34A474);
 }
 class SizeHelper{
   static  height(BuildContext context){
     var height = MediaQuery.of(context).size.height;
     return height;
   }
    static  width(BuildContext context){
     var width = MediaQuery.of(context).size.height;
     return width;
   }
 }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (context,index){
      return DecoratedBox(decoration: BoxDecoration(
        color: index.isEven ? Colors.orange : Colors.orangeAccent
      ));
    },
  );

  final  List<String> imgList = [
    "https://goturkishfood.com/wp-content/uploads/2019/12/Turkish-Good-Slider.jpg",
    "https://goturkishfood.com/wp-content/uploads/2019/12/Turkish-Food-Delivery.jpg",
  ];