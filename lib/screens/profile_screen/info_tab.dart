import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/screens/login_screen/login_screen.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/services/user_services.dart';

class InfoTab extends StatefulWidget {
  final Customer? customer;
  final Function callbackSetNavbar;
  final Function callbackUpdateName;

  InfoTab({
    Key? key,
    required this.customer,
    required this.callbackSetNavbar,
    required this.callbackUpdateName,
  }) : super(key: key);

  @override
  _InfoTabState createState() => _InfoTabState();
}

class _InfoTabState extends State<InfoTab> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var isEditing = false;

  final CustomerService customerService = CustomerService();
  var firebaseAuth = AuthenticationService(FirebaseAuth.instance);

  void loadData() {
    nameController.text = widget.customer!.name;
    emailController.text = widget.customer!.email;
    phoneController.text = widget.customer!.phone;
    addressController.text = widget.customer!.address;
  }

  void onUpdateCancel() {
    nameController.text = widget.customer!.name;
    emailController.text = widget.customer!.email;
    phoneController.text = widget.customer!.phone;
    addressController.text = widget.customer!.address;

    widget.callbackSetNavbar(false);

    setState(() {
      isEditing = false;
    });
  }

  void onUpdateSubmit() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        addressController.text.isEmpty) {
      // TODO: HANDLE SHOW ERROR HERE

      return;
    }

    widget.callbackSetNavbar(false);

    setState(() {
      isEditing = false;
    });

    widget.customer!.name = nameController.text;
    widget.customer!.phone = phoneController.text;
    widget.customer!.address = addressController.text;

    widget.callbackUpdateName(nameController.text);

    customerService.updateInfo(widget.customer!);

    // TODO: HANDLE SHOW UPDATE SUCCESS HERE
  }

  void onSignOut() {
    firebaseAuth.SignOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        children: [
          // edit button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  widget.callbackSetNavbar(true);
                  setState(() {
                    isEditing = true;
                  });
                },
                child: Icon(
                  FontAwesomeIcons.pen,
                  size: 22,
                  color: isEditing ? Colors.blue[800] : Colors.grey,
                ),
              ),
              const SizedBox(width: 14),
              InkWell(
                onTap: onSignOut,
                child: const Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 25,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // name
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.user,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                'Name',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: nameController,
                  enabled: isEditing,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          // phone
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                FontAwesomeIcons.mobileAlt,
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                'Phone',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: phoneController,
                  enabled: isEditing,
                  keyboardType: TextInputType.number,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
          // address
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 22,
              ),
              Text(
                'Address',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: TextField(
                  controller: addressController,
                  enabled: isEditing,
                  textDirection: TextDirection.rtl,
                  style: const TextStyle(fontSize: 18),
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ],
      ),
      // buttons
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: isEditing
            ? Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: InkWell(
                      onTap: onUpdateSubmit,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.blue[800],
                        ),
                        child: Center(
                          child: Text(
                            'Confirm',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: onUpdateCancel,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.blue[800]!,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ),
    );
  }
}
