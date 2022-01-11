import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/request_model.dart';
import 'package:travelapp/screens/home_screen/home_screen.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/widgets/success_snackbar.dart';

class ConfirmInfoScreen extends StatefulWidget {
  final String tourId;

  ConfirmInfoScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  _ConfirmInfoScreenState createState() => _ConfirmInfoScreenState();
}

class _ConfirmInfoScreenState extends State<ConfirmInfoScreen> {
  final customerService = CustomerService();
  final firebaseAuth = FirebaseAuth.instance;
  late Customer customer;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();

  var isEditting = false;

  void loadData() async {
    customer = await customerService
        .getCustomerByEmail(firebaseAuth.currentUser?.email);
    nameController.text = customer.name;
    emailController.text = customer.email;
    phoneController.text = customer.phone;
    addressController.text = customer.address;
  }

  void pushRequest() async {
    DateTime now = DateTime.now();

    var request = Request(
      date: formatDate(
        now,
        [yyyy, '-', mm, '-', dd],
      ) + "T00:00:00",
      time: formatDate(
        now,
        [HH, ':', nn],
      ),
      customerId: customer.id,
      tourGroupId: widget.tourId,
    );

    customerService.submitRequest(request);

    SuccessSnackbar.show(context, 'Submit request successfully!');
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Your',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 58,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Information',
                    style: GoogleFonts.playfairDisplay(
                      color: Theme.of(context).primaryColor,
                      fontSize: 38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  // edit button
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () => setState(() {
                          isEditting = true;
                        }),
                        child: Icon(
                          FontAwesomeIcons.pen,
                          size: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          enabled: isEditting,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // email
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Email',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: emailController,
                          enabled: isEditting,
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // phone
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Phone',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          enabled: isEditting,
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // address
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          controller: addressController,
                          enabled: isEditting,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 18),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isEditting
          ? InkWell(
              onTap: () => setState(() {
                isEditting = false;
              }),
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50.0),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 2.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Done",
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Icon(
                      FontAwesomeIcons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            )
          : InkWell(
              onTap: pushRequest,
              child: Container(
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 2),
                width: double.infinity,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send Request",
                      style: GoogleFonts.roboto(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    const Icon(
                      FontAwesomeIcons.solidPaperPlane,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
