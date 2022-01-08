import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/request_model.dart';

class RequestService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<List<Request>> getRequestOfCurrentCustomer(String id) async {
    List<Request> list = [];
    await dbRef.child('Request').once().then((event) {
      var jsonList = event.snapshot.value as List;
      for (var element in jsonList) {
        if (element['CustomerId'] == id && element['Id'] != '-1') {
          list.add(Request.fromJson(element));
        }
      }
    });
    return list;
  }
}