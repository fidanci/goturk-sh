import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:goturkishfoodapp/helper.dart';
import 'package:goturkishfoodapp/models/denemecustomer.dart';
import 'package:goturkishfoodapp/service/provider/provider.dart';
import 'package:woocommerce/models/customer.dart';

class ProfilePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    var customer = watch(usersProvider);
    return customer.map(
      data: (asyncdata){
        return buildScaffold(asyncdata.value);
      },
      loading: (_){
        return Center(child: spinkit,);
      },
      error: (e){
        return Text(e.toString());
      },
    );
    
  }

  Scaffold buildScaffold(WooCustomer data) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                children: [
                  CircleAvatar(),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Welcome, ${data.firstName} \n ${data.lastName}"),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ExpansionTile(
                  title: Text("My Address"),
                  children: [
                    ExpansionTile(
                      title: Text("Shipping Address"),
                      children: [
                        ListTile(
                          title: Text("data.shipping.postcode"),
                          subtitle:
                              Text("ustomerDeneme.billing.phone.toString()"),
                          trailing: Text("data.shipping.city"),
                        )
                      ],
                    ),
                    ExpansionTile(title: Text("Shipping Address")),
                  ],
                )),
            Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: ExpansionTile(
                  title: Text("My Orders"),
                  children: [
                    Text("Order 1"),
                    Text("Order 1"),
                    Text("Order 1"),
                    Text("Order 1"),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
