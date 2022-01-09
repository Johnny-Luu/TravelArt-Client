// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/screens/profile_screen/info_tab.dart';
import 'package:travelapp/screens/profile_screen/request_tab.dart';
import 'package:travelapp/services/customer_services.dart';

import 'tourgroup_tab.dart';

class ProfileScreen extends StatefulWidget {
  final Function callbackSetNavbar;
  ProfileScreen({Key? key, required this.callbackSetNavbar}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var nameController = TextEditingController();

  final firebaseAuth = FirebaseAuth.instance;
  final customerService = CustomerService();
  Customer? customer;

  ImageProvider? avatar;

  void loadData() async {
    customer = await customerService
        .getCustomerByEmail(firebaseAuth.currentUser?.email);

    nameController.text = customer!.name;

    if (customer!.avatar.isNotEmpty) {
      avatar = MemoryImage(base64Decode(customer!.avatar));
    }

    setState(() {});
  }

  void updateName(String name) {
    setState(() {
      customer!.name = name;
      nameController.text = name;
    });
  }

  Future pickImage() async {
    try {
      final ImagePicker _picker = ImagePicker();
      final img = await _picker.pickImage(source: ImageSource.gallery);

      if (img == null) return;

      final bytes = File(img.path).readAsBytesSync();
      String img64 = base64Encode(bytes);
      customerService.updateAvatar(customer!.id, img64);

      setState(() {
        avatar = FileImage(File(img.path));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                        : const AssetImage('assets/images/img-no-avatar.jpg'),
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
                              customer != null ? customer!.name : '',
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
                                customer != null ? customer!.email : '',
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
                      InkWell(
                        onTap: pickImage,
                        child: Container(
                          width: 60,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/icon-camera.png'),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              DefaultTabController(
                length: 3,
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
                    Tab(child: Text("Requests")),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: customer != null
                      ? [
                          // My info section
                          InfoTab(
                            customer: customer,
                            callbackSetNavbar: widget.callbackSetNavbar,
                            callbackUpdateName: updateName,
                          ),
                          TourGroupTab(customer: customer!),
                          RequestTab(customer: customer!)
                        ]
                      : [
                          Container(),
                          Container(),
                          Container(),
                        ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
