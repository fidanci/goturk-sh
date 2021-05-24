import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/helper.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';
import 'package:goturkishfoodapp/service/provider/provider.dart';
import 'package:html/parser.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductDetail extends StatefulWidget {
  final WooProduct product;
  const ProductDetail({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {


  final _scfKey = GlobalKey<ScaffoldState>();
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scfKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              color: Colors.green,
              icon: Icon(Icons.store),onPressed: (){},
            )
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: SizeHelper.height(context) / 30,
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(image: NetworkImage(widget.product.images[0].src)),
                 boxShadow: [
                  BoxShadow(
                    color: Colors.orangeAccent,
                    spreadRadius: 5,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  )
                ]),
                height: SizeHelper.height(context) / 2.5,
                width: SizeHelper.width(context),
                
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                 
                    width: SizeHelper.width(context) / 9,
                    height: SizeHelper.height(context) / 27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.deepOrange),
                    child: Center(
                        child: Text(
                      widget.product.regularPrice + " £",
                      style: TextStyle(color: Colors.white),
                    ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 0) {
                            setState(() {
                              quantity = quantity - 1;
                            });
                          }
                        }),
                    Text(quantity.toString() + " piece"),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity = quantity + 1;
                          });
                        }),
                  ],
                )
              ],
            ),
            Consumer(
              builder: (context,watch,child){
                final provider = watch(cartChangeNotifierProvider);
               return  FloatingActionButton.extended(
              heroTag: "addcart",
                onPressed: () {
                  if(quantity > 0){
                    provider.addToCart(wooProduct: widget.product,pQuantity: quantity);
                   
                    Navigator.pop(context);
                  }else {
                    _scfKey.currentState.showBottomSheet((context) =>  BottomSheet(onClosing: (){}, builder: (context)=>Text("Problem")));
                  }
                }, label: Text("Add to Cart"));
              },
            ),
           
            SizedBox(
              height: SizeHelper.height(context) / 30,
            ),
            FloatingActionButton.extended(
              heroTag: "payment",
              icon: Icon(Icons.payment,color: Colors.white,),
              backgroundColor: Colors.lightGreen,
                onPressed: () {}, label: Text("Go to Payment",style: TextStyle(color: Colors.white),)),
          ],
        ));
  }
}
