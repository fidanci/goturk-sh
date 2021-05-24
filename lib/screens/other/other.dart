import 'package:flutter/material.dart';
import 'package:goturkishfoodapp/screens/other/profile/profile.dart';

class OthersPage extends StatefulWidget {
  @override
  _OthersPageState createState() => _OthersPageState();
}

class _OthersPageState extends State<OthersPage> {
  List<String> otherList = [
    "Profile",
    "Settings",
    "My Orders",
    "My Address",
    "Support ",
    "Privacy & Policy",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(flex: 17, child: buildGridView()),
        Expanded(
            flex: 1,
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.logout_outlined),
                label: Text("Log Out")))
      ],
    ));
  }

  Widget buildGridView() {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
      },
          child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1.2, mainAxisSpacing: 10),
          itemCount: otherList.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    gradient: LinearGradient(colors: [
                      Colors.orange,
                      Colors.orangeAccent,
                      Colors.deepOrangeAccent,
                      
                   
                    ]),
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      otherList[index],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Colors.white),
                    )));
          }),
    );
  }
}
