import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  return Card(
                    margin: vertical8,
                    shape: RoundedRectangleBorder(
                      borderRadius: border10,
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: all8,
                      title: Text(event.name.toString()),
                      subtitle: Text(event.category!.name.toString()),
                      leading: Image.network(event.posterUrl.toString()),
                      onTap: () {},
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
