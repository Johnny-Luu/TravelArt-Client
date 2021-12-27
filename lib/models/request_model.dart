class Request {
  String date;
  String time;
  String customerId;
  String tourGroupId;

  Request({
    required this.date,
    required this.time,
    required this.customerId,
    required this.tourGroupId,
  });

  factory Request.fromJson(Map<dynamic, dynamic> json) => Request(
    date: json["Date"],
    time: json["Time"],
    customerId: json["CustomerId"],
    tourGroupId: json["TourGroupId"],
  );

  toJson(String id) => {
    "Id": id,
    "Date": date,
    "Time": time,
    "CustomerId": customerId,
    "TourGroupId": tourGroupId,
  };
}
