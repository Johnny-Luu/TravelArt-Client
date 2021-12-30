import 'package:firebase_database/firebase_database.dart';
import 'package:travelapp/models/tourgroup_model.dart';

class TourGroupService {
  final dbRef = FirebaseDatabase.instance.ref();

  Future<List<TourGroup>> getAllTourGroups() async {
    List<TourGroup> tourGroups = [];
    await dbRef.child('TourGroup').once().then((event) {
      var jsonList = event.snapshot.value as List;
      for (var element in jsonList) {
        if (element["Id"] != "-1") {
          tourGroups.add(TourGroup.fromJson(element));
        }
      }
    });

    return tourGroups;
  }

  Future<List<TourGroup>> getTourGroupsByTour(String tourId) async {
    List<TourGroup> tourGroups = [];

    Query query =
        dbRef.child('TourGroup').orderByChild('TourId').equalTo(tourId);

    await query.once().then((event) {
      var jsonList = event.snapshot.value as Map<dynamic, dynamic>;
      var keys = jsonList.keys;
      for (var key in keys) {
        if (jsonList[key]["Id"] != "-1") {
          tourGroups.add(TourGroup.fromJson(jsonList[key]));
        }
      }
    });

    return tourGroups;
  }

  Future<List<TourGroup>> getCurrentTourGroupsByTour(String tourId) async {
    List<TourGroup> tourGroups = [];
    DateTime now = DateTime.now();

    Query query =
        dbRef.child('TourGroup').orderByChild('TourId').equalTo(tourId);

    await query.once().then((event) {
      var jsonList = event.snapshot.value as Map<dynamic, dynamic>;
      var keys = jsonList.keys;
      for (var key in keys) {
        if (jsonList[key]["Id"] != "-1" &&
            DateTime.parse(jsonList[key]["StartDate"]).isAfter(now)) {
          tourGroups.add(TourGroup.fromJson(jsonList[key]));
        }
      }
    });

    return tourGroups;
  }

  Future<List<TourGroup>> getTourGroupsOfACustomer(String customerId) async {
    List<TourGroup> tourGroups = [];
    List<TourGroup> allTourGroups = await getAllTourGroups();

    for (var element in allTourGroups) {
      if (element.customerList.contains(customerId)) tourGroups.add(element);
    }

    return tourGroups;
  }

  Future<bool> checkAttendance(String tourId, String customerId) async {
    bool isAttend = false;
    List<TourGroup> tourGroups = [];
    DateTime now = DateTime.now();

    tourGroups = await getTourGroupsByTour(tourId);
    for (var element in tourGroups) {
      if (element.endDate.isBefore(now) &&
          element.customerListSplited.contains(customerId)) {
        isAttend = true;
        break;
      }
    }

    return isAttend;
  }
}
