class Destination {
  String id;
  String img;
  String name;
  String description;
  String province;
  String idHotel;

  Destination({
    required this.id,
    required this.img,
    required this.name,
    required this.description,
    required this.province,
    required this.idHotel,
  });

  factory Destination.fromJson(Map<dynamic, dynamic> json) => Destination(
      id: json["Id"],
      img: json["Img"],
      name: json["Name"],
      description: json["Description"],
      province: json["Province"],
      idHotel: json["IdHotel"]);
}
