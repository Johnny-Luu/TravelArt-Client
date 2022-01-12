import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/models/tourgroup_model.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/services/tourgroup_services.dart';
import 'package:travelapp/widgets/tourgroup_item.dart';

class ChooseTourGroupScreen extends StatefulWidget {
  final Tour tour;

  ChooseTourGroupScreen({Key? key, required this.tour}) : super(key: key);

  @override
  _ChooseTourGroupState createState() => _ChooseTourGroupState();
}

class _ChooseTourGroupState extends State<ChooseTourGroupScreen> {
  final firebaseAuth = FirebaseAuth.instance;
  final customerService = CustomerService();
  Customer? customer;

  final tourGroupService = TourGroupService();
  List<TourGroup> tourGroups = [];

  var isLoading = true;

  void loadTourGroups() async {
    customer = await customerService
        .getCustomerByEmail(firebaseAuth.currentUser?.email);

    tourGroups = await tourGroupService.getAvailableTourGroup(
        widget.tour.id, customer!.id);

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTourGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick',
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 58,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'a group',
                              style: GoogleFonts.playfairDisplay(
                                color: Theme.of(context).primaryColor,
                                fontSize: 38,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      isLoading
                          ? Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 40.0),
                                child: const CircularProgressIndicator(),
                              ),
                            )
                          : tourGroups.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: tourGroups.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TourGroupItem(
                                      tourGroup: tourGroups[index],
                                      image: widget.tour.img,
                                      type: 1,
                                    );
                                  },
                                )
                              : Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 30.0),
                                    child: Text(
                                      'No groups available!',
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
