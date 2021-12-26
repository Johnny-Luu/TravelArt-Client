import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:travelapp/models/comment_model.dart';
import 'package:travelapp/services/customer_services.dart';

class RatingBottomSheet extends StatefulWidget {
  final Function callbackSubmitComment;

  const RatingBottomSheet({
    Key? key,
    required this.callbackSubmitComment,
  }) : super(key: key);

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  final firebaseAuth = FirebaseAuth.instance;
  final customerService = CustomerService();
  late var customer;

  final _commentController = TextEditingController();
  var _ratingPoint = 0.0;
  var _ratingText = "";

  void ratingText() {
    switch (_ratingPoint.toInt()) {
      case 1:
        _ratingText = "Awful";
        return;
      case 2:
        _ratingText = "Bad";
        return;
      case 3:
        _ratingText = "Normal";
        return;
      case 4:
        _ratingText = "Good";
        return;
      case 5:
        _ratingText = "Excellent";
        return;
      default:
        _ratingText = "";
        return;
    }
  }

  void onSubmit() async {
    if (_ratingPoint == 0.0 || _commentController.text.isEmpty) {
      // TODO: HANDLE SHOW EMPTY COMMENT HERE
      return;
    }

    // get current customer
    final currentUser = firebaseAuth.currentUser;
    final customer =
        await customerService.getCustomerByEmail(currentUser?.email);

    Comment comment = Comment(
      customerId: customer.id,
      rating: _ratingPoint.toInt(),
      comment: _commentController.text,
      time: formatDate(
        DateTime.now(),
        [dd, '/', mm, '/', yyyy],
      ),
    );

    widget.callbackSubmitComment(comment);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Leave your rating",
          style: GoogleFonts.playfairDisplay(fontSize: 30.0),
        ),
        const SizedBox(height: 20.0),
        SmoothStarRating(
          allowHalfRating: false,
          starCount: 5,
          color: Colors.amber,
          size: 30,
          spacing: 6,
          borderColor: Colors.amber,
          defaultIconData: FontAwesomeIcons.star,
          filledIconData: FontAwesomeIcons.solidStar,
          rating: _ratingPoint,
          onRated: (value) {
            setState(() {
              _ratingPoint = value;
              ratingText();
            });
          },
        ),
        const SizedBox(height: 10.0),
        Text(_ratingText),
        const SizedBox(height: 20.0),
        TextField(
          controller: _commentController,
          maxLines: null,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
            labelText: 'Comment',
          ),
        ),
        const SizedBox(height: 20.0),
        InkWell(
          onTap: onSubmit,
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
                  "Submit",
                  style: GoogleFonts.roboto(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4.0),
                const Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 18,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
