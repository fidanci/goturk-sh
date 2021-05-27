import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:woocommerce/constants/constants.dart';
import 'package:woocommerce/utilities/local_db.dart';
import 'package:woocommerce/woocommerce.dart';

import '../../constant.dart';
import 'sharedPref.dart';

class WooCommerceApi {
  static WooCommerce prodMode = WooCommerce(
    baseUrl: "$baseUrl",
    consumerKey: "$consumerKey",
    consumerSecret: "$consumerSecret",
    isDebug: false,
  );
   Map<String, String> _urlHeader = {
    'Authorization': ''
  };
// Kategorileri Almak için kullanıldı
  /// Search Screen  ================================================================================
  Future<List<WooProduct>> getProductBySearch(String query) async {
    final myProducts = await prodMode.getProducts(
        status: "publish", perPage: 50, page: 1, search: "$query");
    print("WooCommerceApi === getProducts1 : ${myProducts.length}");
    return myProducts;
  }

  Future<WooProductTag> getProductBy(int tag) async {
    final myProducts = await prodMode.getProductTagById(id: tag);
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
    final myProducts =
        await prodMode.getProductCategories(perPage: 50, hideEmpty: true);
    print("WooCommerceApi === getAllCategories : ${myProducts.length}");

    return myProducts;
  }

  /// SignUp screen ================================================================================
  Future<bool> createCustumer(WooCustomer customer) async {
    final user = await prodMode.createCustomer(customer);
    return user;
  }

  /// login screen  ================================================================================
  Future<void> loginUser({String username, String password}) async {
    try {
       var user =
        await prodMode.loginCustomer(username: username, password: password);
        
    return user;
    } catch (e) {
      print(e.toString());
    }
   
   
  }

  Future<String> loginUserCustom({String username, String password}) async {
    final body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      baseUrl + URL_JWT_TOKEN,
      body: body,
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var toke = json.decode(response.body);
      var token = toke['data']['token'];
      var id = toke['data']['id'];
      SharedPref().saveToken(token);
      SharedPref().saveID(id);
      print(token);
   
      print(id);
      if(token is String){
        return token;
      
      }
      return token;
    }else {
      return "0";
    }
  }
// Kayıtlı token kontrolü yapmak için kullanıldı
  Future<bool> checkLogged() async {
    log("checkLogged Called:");
  //  final logged = await prodMode.isCustomerLoggedIn();
    final isLoged = await SharedPref().isLoged();
    if (isLoged == true) {
      log("logged  Value : $isLoged !!");

      return true;
    } else {
      log("User Not logged in !!");
      return false;
    }
    
  }

  /// Profile Screen  ================================================================================
  Future<WooCustomer> getCustumerInfo() async {
    var authToken = await LocalDatabaseService().getSecurityToken();
    var header = _urlHeader['Authorization'] = 'Bearer '+authToken;
    final response =
    await http.get(baseUrl + URL_USER_ME, headers: _urlHeader);
    print(response.body);
    final userId = await prodMode.fetchLoggedInUserId();
    final myProducts = await prodMode.getCustomerById(id: userId);
    return myProducts;
  }




  Future<List<WooOrder>> getUserOrders() async {
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
