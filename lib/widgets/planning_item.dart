import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/activity_model.dart';

Widget PlanningItem(Activity activity, BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        margin: const EdgeInsets.fromLTRB(40.0, 5.0, 20.0, 5.0),
        height: 170.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                activity.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 5.0),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sollicitudin sed ligula vel rutrum. Nulla facilisi. Mauris neque urna, imperdiet nec felis a, varius rutrum neque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris blandit, arcu eu tristique bibendum, ante odio tristique nibh, ut pulvinar sem augue quis neque. Pellentesque elementum purus id orci interdum, eget lobortis urna mollis. Donec a massa consectetur, fringilla augue in, pellentesque libero.",
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        left: 20.0,
        top: 15.0,
        bottom: 15.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Stack(
            children: [
              Image(
                width: 110.0,
                height: 200.0,
                image: AssetImage(
                  activity.imageUrl,
                ),
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: -20,
                child: Text(
                  "1",
                  style: GoogleFonts.playfairDisplay(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 160.0,
                    fontWeight: FontWeight.w600,
                    height: 1.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ],
  );
}
