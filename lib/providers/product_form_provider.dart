import 'package:flutter/material.dart';

import '../models/models.dart';

class ProductFormProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider({required this.product});

  void updateAvailability(bool value) {
    product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}