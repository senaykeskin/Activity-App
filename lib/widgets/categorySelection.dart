import 'package:activity_app/global/global-variables.dart';
import 'package:activity_app/models/category_model.dart';
import 'package:activity_app/stores/category_store.dart';
import 'package:flutter/material.dart';

class CategorySelection extends StatelessWidget {
  final Function(String) onCategorySelected;

  const CategorySelection({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: H(context) * 0.7,
      padding: all10,
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CategoryModel>?>(
              stream: categoryStore.categoryListStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.data == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final list = snapshot.data![index];
                        final categoryName = list.name;

                        return ListTile(
                          title: Text(categoryName!),
                          onTap: () {
                            onCategorySelected(categoryName);
                            categoryStore.setSelectedCategory(categoryName);
                          },
                        );
                      });
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
