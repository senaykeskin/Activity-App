import 'package:activity_app/global/global-variables.dart';
import 'package:activity_app/stores/province_store.dart';
import 'package:flutter/material.dart';
import 'package:activity_app/models/province_model.dart';

class CitySelectionSheet extends StatelessWidget {
  final Function(String) onCitySelected;

  const CitySelectionSheet({super.key, required this.onCitySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: H(context) * 0.7,
      padding: all10,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<ProvinceModel>?>(
              stream: provinceStore.provinceListStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data![0].data.length,
                    itemBuilder: (context, index) {
                      final province = snapshot.data![0];
                      final cityName = province.data[index].name;

                      return ListTile(
                        title: Text(cityName),
                        onTap: () {
                          onCitySelected(cityName);
                          provinceStore.setSelectedCity(cityName);
                        },
                      );
                    },
                  );
                }

                return const Center();
              },
            ),
          ),
        ],
      ),
    );
  }
}
