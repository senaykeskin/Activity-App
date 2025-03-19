import 'package:activity_app/global/global-variables.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Filter variables
  String? _selectedDate;
  bool isFree = false;
  String? _selectedCategory;
  String? _selectedCity;

  // Dummy data for the filters
  final List<String> dates = ['Today', 'This Week', 'This Month', 'Next Month'];
  final List<String> categories = ['Music', 'Art', 'Tech', 'Sports'];
  final List<String> cities = ['Istanbul', 'Ankara', 'Izmir', 'Bursa'];

  static const WidgetStateProperty<Icon> thumbIcon = WidgetStateProperty<Icon>.fromMap(
    <WidgetStatesConstraint, Icon>{
      WidgetState.selected: Icon(Icons.check),
      WidgetState.any: Icon(Icons.close),
    },
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Filtrele", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.deepPurple,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: horizontal10 + top10,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Katılım Ücretsiz", style: TextStyle(
                    fontSize: 16, color: Colors.black
                  ),),
                  Switch(
                    thumbIcon: thumbIcon,
                    value: isFree,
                    onChanged: (bool value) {
                      setState(() {
                        isFree = value;
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
