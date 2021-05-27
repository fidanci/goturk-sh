import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/helper.dart';
import 'package:goturkishfoodapp/screens/product/productdetail.dart';
import 'package:goturkishfoodapp/service/provider/provider.dart';
import 'package:goturkishfoodapp/widgets/productwidget.dart';
import 'package:woocommerce/models/products.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final key = GlobalKey<FormState>();
  String text;
  List<WooProduct> product = [];
  bool arama = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: key,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildTextFormField(context),
          ),

         
          Expanded(child: buildSearch())
        ],
      ),
    ));
  }

  TextFormField buildTextFormField(BuildContext context) {
    return TextFormField(
            maxLines: 1,
            validator: (String value) {
              if (value.length > 0) {
                text = value;
                return "null";
              }else return "Check name";
            },
            onChanged: (String value) {
              text = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              hintText: "Search",
              suffixIcon: IconButton(
              splashColor: Colors.orange,
              iconSize: 40,
              color: Colors.orange,
              icon: Icon(Icons.search),
              onPressed: () {
                key.currentState.save();
                setState(() {
                  context.refresh(getProductsQuery(text));
                  key.currentState.reset();
                  
                });
                
              },
            ),
              
            ),
            
          );
  }

  Container buildSearch() {
    return Container(
      padding: EdgeInsets.all(5),
      child: Consumer(builder: (context, watch, child) {
        var data = watch(getProductsQuery(text));
        var cart = watch(cartChangeNotifierProvider);
        return data.map(
          data: (value) {
            if (value.value.length == 0) {
              return Center(
                child: Image.asset("images/searc.png")
              );
            } else
              return buildProducts(value,cart);
          },
          loading: (_) {
            return Center(
              child: spinkit,
            );
          },
          error: (e) {
            return Text(e.toString());
          },
        );
      }),
    );
  }

  GridView buildProducts(AsyncData<List<WooProduct>> value,CartNotifier cart) {
    var model = value.data.value;
    return GridView.builder(
        itemCount: model.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          var pro = model[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product: pro,)));
            },
            
                      child: MyProduct(
              price: pro.regularPrice,
              name: pro.name,
              url: pro.images[0].src,
              onpressed: IconButton(
                color: Colors.orange,
                icon: Icon(Icons.add_shopping_cart_outlined),
                onPressed: () {
                  cart.addToCart(pQuantity: 1,wooProduct: pro);
                },
              ),
            ),
          );
        });
  }
}
