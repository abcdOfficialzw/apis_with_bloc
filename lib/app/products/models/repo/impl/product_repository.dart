import 'dart:convert';

import 'package:apis_with_bloc/app/products/models/data/products_model.dart';

import '../../../../../services/data_provider.dart';

class ProductRepository {
  DataProvider dataProvider = DataProvider();
  Future<ProductsModel> getProducts() async {
    try {
      final response = await DataProvider.getRequest(
          endpoint: "https://dummyjson.com/products");
      if (response.statusCode == 200) {
        ProductsModel products =
            ProductsModel.fromJson(jsonDecode(response.body));
        return products;
      } else {
        throw "Error loading product";
      }
    } catch (e) {
      rethrow;
    }
  }
}
