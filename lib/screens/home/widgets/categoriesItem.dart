import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/screens/product/store.dart';

import '../../../helper.dart';
import '../../../service/provider/provider.dart';
import '../../product/widgets/productGrid.dart';

class CategoriesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = SizeHelper.height(context);
    var widtth = SizeHelper.width(context);
    return Container(
      height: height / 7,
      child: Consumer(
        builder: (BuildContext context, ScopedReader watch, Widget child) {
          final categories = watch(getAllCategriesProvider);

          var body = categories.map(data: (asyncData) {
            var listOfcats = asyncData.value;
            var content = Container(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listOfcats.length,
                itemBuilder: (BuildContext context, int index) {
                  var catName = listOfcats[index].name;
                  var catImage = listOfcats[index].image;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StoreScreen(
                                    catId: listOfcats[index].id.toString(),
                                  )));
                    },
                    child: Container(
                      width: widtth * 0.2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: widtth *0.2,
                          height: 70,
                          // color: Colors.redAccent,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage("https://ozerciftlik.com/wp-content/uploads/2020/03/1009-800x800-1.jpg"),
                            backgroundColor: Colors.white,
                            child: catImage == null
                                ? Image.network(
                                    "https://img1.pngindir.com/20180529/qwv/kisspng-bryndza-goat-cheese-queso-blanco-feta-beyaz-peynir-5b0cf05d8fb6e0.1246446815275746215887.jpg")
                                : Image.network(catImage.src),
                          ),
                        ),
                      ),
                    ),
                  );
                },

                // },
              ),
            );

            return content;
          }, loading: (asyncData) {
            return Center(child: spinkit);
          }, error: (error) {
            return Text(error.toString());
          });
          return body;
        },
      ),
    );
  }
}
