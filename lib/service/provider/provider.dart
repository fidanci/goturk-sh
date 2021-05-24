
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/models/cartitem.dart';
import 'package:goturkishfoodapp/service/data/woocommerce.dart';

import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

/// Home Screen Data =======================================================
final getAllProductProvider = FutureProvider.autoDispose.family<List<WooProduct>, String>((ref, catID) async {
  ref.maintainState = true;

  final products = await WooCommerceApi().getAllProducts(catID);
  return products;
});

/// Search
final getProductsQuery = FutureProvider.autoDispose.family<List<WooProduct>, String>((ref, query) async {
  ref.maintainState = true;

  final products = await WooCommerceApi().getProductBySearch(query);
  return products;
});
//Category
final getAllCategriesProvider = FutureProvider.autoDispose<List<WooProductCategory>>((ref) async {
  ref.maintainState = true;

  final productsCategories = await WooCommerceApi().getAllCategories();
  return productsCategories;
});
final productsChangeNotifierProvider =
    ChangeNotifierProvider<ProductsNotifier>((ref) => ProductsNotifier());
/*final favoriteChangeNotifierProvider =
    ChangeNotifierProvider<FavoriteNotifier>((ref) => FavoriteNotifier());*/



/*class FavoriteNotifier extends ChangeNotifier {
  List<WooProduct> _favoriteList = [];

  List<WooProduct> get favoriteList => _favoriteList;

  void addToFav(WooProduct product) {
    print("Added");
    _favoriteList.add(product);
    notifyListeners();
  }

  void removeFromFav(WooProduct product) {
    print("Removed");

    _favoriteList.remove(product);
    notifyListeners();
  }
} */

class ProductsNotifier extends ChangeNotifier {
  String _catId = "15";
  int _selectedIndex = 0;

  int _selectedImage = 0;
  int _quantity = 1;

  String get catId => _catId;

  set catId(String value) {
    _catId = value;
  }

  int changeSelectedIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
    return _selectedIndex;
  }

  int changeSelectedImage(int newIndex) {
    _selectedImage = newIndex;
    notifyListeners();
    return _selectedImage;
  }

  void addQuantity() {
    print("addQuantity Called");
    // wooProduct.quantity++;
    // _quantity++;
    print("wooProduct.quantity : $_quantity ");

    notifyListeners();
  }

  void subQuantity() {
    if (_quantity > 1) {
      _quantity--;
    }

    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
  }

  int get selectedImage => _selectedImage;

  set selectedImage(int value) {
    _selectedImage = value;
  }

  int get quantity => _quantity;

  set quantity(int value) {
    _quantity = value;
  }
}

/// Cart Screen Data =======================================================

// final cartProvider = FutureProvider.autoDispose<Cart>((ref) async {
//   ref.maintainState = true;
//
// });

final cartChangeNotifierProvider = ChangeNotifierProvider<CartNotifier>((ref) {
  return CartNotifier();
});

class CartNotifier extends ChangeNotifier {
  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  var isExist = false;
  var _total;

  get total => _total;

  set total(value) {
    _total = value;
  }

  // https://stackoverflow.com/questions/66321199/how-do-avoid-markneedsbuilder-error-using-flutter-riverpod-and-texteditingcont
  double getTotalprice() {
    _total = 0.0;
    for (var cartItem in _cartList) {
      if(cartItem.product.price.isNotEmpty)
      _total += double.parse(cartItem.product.price) * cartItem.quantity;
      // notifyListeners();

    }
    return _total;
  }

  void addToCart({WooProduct wooProduct, int pQuantity}) async {
    print("CartNotifier addToCart $pQuantity");

    CartItem cartItem = CartItem(wooProduct, pQuantity);

    final checkItem = _cartList.firstWhere((element) => element.product.id == cartItem.product.id,
        orElse: () => null);
    if (checkItem != null) {
      // print(" ITEM Already IN  :${wooProduct.name}");
      isExist = true;
      // Fluttertoast.showToast(
      //     msg: "المنتج موجود مسبقاً",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0);

    } else {
      _cartList.add(cartItem);
      // Fluttertoast.showToast(
      //     msg: "تم إضافة المنتج",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.green,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      notifyListeners();
      isExist = false;
    }
  }

