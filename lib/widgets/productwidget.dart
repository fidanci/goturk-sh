import 'package:flutter/material.dart';

class MyProduct extends StatelessWidget {
  final String name;
  final String url;
  final String price;
  final Widget onpressed;
  

  MyProduct({
    Key key,
    this.onpressed,
    this.name,
    this.url,
    this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url),scale: 5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ],
          border: Border.all(color: Colors.orange),
          borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(name, style: TextStyle(fontSize: 12,color: Colors.black)),
          ),
        
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  
                  padding: EdgeInsets.all(2),
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    price + " £",
                    style: TextStyle(fontSize: 14,color: Colors.white),
                  ),
                ),
              ),
              onpressed
            ],
          )
        ],
      ),
    );
  }
}
