import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:travelapp/screens/detail_screen/rating_bottom_sheet.dart';
import 'package:travelapp/widgets/comment_item.dart';

class RatingTab extends StatefulWidget {
  const RatingTab({
    Key? key,
  }) : super(key: key);

  @override
  State<RatingTab> createState() => _RatingTabState();
}

class _RatingTabState extends State<RatingTab> {
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
                        '4.5',
                        style: GoogleFonts.lato(
                          fontSize: 60.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.blue[900],
                        ),
                      ),
                      Text('Total: 100'),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "⭐⭐⭐⭐⭐  12",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐⭐⭐  10",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐⭐  5",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐⭐  2",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "⭐  0",
                        style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return CommentItem(context);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
                    child: RatingBottomSheet(),
                  ),
                );
              });
        },
      ),
    );
  }
}
