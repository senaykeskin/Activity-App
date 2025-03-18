import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../global/global-service.dart';
import '../../global/global-variables.dart';
import '../../models/activity_model.dart';
import '../../widgets/searchAndFilter.dart';

class ActivityHomeScreen extends StatefulWidget {
  const ActivityHomeScreen({super.key});

  @override
  State<ActivityHomeScreen> createState() => _ActivityHomeScreenState();
}

class _ActivityHomeScreenState extends State<ActivityHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<EventItem> _eventList = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _perPage = 20;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchEvents() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await ActivityService.getEvents(
        skip: _currentPage * _perPage,
        take: _perPage,
      );
      final List<EventItem> newEvents = response;

      setState(() {
        if (newEvents.length < _perPage) {
          _hasMoreData = false;
        }
        _eventList.addAll(newEvents);
        _currentPage++;
      });
    } catch (e) {
      inspect(e);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading) {
      _fetchEvents();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Ana Sayfa",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: all10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchAndFilter(),
            Padding(
              padding: top30,
              child: const Text(
                "Yaklaşan Etkinlikler",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _eventList.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _eventList.length) {
                    return Center(
                      child: Padding(
                        padding: all10,
                        child: Platform.isIOS
                            ? const CupertinoActivityIndicator()
                            : const CircularProgressIndicator(),
                      ),
                    );
                  }
                  final event = _eventList[index];
                  return Container(
                    height: H(context) * 0.23,
                    margin: top10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: border15),
                          fixedSize: Size(W(context), H(context) * 0.15),
                          padding: EdgeInsets.zero,
                          elevation: 2),
                      onPressed: () {
                        // Todo: navigasyon eklenecek
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 5,
                              bottom: 5,
                              child: SizedBox(
                                width: W(context) * 0.4,
                                height: H(context) * 0.13,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    event.posterUrl.toString(),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 10,
                                left: W(context) * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      event.name.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                )),
                            Positioned(
                                bottom: 5,
                                left: W(context) * 0.43,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.mapLocationDot,
                                          color: Colors.grey[800],
                                          size: 20,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "${event.venue?.district?.name} / "
                                          "${event.venue?.city?.name}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_filled_outlined,
                                            color: Colors.grey[800], size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          DateFormat.Hm().format(DateTime.parse(
                                              event.start.toString())),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[800],
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 7),
                                    Container(
                                      padding: all8,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          borderRadius: border15),
                                      child: Text(
                                        DateFormat("d MMMM", "tr_TR").format(
                                            DateTime.parse(
                                                event.start.toString())),
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
