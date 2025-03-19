import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import '../global/event_store.dart';
import '../global/global-variables.dart';
import '../module/filter_screen/filter_screen.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({super.key});

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  String searchQuery = "";

  void _filterEvents(String query) {
    if (query.isNotEmpty) {
      final filtered = eventStore.allEvents
          .where((event) =>
              event.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      eventStore.updateFilteredEvents(filtered);
    } else {
      eventStore.resetEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: horizontal10,
          width: W(context) * 0.75,
          height: H(context) * 0.06,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            onChanged: (value) {
              searchQuery = value;
              _filterEvents(value);
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(Icons.search_outlined),
              iconColor: Colors.grey.shade400,
              hintText: "Arama yapın...",
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size(H(context) * 0.06, H(context) * 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.shade400, width: 1.5),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.bottomToTop,
                  childBuilder: (context) => FilterScreen(),
                  duration: Duration(milliseconds: 300)),
            );
          },
          child: FaIcon(FontAwesomeIcons.sliders, color: Colors.black),
        ),
      ],
    );
  }
}
