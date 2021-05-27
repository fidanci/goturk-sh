import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/product/productdetail.dart';
import 'package:goturkishfoodapp/widgets/productlist.dart';

import '../../service/provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer(builder: (context, watch, child) {
        final provider = watch(cartChangeNotifierProvider);
        var price = provider.getTotalprice();

        return RefreshIndicator(
          onRefresh: () async {
            return context.refresh(cartChangeNotifierProvider.notifier);
          },
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: provider.cartList.length,
                    itemBuilder: (context, i) {
                      var list = provider.cartList;
                      var pro = list[i].product;

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetail(
                                        product: pro,
                                      )));
                        },
                        child: Container(
                          height: 150,
                          child: ProductList(
                            adet: list[i].quantity.toString() + " piece ",
                            name: pro.name,
                            price: pro.price + "E",
                            img: pro.images[0].src,
                            child: TextButton(
                              child: Text("Remove"),
                              onPressed: () {},
                            ),
                            buton: IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  list.removeAt(i);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                margin: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(price.roundToDouble().toString() + " GBP",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      ElevatedButton(
                        child: Text(
                          "Pay",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )),
            ],
          ),
        );
      }),
    );
  }
}
