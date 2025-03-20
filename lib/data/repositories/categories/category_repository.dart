// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecommerce_app/features/shop/models/category_model.dart';
// import 'package:ecommerce_app/utils/exceptions/firebase_exceptions.dart';
// import 'package:ecommerce_app/utils/exceptions/platform_exceptions.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class CategoryRepository extends GetxController {
//   static CategoryRepository get instance => Get.find();

//   final _db = FirebaseFirestore.instance;

//   Future<List<CategoryModel>> getAllCategories() async {
//     try {
//       final snapshot = await _db.collection('Categories').get();
//       final list = snapshot.docs
//           .map((document) => CategoryModel.fromSnapshot(document))
//           .toList();
//       return list;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went Wrong. Please Try Again';
//     }
//   }

//   Future<void> uploadDummyData(List<CategoryModel> categories) async {
//   try {
//     final storage = Supabase.instance.client.storage.from('Categories');
//     final db = Supabase.instance.client;

//     for (var category in categories) {
//       // Get Image Data from Local Assets
//       final fileBytes = await rootBundle.load(category.image);
//       final fileName = '${DateTime.now().millisecondsSinceEpoch}_${category.name}.jpg';

//       // Upload Image to Supabase Storage
//       final response = await storage.uploadBinary(
//         'Images/$fileName',
//         fileBytes.buffer.asUint8List(),
//         fileOptions: const FileOptions(contentType: 'image/jpeg'),
//       );

//       if (response.isEmpty) throw 'Upload failed, please try again.';
       
//       // Get Public URL
//       final imageUrl = storage.getPublicUrl('Images/$fileName');
//       category.image = imageUrl;

//       // Store Category in Supabase Database
//       await db.from('Categories').upsert(category.toJson());
//     }
//   } catch (e) {
//     throw 'Something went wrong. Please try again. Error: $e';
//   }
// }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eproject_currensee/features/shop/models/category_model.dart';
import 'package:eproject_currensee/utils/exceptions/firebase_exceptions.dart';
import 'package:eproject_currensee/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _supabase = Supabase.instance.client;

  /// ✅ **Fix: Firebase se categories fetch karne ka masla solve**
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();

      print("Fetched ${list.length} categories from Firebase");  // ✅ Debugging ke liye print
      return list;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again. Error: $e';
    }
  }

  /// ✅ **Fix: Supabase ke liye upload function optimize**
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try {
      final storage = _supabase.storage.from('Categories');

      for (var category in categories) {
        // ✅ Fix: File ko correctly load karna
        final fileBytes = await rootBundle.load(category.image);
        final fileName = '${DateTime.now().millisecondsSinceEpoch}_${category.name}.jpg';

        // ✅ Fix: Image upload failure ko handle karna
        final response = await storage.uploadBinary(
          'Images/$fileName',
          fileBytes.buffer.asUint8List(),
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

        if (response.isEmpty) throw 'Upload failed, please try again.';

        // ✅ Fix: Public URL lena
        final imageUrl = storage.getPublicUrl('Images/$fileName');
        category.image = imageUrl;

        // ✅ Fix: Supabase Database me entry insert karna
        await _supabase.from('Categories').upsert(category.toJson());
      }
    } catch (e) {
      throw 'Something went wrong. Please try again. Error: $e';
    }
  }
}
