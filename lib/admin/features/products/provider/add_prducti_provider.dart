import 'dart:io';

import 'package:amazone_clone/admin/features/products/service/add_product_service.dart';
import 'package:amazone_clone/core/handler.dart';
import 'package:flutter/cupertino.dart';

class AddPrductiProvider extends ChangeNotifier {
  StateHandler<List<File?>> images = StateHandler.initial();
  StateHandler<List<File?>> get imageState => images;
  set setImage(StateHandler<List<File?>> imageFiles) {
    images = imageFiles;
    notifyListeners();
  }

  void selectImages() async {
    setImage = StateHandler.loading();
    final result = await AddProductService.getImage();
    result.fold(
      (l) => setImage = StateHandler.error(l.errorMessage),
      (r) => setImage = StateHandler.success(r),
    );
  }
}
