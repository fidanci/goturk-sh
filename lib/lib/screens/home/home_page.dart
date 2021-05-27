import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/product/productdetail.dart';
import 'package:woocommerce/models/products.dart';

import '../../helper.dart';
import '../../models/categorylist.dart';
import '../../service/provider/provider.dart';
import '../../widgets/productwidget.dart';
import 'widgets/categoriesItem.dart';
import 'widgets/topslider.dart';

class HomePage extends StatefulWidget {
  static final id = "HomeScreen";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var homecatList = CategoryList.homecatList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(builder: (context, watch, child) {
          //110 nolu kategoriden gelen ürünler 
          final homeProvider = watch(getAllProductProvider("110"));
          final carProvider = watch(cartChangeNotifierProvider);
          return homeProvider.map(
            data: (value) {
              var list = value.data.value;
              return buildColumn(context, list, carProvider);
            },
            loading: (_) {
              return Center(child: spinkit);
            },
            error: (e) {
              return Text(e.toString());
            },
          );
        }),
      ),
    );
  }

  Column buildColumn(
      BuildContext context, List<WooProduct> model, CartNotifier prvider) {
    return Column(
      children: [
        SliderSection(),
        Text("Our Tastes",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              fontStyle: FontStyle.italic,
            )),
        Divider(
          color: Colors.black,
        ),
        CategoriesItem(),
        SizedBox(
          height: 10,
        ),
        Text("Editor's Choices"),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: Colors.black,
        ),
        buildProductList(context, model, prvider)
      ],
    );
  }
}

// Provider ile ürün listesi çekildi.
// CartNotifier Alışveriş sepetini tutuyor. Ürün sepete ekleme işlemi yapıldı.

Widget buildProductList(
    BuildContext context, List<WooProduct> data, CartNotifier cart) {
  return Container(
      height: SizeHelper.height(context) / 2,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5, childAspectRatio: 1),
        itemCount: data.length,
        itemBuilder: (context, index) {
          var model = data[index];
          var url = model.images[0].src;

          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductDetail(
                            product: model,
                          )));
            },
            child: MyProduct(
                onpressed: IconButton(
                  icon: Icon(Icons.set_meal),
                  onPressed: () {
                    cart.addToCart(wooProduct: model, pQuantity: 1);
                  },
                  color: MyColor.nuggetOrange,
                  iconSize: SizeHelper.height(context) / 30,
                ),
                name: model.name,
                price: model.price,
                url: url != null
                    ? url
                    : 'https://complianz.io/wp-content/uploads/2019/03/placeholder-300x202.jpg'),
          );
        },
        scrollDirection: Axis.horizontal,
      ));
}
