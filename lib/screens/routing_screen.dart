import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/helper.dart';
import 'package:goturkishfoodapp/screens/cart/cart.dart';
import 'package:goturkishfoodapp/screens/category/category.dart';
import 'package:goturkishfoodapp/screens/home/home_page.dart';
import 'package:goturkishfoodapp/screens/other/other.dart';

import 'package:goturkishfoodapp/screens/search/search.dart';
import 'package:goturkishfoodapp/service/provider/provider.dart';

class RoutingScreen extends StatefulWidget {
  static final id = "RoutingScreen";

  @override
  _RoutingScreenState createState() => _RoutingScreenState();

  const RoutingScreen();
}

class _RoutingScreenState extends State<RoutingScreen> {
  
  
  int bottomSelectedIndex = 0;
  var pageController;


  void onPageChanged(int index) {
   
    setState(() {
      bottomSelectedIndex = index;
    });
  }


  void onbottomTapped(int index) {
    if ((bottomSelectedIndex - index.abs() == 1)) {
      return pageController.animateToPage(index,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      return pageController.jumpToPage(index);
    }
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();

  }


  @override
  Widget build(BuildContext context) {
   
    final pageView = PageView(
        controller: pageController,
        children: [HomePage(),SearchPage(), CategoryPage(), OthersPage(), ],
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged);

    return Consumer(
      builder: (context,watch,child){
        final provider = watch(cartChangeNotifierProvider);
        var number = provider.cartList.length;
        return 
      Scaffold(
        
       
        appBar: buildAppBar(context ,number),
        bottomNavigationBar: BottomNavigationBar(
          

          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
                BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Settings"),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view),label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.list),label: "Others"),
            
          ],
          onTap: onbottomTapped,
          selectedItemColor: MyColor.oceanGreen,
          unselectedItemColor: MyColor.nuggetOrange,
          currentIndex: bottomSelectedIndex,
        ),
        body: pageView,
      );}
    );
  }

 

  AppBar buildAppBar(BuildContext context,int i) {
    return AppBar(
      
    
      actions: [
       
     
       Card(
          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
          elevation: 5,
                  child: Badge(
                    alignment: Alignment.topLeft,
                    
                    badgeContent: Text(i.toString(),style: TextStyle(color: Colors.white),),
                    badgeColor: Colors.red,
                    position: BadgePosition.topEnd(end: 30,),
                                      child: IconButton(onPressed: (){
                      
                        Navigator.push(context, MaterialPageRoute(fullscreenDialog: true,builder: (context)=>CartPage()));

          },icon: Icon(Icons.add_shopping_cart_outlined,color: Colors.orangeAccent,),),
                  ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Image.network(
          "https://goturkishfood.com/wp-content/uploads/2019/11/GoTurkishFoodLogo.png"),
    );
  }
}
