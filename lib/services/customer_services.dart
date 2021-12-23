import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/customer_model.dart';

class CustomerService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<Customer> getCustomerById(String id) async {
    Customer customer = Customer(
      id: "-1",
      avatar: "",
      name: "",
      email: "",
      phone: "",
      address: "",
    );
    await dbRef.child('Customer/$id').once().then((event) {
      var json = event.snapshot.value as Map<dynamic, dynamic>;
      customer = Customer.fromJson(json);
    });
    
    return customer;
  }
}