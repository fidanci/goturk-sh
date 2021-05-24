import 'dart:developer';

import 'package:goturkishfoodapp/constant.dart';
import 'package:woocommerce/woocommerce.dart';

class WooCommerceApi{
   static WooCommerce prodMode = WooCommerce(
    baseUrl: "$baseUrl",
    consumerKey: "$consumerKey",
    consumerSecret: "$consumerSecret",
    isDebug: false,
  );
// Kategorileri Almak için kullanıldı
  /// Search Screen  ================================================================================
  Future<List<WooProduct>> getProductBySearch(String query) async {
    final myProducts =
        await prodMode.getProducts(status: "publish", perPage: 50, page: 1, search: "$query");
    print("WooCommerceApi === getProducts1 : ${myProducts.length}");
    return myProducts;
  }
 Future<WooProductTag> getProductBy(int tag) async {
    final myProducts =
        await prodMode.getProductTagById(id: tag
        );
        var name = myProducts.name;
    print(name);
    return myProducts;
  }
  

  /// Home Screen  ================================================================================
  Future<List<WooProduct>> getAllProducts(String catId) async {
    final myProducts = await prodMode.getProducts(
      status: "publish",
      perPage: 50,
      page: 1,
      category: "$catId",
    );
    print("WooCommerceApi === getProducts1 : ${myProducts.length}");
    return myProducts;
  }

  Future<List<WooProductCategory>> getAllCategories() async {
    final myProducts = await prodMode.getProductCategories(perPage: 50, hideEmpty: true);
    print("WooCommerceApi === getAllCategories : ${myProducts.length}");
    print(myProducts);
    return myProducts;
  }

  /// SignUp screen ================================================================================
  Future<bool> createCustumer(WooCustomer customer) async {
    final user = await prodMode.createCustomer(customer);
    return user;
  }

  Future<bool> loginJwt(String username,String pass)async{
    final sonuc = await prodMode.authenticateViaJWT(username: username,password: pass);
    return sonuc;
  }

  /// login screen  ================================================================================
  Future<dynamic> loginUser(String username1, String password1) async {
    var user = await prodMode.loginCustomer(username: username1, password: password1);
    return user;
  }

  Future<bool> checkLogged() async {
    log("checkLogged Called:");
    final logged = await prodMode.isCustomerLoggedIn();
    if (logged == true) {
      log("logged  Value : $logged !!");

      return true;
    } else {
      log("User Not logged in !!");
      return false;
    }
  }

  /// Profile Screen  ================================================================================
  Future<WooCustomer> getCustumerInfo() async {
    print("getCustumerInfo :");

    final userId = await prodMode.fetchLoggedInUserId();
    final myProducts = await prodMode.getCustomerById(id: userId);
    return myProducts;
  }

  Future<List<WooOrder>> getUserOrders() async {
    print("getUserOrders :");

    final customerId = await getCustumerInfo();
    print("customerId in getUserOrders: ${customerId.id} ");

    // final myProducts = await prodMode.getOrders(customer: customerId.id);
    var a = [
      'processing',
      'on-hold',
      'pending', // default
      'refunded',
      'cancelled',
      'completed',
      'failed',
      'trash',
      'any',
    ];
    final myProducts = await prodMode.getOrders();
    // final myProducts = await ApiRequest().(customer: 1);

    print("getUserOrders : ${myProducts.length} ");
    return myProducts;
  }

  Future<List<WooCoupon>> getCoupons() async {
    final myProducts = await prodMode.getCoupons();
    print("getCoupons : ${myProducts.length}");
    return myProducts;
  }

  /// Payment Screen  ================================================================================
  Future<List<WooShippingMethod>> getShippingMethods() async {
    final myProducts = await prodMode.getShippingMethods();
    print("getShippingMethods : ${myProducts.length}");
    return myProducts;
  }

  Future<WooOrder> createOrder(WooOrderPayload orderPayload) async {
    final myProducts = await prodMode.createOrder(orderPayload);
    print("createOrder : ${myProducts}");
    return myProducts;
  }
}