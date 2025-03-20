// import 'package:ecommerce_app/data/repositories/categories/category_repository.dart';
// import 'package:ecommerce_app/features/shop/models/category_model.dart';
// import 'package:ecommerce_app/utils/popups/loaders.dart';
// import 'package:get/get.dart';

// class CategoryController extends GetxController {
//   static CategoryController get instance => Get.find();

//   final isloading = false.obs;
//   final _categoryRepository = Get.put(CategoryRepository());
//   RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
//   RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

//   @override
//   void onInit() {
//     fetchCategories();
//     super.onInit();
//   }

//   Future<void> fetchCategories() async {
//     try {
//       isloading.value = true;

//       final categories = await _categoryRepository.getAllCategories();

//       allCategories.assignAll(categories);

//       featuredCategories.assignAll(allCategories.where(
//           (category) => category.isFeatured && category.parentId.isNotEmpty).take(8).toList());
//     } catch (e) {
//       Tloaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
//     } finally {

//       isloading.value = false;
//     }
//   }
// }

import 'package:eproject_currensee/data/repositories/categories/category_repository.dart';
import 'package:eproject_currensee/features/shop/models/category_model.dart';
import 'package:eproject_currensee/utils/popups/loaders.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isloading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }


  Future<void> fetchCategories() async {
  try {
    isloading.value = true;
    print("Fetching categories...");

    final categories = await _categoryRepository.getAllCategories();
    allCategories.assignAll(categories);

    // ✅ Debugging: Print all category names
    print("All Categories Loaded: ${allCategories.length}");
    for (var category in allCategories) {
      print("Category: ${category.name} | isFeatured: ${category.isFeatured} | parentId: ${category.parentId}");
    }

    // ✅ Filtering Featured Categories
    featuredCategories.assignAll(allCategories.where(
      (category) => category.isFeatured && category.parentId.isNotEmpty).take(8).toList());

    // ✅ Debugging: Print featured categories count
    print("Featured Categories Loaded: ${featuredCategories.length}");
    for (var category in featuredCategories) {
      print("Featured Category: ${category.name}");
    }

  } catch (e) {
    Tloaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  } finally {
    isloading.value = false;
  }
}

}