  // void addToCartOld(WooProduct wooProduct, int quantity) async {
  //   print("CartNotifier addToCart ");
  //   final checkItem = _cartList.firstWhere((element) => element.id == wooProduct.id, orElse: () => null);
  //
  //   if (checkItem != null) {
  //     _quantity++;
  //     notifyListeners();
  //     print(" ITEM Already IN  :${wooProduct.name}");
  //     isExist = true;
  //   } else {
  //     _cartList.add(wooProduct);
  //     notifyListeners();
  //     _quantity = 1;
  //     isExist = false;
  //   }
  //   print("CART ITEMS :${_cartList.length}");
  //
  //   // final body = {"a": "a", "a": "a"};
  //   // final url = "add-item";
  //   // var cart = await WooCommerceApi().AddToCart(id.toString(), quantity);
  //   // print(cart);
  //   // if (cart != null) {
  //   //   notifyListeners();
  //   //   return true;
  //   // }
  //   // return false;
  // }

  void clearCart() async {
    print("CartNotifier clearCart ");
    // final body = {"a": "a", "a": "a"};
    // final url = "add-item";
    // var cart = await WooCommerceApi().AddToCart(id.toString(), quantity);
    // print(cart);

    _cartList.clear();
    print(_cartList.length);
    notifyListeners();

    // if (cart != null) {
    //   notifyListeners();
    //   return true;
    // }
    // return false;
  }
}

//   Future<bool> clearCart({String cartId}) async {
//     print("CartNotifier clearCart ");
//     // final body = {"a": "a", "a": "a"};
//     // final url = "add-item";
//     var cart = await WooCommerceApi.cartApi.deleteRequest("clear");
//     print(cart);
//
//     if (cart != null) {
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }
//
//   // Future<Cart> getCart() async {
//   //   print("Added");
//   //
//   //   var cart = await WooCommerceApi().getCart();
//   //   notifyListeners();
//   //   return cart;
//   // }
//
// // void addToCart2(WooProduct product) async {
// //   print("Added");
// //
// //   _cartList.add(product);
// //   notifyListeners();
// // }
// //
// // void removeFromCart(WooProduct product) {
// //   print("Removed");
// //
// //   _cartList.remove(product);
// //   notifyListeners();
// // }
// //
// // void removeFromCart2(WooProduct product) async {
// //   print("Removed");
// //   _cartList.remove(product);
// //   notifyListeners();
// // }
// // double calculateTotal (){
// //
// // };
// }

/// Profile Screen Data =======================================================

final usersProvider = FutureProvider.autoDispose<WooCustomer>((ref) async {
  ref.maintainState = false;
  final customer = await WooCommerceApi().getCustumerInfo();
  return customer;
});
// final loadingProvider = Provider((ref) async {
//   ref.maintainState = true;
//
//   return spinkit;
// });

final ordersProvider = FutureProvider.autoDispose<List<WooOrder>>((ref) async {
  ref.maintainState = true;
  final products = await WooCommerceApi().getUserOrders();
  return products;
});
final shippingMethodsProvider = FutureProvider.autoDispose<List<WooShippingMethod>>((ref) async {
  ref.maintainState = true;
  final products = await WooCommerceApi().getShippingMethods();
  return products;
});

// final createOrderProvider = FutureProvider.autoDispose.family<WooOrder,WooOrderPayload>((ref,payload) async {
//   ref.maintainState = true;
//   final shippingAddress = await WooCommerceApi().createOrder(payload);
//   return shippingAddress;
// });

/// OLD ==================================================
// class CartNotifier extends ChangeNotifier {
//   List<WooProduct> _cartList = [];
//
//   List<WooProduct> get cartList => _cartList;
//
//   void addToCart(WooProduct product) {
//     print("Added");
//
//     _cartList.add(product);
//     notifyListeners();
//   }
//
//   void addToCart2(WooProduct product) async {
//     print("Added");
//
//     _cartList.add(product);
//     notifyListeners();
//   }
//
//   void removeFromCart(WooProduct product) {
//     print("Removed");
//
//     _cartList.remove(product);
//     notifyListeners();
//   }
//
//   void removeFromCart2(WooProduct product) async {
//     print("Removed");
//     _cartList.remove(product);
//     notifyListeners();
//   }
// // double calculateTotal (){
// //
// // };
// }

/// New  ==================================================
