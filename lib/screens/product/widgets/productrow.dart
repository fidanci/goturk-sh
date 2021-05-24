
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/product/productdetail.dart';

import '../../../helper.dart';
import '../../../service/provider/provider.dart';

class ProductRow extends ConsumerWidget {
  final String catId;
  ProductRow({
     this.catId,
  });


  @override
  Widget build(BuildContext context, ScopedReader watch) {
    /// listen to catId change in productsChangeNotifierProvider and pass it to [ productsProviderData ]
   

    /// listen to if favorite Or not change in favoriteChangeNotifierProvider
   

    /// listen to productsList  in productsProvider
    final productsProviderData = watch(getAllProductProvider(catId));
    final cartPro = watch(cartChangeNotifierProvider);

    var body = productsProviderData.map(data: (asyncData) {
      var products = asyncData.value;
      // print("wProductGrid length: ${products.length}");
      // print("wProductGrid catID : ${catID}");

      double height = MediaQuery.of(context).size.height / 2.7;
      double cardWidth = MediaQuery.of(context).size.width / 1.8;
      int quantity = 0;
      var body = ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          thickness: 1,
          color: Colors.black12,
        ),
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: products.length,
        // physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var product = products[index];
          final width = MediaQuery.of(context).size.width;
          var productImage = '';
          var productprice = products[index].regularPrice ?? "0.0";

          var hasImage = products[index].images.length > 0;
          if (hasImage) {
            productImage = products[index].images[0].src;
          } else {
            productImage =
                'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg';
          }

          return Column(
            children: [
              GestureDetector(
                onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product: product,)));
                 
                },
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Container(
                    width: width,
                    height: 150,
                    child: Stack(
          
                      children: [
                        Row(
                          textDirection: TextDirection.ltr,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// RightSide
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                
                                width: height / 3,
                                child: Image.network(
                                 
                                   productImage ?? '',

                                  // height: height / 1.7,
                                  height: 120,
                                  width: cardWidth / 1.4,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),

                            Container(
                              color: Colors.black12,
                              height: 11,
                            ),
                            Container(
                              width: 1,
                              color: Colors.black12,
                            ),

                            /// Center
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      
                                      title: Text(
                                        product.name,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 4,
                                        
                                      ),
                                      
                                      trailing: product.onSale
                                          ? Container(
                                              height: 20,
                                              width: 50,
                                              color: Colors.yellow.withOpacity(0.4),
                                              child: Padding(
                                                padding: const EdgeInsets.all(1.0),
                                                child: Center(
                                                  child: Text(
                                                    product.salePrice,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox.shrink(),
                                      isThreeLine: false,
                                    ),
                                  ),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(productprice + " £",style: TextStyle(fontSize: 20),),
                                   ),
                                   

                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(icon: Icon(Icons.add_shopping_cart_outlined), onPressed: (){
                                      cartPro.addToCart(wooProduct: product,pQuantity: 1);
                                    },color: MyColor.nuggetOrange,),
                                  ),
              
                                ],
                              ),
                            ),

                        

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },

        // },
      );

      return RefreshIndicator(
        onRefresh: () {
          return context.refresh(getAllProductProvider(catId));
        },
        child: Container(
            padding: EdgeInsets.all(1),
            // height: 300,
            // width: 100,
            // color: Colors.black54,
            child: body),
      );
    }, loading: (asyncData) {
      return spinkit;
    }, error: (error) {
      return Text(error.toString());
    });

    return body;
  }


}
