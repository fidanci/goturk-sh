import 'package:woocommerce/models/customer.dart';
import 'package:woocommerce/woocommerce.dart';

var customerDeneme = WooCustomer(
  firstName: "Taylan",
  lastName: "Erdogan",
  username: "tde62",
  billing: Billing(address1: "Zübeyde hanım",address2: "Sultangazi",email: "tdeniz@deniz.com",firstName: "taylan",lastName:"erdogan",phone: "5418228864",postcode: "34260",),
  shipping: Shipping(address1: "Zübeyde hanım",address2: "Sultangazi",firstName: "taylan",lastName: "erdogan",postcode: "34260",),
  
);