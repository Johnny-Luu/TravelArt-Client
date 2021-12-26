import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/comment_model.dart';
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
}
