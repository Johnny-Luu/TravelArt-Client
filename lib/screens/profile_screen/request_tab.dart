import 'package:flutter/material.dart';
import 'package:travelapp/models/customer_model.dart';
import 'package:travelapp/models/tour_model.dart';
import 'package:travelapp/models/tourgroup_model.dart';
import 'package:travelapp/services/tour_services.dart';
import 'package:travelapp/services/tourgroup_services.dart';
import 'package:travelapp/widgets/tourgroup_item.dart';

class RequestTab extends StatefulWidget {
  final Customer customer;
  const RequestTab({Key? key, required this.customer}) : super(key: key);

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  final TourGroupService tourGroupService = TourGroupService();
  final TourService tourService = TourService();

  List<TourGroup> tourGroups = [];
  Map<String, Tour> tourMaps = {};

  var isLoading = true;

  void loadData() async {
    tourGroups =
        await tourGroupService.getRequestedTourGroups(widget.customer.id);

    for (var tourGroup in tourGroups) {
      if (tourMaps.containsKey(tourGroup.tourId)) {
        continue;
      }

      var tour = await tourService.getTourById(tourGroup.tourId);
      tourMaps[tourGroup.tourId] = tour;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : tourGroups.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: tourGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return TourGroupItem(
                    tourGroup: tourGroups[index],
                    image: tourMaps[tourGroups[index].tourId]!.img,
                    type: 3,
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
