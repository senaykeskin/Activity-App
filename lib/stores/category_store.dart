import 'package:activity_app/models/category_model.dart';
import 'package:activity_app/module/filter_screen/category_service.dart';
import 'package:rxdart/rxdart.dart';
import 'event_store.dart';

class CategoryStore {
  final BehaviorSubject<List<CategoryModel>?> categoryList =
      BehaviorSubject<List<CategoryModel>?>.seeded([]);

  Stream<List<CategoryModel>?> get categoryListStream => categoryList.stream;

  final BehaviorSubject<String?> selectedCategory =
      BehaviorSubject<String?>.seeded(null);

  Stream<String?> get selectedCategoryStream => selectedCategory.stream;

  Future<void> loadCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      if (categories.isEmpty) {}
      categoryList.add(categories);
    } catch (e) {
      categoryList.sink.add([]);
    }
  }

  void setSelectedCategory(String category) {
    selectedCategory.add(category);
    eventStore.filterEventsByCategory(category);
  }

  void filterEventsByCategory(String category) {
    eventStore.filterEventsByCategory(category);
  }

  void dispose() {
    categoryList.close();
    selectedCategory.close();
  }
}

final categoryStore = CategoryStore();
