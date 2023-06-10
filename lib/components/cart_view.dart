import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodflutter/admin/location_screen.dart';
import 'package:foodflutter/auth/order.dart';
import 'package:foodflutter/main.dart';
import 'package:provider/provider.dart';

import '../carts/cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  //int totalAmt = 0;

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart List"),
      ),
      body: Column(
        children: [
          /*  Row(
          children: [
            Container(
                    child: Text('Image',), width: 100,
                  ),
                  Text("Produt Name"),
                  Text('Quantity'),
                  Text("Amount"),
          ],
         ), */

          ListView.builder(
              itemCount: cart.getLength(),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                // return Text(cart.getList()[index].product.name);
                return Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        cart.getList()[index].product.image,
                        width: 100,
                        height: 100,
                      ),
                      //     Container(
                      //      child: Text(cart.getList()[index].product.name, style: TextStyle(color: Colors.pink),),
                      //     )
                      SizedBox(
                        width: 6,
                      ),
                      Column(
                        children: [
                          Container(
                            child: Text(
                              cart.getList()[index].product.name,
                              style: TextStyle(color: Colors.pink),
                            ),
                          ),
                          Container(
                            child: Text(
                                "${cart.getList()[index].product.price} MMK"),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      //Text("${cart.getList()[index].counter}"),
                      Column(
                        children: [
                          const Text(
                            "Quantity",
                            style: TextStyle(color: Colors.pink),
                          ),
                          Text("${cart.getList()[index].counter}"),
                        ],
                      ),

                      SizedBox(
                        width: 6,
                      ),

                      // Text("${cart.getList()[index].counter * cart.getList()[index].product.price}"),
                      Column(
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(color: Colors.pink),
                          ),
                          Text(
                              "${cart.getList()[index].counter * cart.getList()[index].product.price}"),
                        ],
                      ),

                      TextButton(
                          onPressed: () {
                            setState(() {
                              cart.deleteProduct(cart.getList()[index]);
                            });
                          },
                          child: Icon(Icons.remove_circle))
                    ],
                  ),
                );
              }),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                "Total Amount",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.pink),
              ),
              Text(
                "${cart.totalAmt} MKK",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.pink),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
                onPressed: () async {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    // print(user.email);

                    DocumentReference doc = await Orderto()
                        .createCustomer(user.email!, cart.totalAmt.toString());
                    //print(doc.id);
                    cart.getList().forEach((element) {
                      Orderto().createOrder(
                          element.counter, element.product, doc.id);
                    });

                    cart.delete();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      // return MyApp();
                      // return LocationScreen();
                      return LocationScreen(doc.id);
                    }));
                  }
                },
                child: Text(
                  "Check Out",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../carts/cart.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart List"),
      ),
      body: Column(
        children: [
          ListView.builder(
              itemCount: cart.getLength(),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Text(cart.getList()[index].product.name);
              })
        ],
      ),
    );
  }
}
*/