import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/tour_model.dart';

class TourService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<List<Tour>> getAllTours() async {
    List<Tour> tours = [];
    await dbRef.child('Tour').once().then((event) {
      var jsonList = event.snapshot.value as List;
      for (var element in jsonList) {
        if (element["Id"] != "-1") {
          tours.add(Tour.fromJson(element));
        }
      }
    });
    return tours;
  }

  Future<Tour> getTourById(String id) async {
    Tour tours = Tour(
      id: '-1',
      img: '',
      name: '',
      description: '',
      destinationIDs: '',
      price: '',
      profit: '',
      ratingList: [],
      status: 0,
    );

    await dbRef.child('Tour/$id').once().then((event) {
      var json = event.snapshot.value as Map<dynamic, dynamic>;
      if (json['Id'] != "-1") {
        tours = Tour.fromJson(json);
      }
    });

    return tours;
  }
}
