class Customer {
  String id;
  String avatar;
  String name;
  String email;
  String phone;
  String address;

  Customer({
    required this.id,
    required this.avatar,
    required this.name,
    required this.email,
    required this.phone,
    required this.address
  });

  factory Customer.fromJson(Map<dynamic, dynamic> json) => Customer(
    id: json["Id"],
    avatar: json["Avatar"],
    name: json["Name"],
    email: json["Email"],
    phone: json["Phone"],
    address: json["Address"]
  );

  toJson() => {
    "Id": id,
    "Avatar": avatar,
    "Name": name,
    "Email": email,
    "Phone": phone,
    "Address": address
  };
}
