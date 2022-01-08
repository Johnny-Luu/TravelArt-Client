import 'package:flutter/material.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/models/tourgroup_model.dart';
import 'package:travelapp/services/tour_services.dart';
import 'package:travelapp/services/tourgroup_services.dart';
import 'package:travelapp/widgets/tourgroup_item.dart';

class TourGroupTab extends StatefulWidget {
  final Customer customer;
  const TourGroupTab({Key? key, required this.customer}) : super(key: key);

  @override
  State<TourGroupTab> createState() => _TourGroupTabState();
}

class _TourGroupTabState extends State<TourGroupTab> {
  final TourGroupService tourGroupService = TourGroupService();
  final TourService tourService = TourService();

  List<TourGroup> tourGroups = [];
  Map<String, Tour> tourMaps = {};

  void loadData() async {
    tourGroups =
        await tourGroupService.getTourGroupsOfACustomer(widget.customer.id);

    for (var tourGroup in tourGroups) {
      if (tourMaps.containsKey(tourGroup.tourId)) {
        continue;
      }

      var tour = await tourService.getTourById(tourGroup.tourId);
      tourMaps[tourGroup.tourId] = tour;
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return tourGroups.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: tourGroups.length,
            itemBuilder: (BuildContext context, int index) {
              return TourGroupItem(
                tourGroup: tourGroups[index],
                image: tourMaps[tourGroups[index].tourId]!.img,
                type: 2,
              );
            })
        : const Center(
            child: Text(
              'Empty list!',
              style: TextStyle(fontSize: 20),
            ),
          );
  }
}
