import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfirmInfoScreen extends StatefulWidget {
  ConfirmInfoScreen({Key? key}) : super(key: key);

  @override
  _ConfirmInfoScreenState createState() => _ConfirmInfoScreenState();
}

class _ConfirmInfoScreenState extends State<ConfirmInfoScreen> {
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
                  const SizedBox(height: 40.0),
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
                      Expanded(
                        child: TextField(
                          enabled: false,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
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
                      Expanded(
                        child: TextField(
                          enabled: false,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
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
                      Expanded(
                        child: TextField(
                          enabled: false,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
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
                      Expanded(
                        child: TextField(
                          enabled: false,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(border: InputBorder.none),
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
      bottomNavigationBar: Container(
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
    );
  }
}
