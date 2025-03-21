import 'dart:developer';

import 'package:activity_app/stores/category_store.dart';
import 'package:activity_app/stores/province_store.dart';
import 'package:activity_app/widgets/categorySelection.dart';
import 'package:activity_app/widgets/citySelection.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../../stores/event_store.dart';
import '../../global/global-variables.dart';
import '../../widgets/filterItems.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final BehaviorSubject<DateTime?> selectedDate =
      BehaviorSubject<DateTime?>();

  late final BehaviorSubject<bool> isFreeController =
      BehaviorSubject<bool>.seeded(false);

  final BehaviorSubject<String?> selectedProvince = BehaviorSubject<String?>();
  final BehaviorSubject<String?> selectedCategory = BehaviorSubject<String?>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    selectedDate.close();
    isFreeController.close();
    selectedProvince.close();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    DateTime firstDate = now;
    DateTime lastDate = now.add(const Duration(days: 45));

    DateTime? pickedDate = await showDatePicker(
      locale: const Locale("tr", "TR"),
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      selectedDate.add(pickedDate);
      eventStore.filterEventsByDate(pickedDate);
    } else {
      eventStore.resetEvents();
    }
  }

  void _showCitySelectionSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (context) {
        return CitySelectionSheet(
          onCitySelected: (String city) {
            selectedProvince.add(city);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _showCategorySelectionSheet(BuildContext context) {
    showModalBottomSheet(
        showDragHandle: true,
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        ),
        builder: (context) {
          return CategorySelection(
            onCategorySelected: (String category) {
              selectedCategory.add(category);
              Navigator.pop(context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtrele", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        width: W(context),
        height: H(context),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FilterItemsContainer(
                      text: "Katılım Ücretsiz",
                      widget: StreamBuilder<bool>(
                        stream: isFreeController.stream,
                        initialData: isFreeController.value,
                        builder: (context, snapshot) {
                          return Switch(
                            value: snapshot.data ?? false,
                            onChanged: (value) {
                              isFreeController.add(value);
                              eventStore.filterEventsByFreeStatus(value);
                            },
                          );
                        },
                      ),
                    ),
                    StreamBuilder<DateTime?>(
                      stream: selectedDate.stream,
                      builder: (context, snapshot) {
                        String dateText = "";
                        if (snapshot.hasData && snapshot.data != null) {
                          dateText =
                              "${snapshot.data!.day}/${snapshot.data!.month}/${snapshot.data!.year}";
                        }
                        return FilterItemsContainer(
                          text: "Tarih seç",
                          subtext: dateText,
                          widget: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.grey.shade700,
                          ),
                          onTap: _pickDate,
                        );
                      },
                    ),
                    StreamBuilder<String?>(
                      stream: provinceStore.selectedCityStream,
                      builder: (context, snapshot) {
                        String cityText = "";
                        if (snapshot.hasData && snapshot.data != null) {
                          cityText = snapshot.data.toString();
                        }
                        return FilterItemsContainer(
                          text: "Şehir Seç",
                          subtext: cityText,
                          widget: Icon(
                            Icons.chevron_right_outlined,
                            color: Colors.grey.shade700,
                          ),
                          onTap: () => _showCitySelectionSheet(context),
                        );
                      },
                    ),
                    StreamBuilder<String?>(
                        stream: categoryStore.selectedCategoryStream,
                        builder: (context, snapshot) {
                          String categoryText = "";
                          if (snapshot.hasData && snapshot.data != null) {
                            categoryText = snapshot.data.toString();
                          }
                          return FilterItemsContainer(
                            text: "Kategori Seç",
                            subtext: categoryText,
                            widget: Icon(
                              Icons.chevron_right_outlined,
                              color: Colors.grey.shade700,
                            ),
                            onTap: () => _showCategorySelectionSheet(context),
                          );
                        })
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: horizontal10 + vertical15,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: border10),
                  fixedSize: Size(W(context), 50),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Seçili Filtreleri Uygula",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
