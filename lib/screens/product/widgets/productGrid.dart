import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/product/productdetail.dart';
import 'package:woocommerce/models/products.dart';

import 'package:goturkishfoodapp/service/provider/provider.dart';
import 'package:goturkishfoodapp/widgets/productwidget.dart';

import '../../../helper.dart';

class ProductGrid extends ConsumerWidget {
  final String catId;
  ProductGrid({
    this.catId,
  });
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final productsProviderData = watch(getAllProductProvider(catId));
    final cart = watch(cartChangeNotifierProvider);

    var body = productsProviderData.map(data: (asyncData) {
      var products = asyncData.value;
      var crossAxisCount = 2;
      var childAspectRatio = 0.8;

      return RefreshIndicator(
        onRefresh: () {
          return context.refresh(getAllProductProvider(catId));
        },
        child: Container(
            padding: EdgeInsets.all(10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                ),
           
                itemCount: products.length,
                itemBuilder: (context, i) {
                  var product = products[i];
                  var productImage = '';

                  var hasImage = products[i].images.length > 0;
                  if (hasImage) {
                    productImage = products[i].images[0].src;
                  } else {
                    productImage =
                        'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg';
                  }
                  var productName = products[i].name;
                  var productprice = products[i].price ?? "0.0";

                  return buildInkWell(
                    context,
                    product,
                    productImage,
                    productName,
                    productprice,
                    products,
                    cart,
                  );
                })),
      );
    }, loading: (asyncData) {
      return spinkit;
    }, error: (error) {
      return Text(error.toString());
    });

    return body;
  }

  Widget buildInkWell(
      BuildContext context,
      WooProduct product,
      String productImage,
      String productName,
      String productprice,
      List<WooProduct> products,
      CartNotifier cart) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetail(
                        product: product,
                      )));
        },
        child: MyProduct(
          name: productName,
          url: productImage,
          price: productprice,
          onpressed: IconButton(
            icon: Icon(Icons.add_shopping_cart_outlined),
            onPressed: () {
              cart.addToCart(wooProduct: product, pQuantity: 1);
            },
            color: MyColor.nuggetOrange,
            iconSize: SizeHelper.height(context) / 25,
          ),
        ));
  }
}
