import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/cart/cart.dart';


import '../../helper.dart';
import 'widgets/productGrid.dart';
import 'widgets/productrow.dart';

class StoreScreen extends StatefulWidget {
  final String catId;
  const StoreScreen({
     key,
     this.catId,
  }) : super(key: key);
  static final id = "StoreScreen";

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool isPlaying = false;

  void _handleOnPressed() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying ? _animationController.reverse() : _animationController.forward();
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height= SizeHelper.height(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Appbarda bulunan icon ile etkileşime geçince liste veya grid oluyor.
        actions: [
           GestureDetector(
                  onTap: () {
                    setState(() {
                      var gridView = 0;
                      var listVeiw = 1;

                      if (isPlaying) {
                        gridView = 0;
                        print(gridView);
                      } else {
                        listVeiw = 1;
                        print(listVeiw);
                      }
                    });
                    return _handleOnPressed();
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: MyColor.carrotOrange),
                    width: MediaQuery.of(context).size.width /9,
              
                    child: Center(
                      
                        child: AnimatedIcon(
                      progress: _animationController,
                      icon: AnimatedIcons.list_view,
                      color: Colors.white,
                    )),
                  ),
                ),
              
          IconButton(icon: Icon(Icons.shopping_basket_outlined), onPressed: (){
            Navigator.push(context, MaterialPageRoute(fullscreenDialog: true,builder: (context)=> CartPage()));
          },color: MyColor.nuggetOrange,iconSize: height/25,),
   
        ],
    
        
      ),
      body: Container(
        color: Colors.white,
        child: isPlaying ? ProductGrid(catId: widget.catId,) : ProductRow(catId: widget.catId,)
      ),
    );
  }
}
