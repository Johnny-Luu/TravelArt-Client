class TourGroup {
  String id;
  String name;
  int slot;
  DateTime startDate;
  DateTime endDate;
  String tourLeaderId;
  String tourLeaderName;
  String tourDeputyId;
  String tourDeputyName;
  String tourId;
  String tourName;
  String customerList;

  TourGroup({
    required this.id,
    required this.name,
    required this.slot,
    required this.startDate,
    required this.endDate,
    required this.tourLeaderId,
    required this.tourLeaderName,
    required this.tourDeputyId,
    required this.tourDeputyName,
    required this.tourId,
    required this.tourName,
    required this.customerList
  });

  List<String> get customerListSplited => customerList.split(',');

  factory TourGroup.fromJson(Map<dynamic, dynamic> json) => TourGroup(
    id: json["Id"],
    name: json["Name"],
    slot: json["Slot"],
    startDate: DateTime.parse(json["StartDate"]),
    endDate: DateTime.parse(json["EndDate"]),
    tourLeaderId: json["TourLeaderId"],
    tourLeaderName: json["TourLeaderName"],
    tourDeputyId: json["TourDeputyId"],
    tourDeputyName: json["TourDeputyName"],
    tourId: json["TourId"],
    tourName: json["TourName"],
    customerList: json["CustomerList"]
  );
}
