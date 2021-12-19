import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/screens/confirm_info_screen/confirm_info_screen.dart';

class TourGroupItem extends StatelessWidget {
  const TourGroupItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
            height: 150.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(90.0, 20.0, 20.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Gondola winter 2021",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 5.0),
                  // start & end date
                  Row(
                    children: const [
                      Text(
                        "12/12/2021",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/images/icon-paper-plane.png",
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Text(
                        "22/12/2021",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  // tour guide
                  Row(
                    children: const [
                      Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/images/icon-tourist-guide.png",
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        "La Thanh H",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  // tour deputy
                  Row(
                    children: const [
                      Image(
                        width: 18.0,
                        image: AssetImage(
                          "assets/images/icon-hat.png",
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        "Pham Nguyen Thanh T",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Image
          Positioned(
            left: 10.0,
            top: 15.0,
            bottom: 15.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const Image(
                width: 110.0,
                height: 200.0,
                image: AssetImage("assets/images/gondola.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Book button
          Positioned(
            right: 10.0,
            bottom: 0.0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmInfoScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                  horizontal: 20.0,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(1.0, 2.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                child: Text(
                  "Book",
                  style: GoogleFonts.roboto(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // slot
          Positioned(
            right: 30.0,
            top: 10.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "3/",
                  style: GoogleFonts.roboto(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "25",
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
