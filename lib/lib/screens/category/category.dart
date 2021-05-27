import 'package:flutter/material.dart';

import '../../helper.dart';
import '../../models/categorylist.dart';

import '../product/store.dart';


class CategoryPage extends StatefulWidget {
  static final id = "CategoryPage";
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    var list = CategoryList.categoryList;

    return Scaffold(
          body: categoryList(list),
    );
  }

  Widget categoryList(List<CategoryList> data) {
    return Container(
      height: SizeHelper.height(context),
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var model = data[index];
            return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StoreScreen(catId: model.categoryId,)));
              },
                          child: Card(
                elevation: 2,
                child: Image.asset("images/${model.name}.jpg",fit: BoxFit.cover,),
              ),
            );

          }),
    );
  }
}
