import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:travelapp/models/comment_model.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/screens/detail_screen/rating_bottom_sheet.dart';
import 'package:travelapp/services/customer_services.dart';
import 'package:travelapp/services/tourgroup_services.dart';
import 'package:travelapp/widgets/comment_item.dart';

class RatingTab extends StatefulWidget {
  final Tour tour;

  const RatingTab({
    Key? key,
    required this.tour,
  }) : super(key: key);

  @override
  State<RatingTab> createState() => _RatingTabState();
}

class _RatingTabState extends State<RatingTab> {
  var ratingPoint = 0.0;
  var countRating = 0;
  var ratingOne = 0;
  var ratingTwo = 0;
  var ratingThree = 0;
  var ratingFour = 0;
  var ratingFive = 0;
  bool canComment = false;

  final firebaseAuth = FirebaseAuth.instance;
  final tourGroupService = TourGroupService();
  final customerService = CustomerService();
  List<Customer> customers = [];

  void checkCanComment() async {
    // get current customer
    final currentUser = firebaseAuth.currentUser;
    final customer =
        await customerService.getCustomerByEmail(currentUser?.email);

    canComment =
        await tourGroupService.checkAttendance(widget.tour.id, customer.id);

    setState(() {});
  }

  void onSubmitComment(Comment comment) async {
    customerService.submitComment(widget.tour.id, comment);
    setState(() {
      bool isExist = false;
      for (var element in widget.tour.ratingList) {
        if (element.customerId == comment.customerId) {
          element.comment = comment.comment;
          element.rating = comment.rating;
          element.time = comment.time;
          isExist = true;
        }
      }

      if (!isExist) {
        widget.tour.ratingList.add(comment);
      }

      loadData();
    });
  }

  void loadData() async {
    ratingPoint = 0.0;
    countRating = 0;
    ratingOne = 0;
    ratingTwo = 0;
    ratingThree = 0;
    ratingFour = 0;
    ratingFive = 0;

    customers.clear();

    for (var comment in widget.tour.ratingList) {
      var customer = await customerService.getCustomerById(comment.customerId);
      customers.add(customer);

      ratingPoint += comment.rating;
      switch (comment.rating) {
        case 1:
          ratingOne++;
          break;
        case 2:
          ratingTwo++;
          break;
        case 3:
          ratingThree++;
          break;
        case 4:
          ratingFour++;
          break;
        case 5:
          ratingFive++;
          break;
      }
    }

    countRating = ratingOne + ratingTwo + ratingThree + ratingFour + ratingFive;
    if (countRating != 0) {
      ratingPoint = ratingPoint / countRating;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
    checkCanComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        ratingPoint.toStringAsFixed(1),
                        style: GoogleFonts.lato(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text('Total: $countRating'),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⭐⭐⭐⭐⭐  $ratingFive",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐⭐⭐  $ratingFour",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐⭐  $ratingThree",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐  $ratingTwo",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐  $ratingOne",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          customers.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  reverse: true,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: widget.tour.ratingList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Comment comment = widget.tour.ratingList[index];
                    Customer customer = customers[index];
                    return CommentItem(context, customer, comment);
                  },
                )
              : Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    child: const Text('No comment yet'),
                  ),
                ),
        ],
      ),
      floatingActionButton: canComment
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Image(
                color: Colors.white,
                image: AssetImage('assets/images/icon-write.png'),
              ),
              onPressed: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.0),
                      ),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: RatingBottomSheet(
                              callbackSubmitComment: onSubmitComment),
                        ),
                      );
                    });
              },
            )
          : Container(),
    );
  }
}
