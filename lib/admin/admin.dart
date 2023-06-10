import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodflutter/admin/show_order.dart';
import 'package:foodflutter/admin/user_location.dart';
import 'package:foodflutter/auth/order.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Panel"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Orderto().getCustomers(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          padding: EdgeInsets.symmetric(
                              horizontal: 40, vertical: 20),
                          child: Text(
                            "${snapshots.data!.docs[index]['email']}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowOrder(snapshots.data!.docs[index].id,
                                    snapshots.data!.docs[index]['total']);
                              }));
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.red,
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserLocation(
                                    snapshots.data!.docs[index]['lat'],
                                    snapshots.data!.docs[index]['log']);
                              }));
                            },
                            icon: Icon(
                              Icons.map_sharp,
                              color: Colors.pink,
                            )),
                        IconButton(
                            onPressed: () {
                              Orderto()
                                  .deleteOrder(snapshots.data!.docs[index].id);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.pink,
                            ))
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
