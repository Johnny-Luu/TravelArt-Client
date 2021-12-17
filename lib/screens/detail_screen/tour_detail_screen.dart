import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/activity_model.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/widgets/planning_item.dart';

class TourDetailScreen extends StatefulWidget {
  final Destination destination;

  const TourDetailScreen({Key? key, required this.destination})
      : super(key: key);

  @override
  _TourDetailScreenState createState() => _TourDetailScreenState();
}

class _TourDetailScreenState extends State<TourDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              // Main image
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Hero(
                  tag: widget.destination.imageUrl,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(widget.destination.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // buttons row
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.black,
                      onPressed: () => Navigator.pop(context),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(Icons.search),
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.sortAmountDown),
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // name and province
              Positioned(
                left: 20.0,
                right: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.destination.city,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15.0,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5.0),
                            Text(
                              widget.destination.country,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.dollarSign,
                              size: 18.0,
                              color: Colors.white,
                            ),
                            Text(
                              "1.000.000 VND",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.location_on,
                              size: 20.0,
                              color: Colors.white,
                            ),
                            Text(
                              "3 locations",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          DefaultTabController(
            length: 2,
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
                Tab(child: Text("Description")),
                Tab(child: Text("Plan")),
                Tab(child: Text("Rating")),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // description section
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur sollicitudin sed ligula vel rutrum. Nulla facilisi. Mauris neque urna, imperdiet nec felis a, varius rutrum neque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris blandit, arcu eu tristique bibendum, ante odio tristique nibh, ut pulvinar sem augue quis neque. Pellentesque elementum purus id orci interdum, eget lobortis urna mollis. Donec a massa consectetur, fringilla augue in, pellentesque libero.",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ),
                // planning section
                ListView.builder(
                  padding: const EdgeInsets.all(15.0),
                  itemCount: widget.destination.activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    Activity activity = widget.destination.activities[index];
                    return PlanningItem(activity, context);
                  },
                ),
                // rating section
                const Text("Hello word 2"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}