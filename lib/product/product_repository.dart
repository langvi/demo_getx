import 'package:demo_getx/main.dart';
import 'package:demo_getx/model/product.dart';

class ProductRepository {
  Future<List<Product>> getProducts(int pageIndex) async {
    var data = await database!.rawQuery(
        'select ${Product.columnId}, ${Product.columnName}, ${Product.columnAmount}, ${Product.columnType} from ${Product.nameTable} limit 10 offset $pageIndex');
    return List<Product>.from(data.map((element) => Product.fromJson(element)));
  }
}
