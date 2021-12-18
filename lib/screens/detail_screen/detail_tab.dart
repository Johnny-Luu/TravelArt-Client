import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

Widget DetailTab(BuildContext context) {
  return Scaffold(
    body: ListView(
      padding: const EdgeInsets.all(0.0),
      physics: const BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.blue[50]!,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Rating",
                          style: GoogleFonts.lato(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.star,
                              color: Theme.of(context).primaryColor,
                              size: 14.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              "4.5",
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        const Text(
                          "100 Reviews",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.blue[50]!,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Price",
                          style: GoogleFonts.lato(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Theme.of(context).primaryColor,
                              size: 14.0,
                            ),
                            Text(
                              "1.200.000",
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        const Text(
                          "vnd",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100,
                    padding: const EdgeInsets.all(14.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.blue[50]!,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Visit",
                          style: GoogleFonts.lato(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).primaryColor,
                              size: 16.0,
                            ),
                            Text(
                              "3",
                              style: GoogleFonts.roboto(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5.0),
                        const Text(
                          "locations",
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.lato(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sollicitudin sed ligula vel rutrum. Nulla facilisi. Mauris neque urna, imperdiet nec felis a, varius rutrum neque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris blandit, arcu eu tristique bibendum, ante odio tristique nibh, ut pulvinar sem augue quis neque. Pellentesque elementum purus id orci interdum, eget lobortis urna mollis. Donec a massa consectetur, fringilla augue in, pellentesque libero.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: Container(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 2),
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
            "Book Now",
            style: GoogleFonts.roboto(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          const Icon(
            FontAwesomeIcons.angleDoubleRight,
            color: Colors.white,
          ),
        ],
      ),
    ),
  );
}
