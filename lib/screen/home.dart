import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodflutter/admin/admin.dart';
import 'package:foodflutter/auth/login_status.dart';
import 'package:foodflutter/main.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import '../components/body.dart';

// import 'package:foodflutter/screen/body.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
            text: const TextSpan(
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                children: [
              TextSpan(
                  text: "Food flutter", style: TextStyle(color: Colors.white)),
              TextSpan(text: "Order", style: TextStyle(color: Colors.white))
            ])),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icon/basket.svg"),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 2) {
              Auth().logout();
              Provider.of<LoginStatus>(context, listen: false).setStatus(false);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            } else if (index == 3) {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return Admin();
              // }));
              if (this.status) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Admin();
                }));
              }
            }
          },
          currentIndex: 0,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Cart"),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: "Logout"),
            status
                ? BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Admin")
                : BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user), label: "Normal User"),
          ]),
      body: const Body(),
    );
  }

  checkRole() async {
    //uid is user'id of current using this app
    QuerySnapshot<Map<String, dynamic>> roles = await FirebaseFirestore.instance
        .collection("role")
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (roles.docs[0]['role'] == "admin") {
      // role is from field
      setState(() {
        this.status = true;
      });
    }
  }
}
