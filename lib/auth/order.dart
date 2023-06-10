import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodflutter/components/product.dart';

class Orderto {
  Future<DocumentReference> createCustomer(String email, String Amount) async {
    DocumentReference doc =
        await FirebaseFirestore.instance.collection("customers").add({
      "email": email,
      'total': Amount,
      "lat": 0.0,
      "log": 0.0,
    });

    return doc;
  }

  void deleteOrder(String id) async {
    QuerySnapshot<Map<String, dynamic>> orders = await FirebaseFirestore
        .instance
        .collection("orders")
        .where("customer_id", isEqualTo: id)
        .get();

    orders.docs.forEach((element) {
      FirebaseFirestore.instance.collection("orders").doc(element.id).delete();
    });
    FirebaseFirestore.instance.collection("customers").doc(id).delete();
  }

  void createOrder(int quantity, Product product, String id) {
    FirebaseFirestore.instance.collection("orders").add({
      "name": product.name,
      "image": product.image,
      "price": product.price,
      "quantity": quantity,
      "customer_id": id
    });
  }

  Stream<QuerySnapshot> getCustomers() async* {
    Stream<QuerySnapshot> customers =
        FirebaseFirestore.instance.collection("customers").snapshots();
    yield* customers;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getOrder(String id) async {
    QuerySnapshot<Map<String, dynamic>> orders = await FirebaseFirestore
        .instance
        .collection("orders")
        .where("customer_id", isEqualTo: id)
        .get();
    return orders;
  }
}
