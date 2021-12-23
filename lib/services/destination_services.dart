import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/destination_model.dart';

class DestinationService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<Destination> getDestinationById(String id) async {
    Destination destination = Destination(
      id: "-1",
      name: "",
      description: "",
      img: "",
      province: "",
      idHotel: "",
    );

    await dbRef.child('Destination/$id').once().then((event) {
      var json = event.snapshot.value as Map<dynamic, dynamic>;
      destination = Destination.fromJson(json);
    });
    return destination;
  }
}
