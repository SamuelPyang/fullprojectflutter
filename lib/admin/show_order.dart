import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodflutter/auth/order.dart';

class ShowOrder extends StatefulWidget {
  // const ShowOrder({super.key});

  late String id;
  late String Amount;
  ShowOrder(this.id, this.Amount);

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          FutureBuilder(
              future: Orderto().getOrder(widget.id),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            Image.network(
                              snapshot.data!.docs[index]['image'],
                              width: 100,
                              height: 100,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      "${snapshot.data!.docs[index]['price']} MKK"),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text("Quantity"),
                                Text(
                                    "${snapshot.data!.docs[index]['quantity']}")
                              ],
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text("Amount"),
                                Text(
                                    "${snapshot.data!.docs[index]['quantity'] * snapshot.data!.docs[index]['price']}")
                              ],
                            )
                          ],
                        ),
                      );
                    });
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Total Amount",
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              Text(
                "${widget.Amount} MKK",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      )),
    );
  }
}
