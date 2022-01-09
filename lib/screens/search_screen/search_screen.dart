import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/services/destination_services.dart';
import 'package:travelapp/services/tour_services.dart';
import 'package:travelapp/widgets/circle_indicator.dart';
import 'package:travelapp/widgets/planning_item.dart';
import 'package:travelapp/widgets/sliver_appbar_delegate.dart';
import 'package:travelapp/widgets/tour_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _searchController = TextEditingController();

  var tourServices = TourService();
  var destinationService = DestinationService();

  List<Tour> tourList = [];
  List<Tour> tourRenderList = [];
  List<Destination> destinationList = [];
  List<Destination> destinationRenderList = [];

  void loadData() async {
    tourList = await tourServices.getAllTours();
    destinationList = await destinationService.getAllDestinations();

    tourRenderList = tourList;
    destinationRenderList = destinationList;

    setState(() {});
  }

  void onSearchSubmit(String value) {
    if (value.isEmpty) return;

    if (_tabController.index == 0) {
      setState(() {
        tourRenderList = tourList
            .where(
                (tour) => tour.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        destinationRenderList = destinationList
            .where((destination) =>
                destination.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  void onClearSearch() {
    _searchController.clear();
    setState(() {
      tourRenderList = tourList;
      destinationRenderList = destinationList;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              centerTitle: false,
              backgroundColor: Colors.white,
              elevation: 0,
              expandedHeight: MediaQuery.of(context).size.height * 0.25,
              flexibleSpace: const FlexibleSpaceBar(
                background: Image(
                  image:
                      AssetImage('assets/images/img-background-search-2.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              bottom: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .scaffoldBackgroundColor
                        .withOpacity(0.8),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _searchController,
                        onSubmitted: onSearchSubmit,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Search for something',
                          hintStyle: const TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                          prefixIcon: const ImageIcon(
                            AssetImage(
                                'assets/icons/icon-search-textfield.png'),
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            color: Colors.grey,
                            onPressed: onClearSearch,
                          ),
                        ),
                      ),
                      suggestionsCallback: _tabController.index == 0
                          ? (pattern) {
                              return tourList
                                  .where((tour) =>
                                      tour.name.toLowerCase().contains(pattern))
                                  .map((tour) => tour.name)
                                  .toList();
                            }
                          : (pattern) {
                              return destinationList
                                  .where((destination) => destination.name
                                      .toLowerCase()
                                      .contains(pattern))
                                  .map((destination) => destination.name)
                                  .toList();
                            },
                      itemBuilder: (context, String? suggestion) {
                        return ListTile(
                          title: Text(suggestion!),
                        );
                      },
                      onSuggestionSelected: (String? suggestion) {
                        _searchController.text = suggestion!;
                        onSearchSubmit(suggestion);
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
              color: Colors.transparent,
              tabbar: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                labelStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
                indicator: CircleTabIndicator(
                  color: Colors.black87,
                  radius: 4,
                ),
                tabs: const [
                  Tab(text: 'Tour'),
                  Tab(text: 'Destination'),
                ],
              ),
            )),
          ];
        },
        body: TabBarView(
            controller: _tabController,
            children: tourList.isNotEmpty && destinationList.isNotEmpty
                ? [
                    // tour list
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      itemCount: tourRenderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Tour tour = tourRenderList[index];
                        Image tourImg = Image.memory(base64Decode(tour.img));
                        return TourItem(tour: tour, tourImg: tourImg, type: 2);
                      },
                    ),
                    // destination list
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(15.0),
                      itemCount: destinationRenderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Destination destination = destinationRenderList[index];
                        return PlanningItem(
                          destination: destination,
                          index: index + 1,
                        );
                      },
                    )
                  ]
                : [
                    Container(),
                    Container(),
                  ]),
      ),
    );
  }
}
