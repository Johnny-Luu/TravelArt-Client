class Tour {
  String id;
  String img;
  String name;
  String description;
  String destinationIDs;
  String price;
  String profit;
  int status;

  Tour({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.destinationIDs,
    required this.price,
    required this.profit,
    required this.status,
  });

  List<String> get destinationIDList => destinationIDs.split(',');

  factory Tour.fromJson(Map<dynamic, dynamic> json) => Tour(
    id: json["Id"],
    img: json["Img"],
    name: json["Name"],
    description: json["Description"],
    destinationIDs: json["DestinationIds"],
    price: json["Price"],
    profit: json["Profit"],
    status: json["Status"],
  );
}
