import 'package:base_getx/base_getx.dart';
import 'package:demo_getx/main.dart';
import 'package:demo_getx/model/product.dart';
import 'package:demo_getx/product/product_repository.dart';
import 'package:demo_getx/utils/my_database.dart';
import 'package:flutter/material.dart';

class ProductController extends BaseGetX {
  List<Product> products = [];
  // RxList<Product> products = RxList();

  final _repository = ProductRepository();
  void getProducts() async {
    var res = await _repository.getProducts(1);
    products = res;
    update();
  }

  void addProduct(Product product, int currentId) async {
    var res = await product.insert();
    products.add(product);
    update();
    if (res > 0) {
      Get.showSnackbar(GetBar(
        title: 'Thêm sản phẩm',
        message: 'Thêm sản phẩm thành công!',
      ));
      preferences.setInt(keyIdProduct, currentId);
    } else {
      Get.showSnackbar(GetBar(
        title: 'Thêm sản phẩm',
        message: 'Thêm sản phẩm thất bại!',
        backgroundColor: Colors.red,
      ));
    }
  }
}
