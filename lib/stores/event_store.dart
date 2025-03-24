import 'dart:developer';
import 'package:activity_app/stores/category_store.dart';
import 'package:activity_app/stores/province_store.dart';
import 'package:rxdart/rxdart.dart';
import '../global/global-service.dart';
import '../models/activity_model.dart';

class EventStore {
  static final EventStore _instance = EventStore._internal();
  factory EventStore() => _instance;

  EventStore._internal();

  final BehaviorSubject<List<EventItem>> _visibleEventsController =
      BehaviorSubject<List<EventItem>>.seeded([]);

  Stream<List<EventItem>> get eventListStream =>
      _visibleEventsController.stream;

  final BehaviorSubject<DateTime?> _selectedDate =
      BehaviorSubject<DateTime?>.seeded(null);
  ValueStream<DateTime?> get selectedDateStream => _selectedDate.stream;

  final BehaviorSubject<bool> _isFreeController =
      BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isFreeControllerStream => _isFreeController.stream;

  final BehaviorSubject<int> _eventLength = BehaviorSubject<int>.seeded(1);
  Stream<int> get eventLengthStream => _eventLength.stream;

  final BehaviorSubject<bool> _isLoadingController =
      BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  bool get isLoading => _isLoadingController.value;

  List<EventItem> allEvents = [];
  List<EventItem> _filteredEvents = [];
  List<EventItem> _visibleEvents = [];

  String? selectedCity;
  String? selectedCategory;
  DateTime? selectedDate;
  bool isFree = false;

  Future<void> fetchAllEvents() async {
    try {
      _isLoadingController.add(true);
      final response = await ActivityService.getEvents(skip: 0, take: 0);

      allEvents = response;
      _filteredEvents = allEvents;

      _visibleEvents = allEvents.take(20).toList();
      _visibleEventsController.add(List.from(_visibleEvents));
    } catch (e) {
      inspect(e);
    } finally {
      _isLoadingController.add(false);
    }
  }

  void setIsFree(bool value) {
    _isFreeController.add(value);
    isFree = value;
  }

  void loadMoreEvents() {
    if (_visibleEvents.length < _filteredEvents.length) {
      int nextLength = _visibleEvents.length + 20;
      if (nextLength > _filteredEvents.length) {
        nextLength = _filteredEvents.length;
      }

      _visibleEvents = _filteredEvents.sublist(0, nextLength);
      _visibleEventsController.add(List.from(_visibleEvents));
    }
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate.add(date);
  }

  void updateFilteredEvents(List<EventItem> filteredEvents) {
    _filteredEvents = filteredEvents;
    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
  }

  void applyFilters() {
    _filteredEvents = allEvents.where((event) {
      if (selectedCity != null && event.venue?.city?.name != selectedCity) {
        return false;
      }

      if (selectedCategory != null &&
          event.category?.name != selectedCategory) {
        return false;
      }

      if (selectedDate != null &&
          !(event.start?.isSameDay(selectedDate!) ?? false)) {
        return false;
      }

      if (isFree && !(event.isFree ?? false)) {
        return false;
      }

      return true;
    }).toList();

    _visibleEvents = _filteredEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
    _eventLength.add(_filteredEvents.isEmpty ? 0 : 2);
  }

  void filterEventsByCity(String city) {
    selectedCity = city;
    applyFilters();
  }

  void filterEventsByCategory(String category) {
    selectedCategory = category;
    applyFilters();
  }

  void filterEventsByDate(DateTime date) {
    selectedDate = date;
    applyFilters();
  }

  void filterEventsByFreeStatus(bool free) {
    isFree = free;
    applyFilters();
  }

  void resetEvents() {
    provinceStore.selectedCity.add("");
    categoryStore.selectedCategory.add("");
    _selectedDate.add(null);
    setIsFree(false);
    _filteredEvents = allEvents;
    _visibleEvents = allEvents.take(20).toList();
    _visibleEventsController.add(List.from(_visibleEvents));
    _eventLength.add(1);
  }

  void dispose() {
    _visibleEventsController.close();
    _isLoadingController.close();
  }
}

final eventStore = EventStore();

extension DateTimeComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
