import 'package:base_getx/base_getx.dart';
import 'package:demo_getx/main.dart';
import 'package:demo_getx/model/product.dart';
import 'package:demo_getx/product/product_controller.dart';
import 'package:demo_getx/utils/my_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState
    extends BaseStatefulGet<ProductPage, ProductController> {
  int count = 1;
  final _textController = TextEditingController();
  @override
  void initController() {
    controller = Get.put(ProductController());
    controller.getProducts();
  }

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('product'),
        actions: [
          IconButton(
              onPressed: () {
                int currentId = preferences.getInt(keyIdProduct) ?? 0;
                int newId = currentId + 1;
                final _product = Product(id: newId, name: 'Product $newId');
                controller.addProduct(_product, newId);
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: _buildListProduct(),
    );
  }

  Widget _buildListProduct() {
    return ListView.separated(
      itemCount: controller.products.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration:
                            InputDecoration(hintText: 'Thay đổi số lượng...'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            controller.products[index]
                              ..amount = parseNumber()
                              ..update();
                            Navigator.pop(context);
                            controller.update();
                          },
                          child: Text('OK'))
                    ],
                  ),
                );
              },
            );
          },
          trailing: Text('Số lượng = ${controller.products[index].amount}'),
          title: Text('Tên sản phẩm: ${controller.products[index].name}'),
          subtitle: Text('Trạng thái = ${controller.products[index].type}'),
        );
      },
    );
  }

  int parseNumber() {
    try {
      return int.parse(_textController.text);
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
