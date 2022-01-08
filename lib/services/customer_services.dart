import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/comment_model.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/request_model.dart';

class CustomerService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<List<Customer>> getAllCustomers() async {
    List<Customer> customers = [];
    await dbRef.child('Customer').once().then((event) {
      var jsonList = event.snapshot.value as List;
      for (var element in jsonList) {
        customers.add(Customer.fromJson(element));
      }
    });
    return customers;
  }

  void createCustomer(String email) async {
    var customerList = await getAllCustomers();
    var id = customerList.length.toString();
    await dbRef.child('Customer/$id').set({
      'Id': id,
      'Avatar': "",
      'Name': "",
      'Email': email,
      'Phone': "",
      'Address': "",
    });
  }

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

  Future<Customer> getCustomerByEmail(String? email) async {
    Customer customer = Customer(
      id: "-1",
      avatar: "",
      name: "",
      email: "",
      phone: "",
      address: "",
    );

    Query query = dbRef.child('Customer').orderByChild('Email').equalTo(email);

    await query.once().then((event) {
      var json = event.snapshot.value as Map<dynamic, dynamic>;
      var keys = json.keys;
      customer = Customer.fromJson(json[keys.first]);
    });

    return customer;
  }

  void submitComment(String tourId, Comment comment) async {
    String commentId = "0";
    List<Comment> comments = [];
    
    await dbRef.child('Tour/$tourId/RatingList').once().then((event) {
      var jsonList = event.snapshot.value as List;

      if (jsonList != null) {
        for (var element in jsonList) {
          comments.add(Comment.fromJson(element));
        }

        bool isExist = false;
        for (var i = 0; i < comments.length; i++) {
          if (comments[i].customerId == comment.customerId) {
            commentId = i.toString();
            isExist = true;
            break;
          }
        }

        if (!isExist) {
          commentId = comments.length.toString();
        }
      }
    });

    dbRef.child('Tour/$tourId/RatingList/$commentId').set(comment.toJson());
  }

  void submitRequest(Request request) async {
    String requestId = "0";
    await dbRef.child('Request').once().then((event) {
      var jsonList = event.snapshot.value as List;

      if (jsonList != null) {
        requestId = jsonList.length.toString();
      }
    });

    dbRef.child('Request/$requestId').set(request.toJson(requestId));
  }

  void updateInfo(Customer customer) async {
    dbRef.child('Customer/${customer.id}').update({
      'Name': customer.name,
      'Phone': customer.phone,
      'Address': customer.address,
    });
  }

  void updateAvatar(String customerId, String avatar) async {
    dbRef.child('Customer/$customerId').update({
      'Avatar': avatar,
    });
  }
}
