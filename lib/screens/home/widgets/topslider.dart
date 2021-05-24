import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/helper.dart';

class SliderSection extends StatefulWidget {
  @override
  _SliderSectionState createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection> {
   final  List<String> imgList = [
     "images/dairy.jpg" , "images/meat.jpg"
     ];

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    var size = SizeHelper.height(context);
    return Column(
      children: [
        Container(
          color: Colors.orangeAccent,
          child: CarouselSlider(
            items: imgList.map((e) {
              return Image.asset(e,fit: BoxFit.cover,);
            }).toList(),
            options: CarouselOptions(
              height: size / 5,
              aspectRatio: 5.0,
              viewportFraction: 0.9,

              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 2),
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, next) {
                setState(() {
                  _current = index;
                });
              },
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );

  }
}
