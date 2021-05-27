import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  final String price;
  final String img;
  final String name;
  final Widget child;
  final Widget buton;
  final String adet;
  const ProductList({
 
    Key key,
    this.adet,
    this.price,
    this.img,
    this.name,
    this.child,
     this.buton,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      body: Container(
       
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
         boxShadow: [
           BoxShadow( color: Colors.orangeAccent,
                    spreadRadius: 6,
                    blurRadius: 4,
                    offset: Offset(1, 3),)
         ],
            borderRadius: BorderRadius.all(
          Radius.circular(20),
        
        )),
      
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                
                  child: Image.network(
                      img),
                )),
          
            Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(name),
                      Text(adet),
                      child
                    ],
                  ),
                )),
            SizedBox(
              width: 1,
              child: Container(
                color: Colors.black,
              ),
            ),
            Expanded(
              
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(price),
                      buton,
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
