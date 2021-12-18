import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RatingBottomSheet extends StatefulWidget {
  const RatingBottomSheet({Key? key}) : super(key: key);

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  var _rating = 0.0;
  var _comment = "";

  void ratingText() {
    switch (_rating.toInt()) {
      case 1:
        _comment = "Very Bad";
        return;
      case 2:
        _comment = "Bad";
        return;
      case 3:
        _comment = "Good";
        return;
      case 4:
        _comment = "Very Good";
        return;
      case 5:
        _comment = "Excellent";
        return;
      default:
        _comment = "";
        return;
    }
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
          rating: _rating,
          onRated: (value) {
            setState(() {
              _rating = value;
              ratingText();
            });
          },
        ),
        const SizedBox(height: 10.0),
        Text(_comment),
        const SizedBox(height: 20.0),
        const TextField(
          maxLength: 200,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Comment',
          ),
        ),
        const SizedBox(height: 30.0),
      ],
    );
  }
}
