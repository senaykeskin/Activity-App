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

/*

Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
// Filter by Date
Text('Tarihe Göre', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
DropdownButton<String>(
value: _selectedDate,
hint: Text('Bir tarih seçin'),
onChanged: (value) {
setState(() {
_selectedDate = value;
});
},
items: dates.map((String date) {
return DropdownMenuItem<String>(
value: date,
child: Text(date),
);
}).toList(),
),
SizedBox(height: 20),

// Filter by Free
Text('Ücretsiz Etkinlikler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
SwitchListTile(
title: Text('Sadece Ücretsiz Etkinlikler'),
value: _isFree,
onChanged: (value) {
setState(() {
_isFree = value;
});
},
),
SizedBox(height: 20),

// Filter by Category
Text('Kategorilere Göre', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
DropdownButton<String>(
value: _selectedCategory,
hint: Text('Bir kategori seçin'),
onChanged: (value) {
setState(() {
_selectedCategory = value;
});
},
items: categories.map((String category) {
return DropdownMenuItem<String>(
value: category,
child: Text(category),
);
}).toList(),
),
SizedBox(height: 20),

// Filter by City
Text('Şehre Göre', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
DropdownButton<String>(
value: _selectedCity,
hint: Text('Bir şehir seçin'),
onChanged: (value) {
setState(() {
_selectedCity = value;
});
},
items: cities.map((String city) {
return DropdownMenuItem<String>(
value: city,
child: Text(city),
);
}).toList(),
),
SizedBox(height: 20),

// Apply Filters Button
ElevatedButton(
onPressed: () {
// Apply the filters and pass the data to the events list
// Here, you would apply the filter logic using the selected values
// For example: eventStore.applyFilters(_selectedDate, _isFree, _selectedCategory, _selectedCity);
},
child: Text("Filtreleri Uygula"),
),
],
),
),

 */
