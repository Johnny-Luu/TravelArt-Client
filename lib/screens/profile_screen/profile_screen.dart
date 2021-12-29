// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/screens/profile_screen/info_tab.dart';
import 'package:travelapp/services/customer_services.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var isEditing = false;

  ImageProvider? avatar;

  final customerService = CustomerService();
  final firebaseAuth = FirebaseAuth.instance;
  Customer? customer;

  void loadData() async {
    customer = await customerService
        .getCustomerByEmail(firebaseAuth.currentUser?.email);

    nameController.text = customer!.name;
    emailController.text = customer!.email;
    phoneController.text = customer!.phone;
    addressController.text = customer!.address;

    avatar = MemoryImage(base64Decode(customer!.avatar));

    setState(() {});
  }

  void updateName(String name) {
    setState(() {
      customer!.name = name;
      nameController.text = name;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2.5,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: avatar != null
                    ? avatar!
                    : const AssetImage('assets/images/img-avatar.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          customer?.name ?? '',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.envelope,
                            color: Colors.white,
                            size: 16,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            customer?.email ?? '',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.3),
                    ),
                    child: const Image(
                      image: AssetImage('assets/images/icon-camera.png'),
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DefaultTabController(
            length: 2,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.blue[800],
              unselectedLabelColor: Colors.grey,
              labelStyle: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2.0,
                  color: Colors.blue[800]!,
                ),
                insets: const EdgeInsets.symmetric(horizontal: 75.0),
              ),
              tabs: const [
                Tab(child: Text("My info")),
                Tab(child: Text("My Groups")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // My info section
                customer != null
                    ? InfoTab(
                        customer: customer,
                        callbackUpdateName: updateName,
                      )
                    : SizedBox(),
                Text("My Groups"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
