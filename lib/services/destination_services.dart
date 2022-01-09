import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/destination_model.dart';

class DestinationService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<List<Destination>> getAllDestinations() async {
    List<Destination> destinations = [];
    await dbRef.child('Destination').once().then((event) {
      var jsonList = event.snapshot.value as List;
      for (var element in jsonList) {
        if (element["Id"] != "-1") {
          destinations.add(Destination.fromJson(element));
        }
      }
    });
    return destinations;
  }

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
