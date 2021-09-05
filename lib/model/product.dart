import 'package:demo_getx/main.dart';
import 'package:demo_getx/utils/base_db.dart';

class Product extends BaseSqlite {
  static final String nameTable = 'product';
  static final String columnId = 'id';
  static final String columnName = 'name';
  static final String columnAmount = 'amount';
  static final String columnType = 'type';

  final int id;
  String name;
  int amount;
  int type;
  Product({
    required this.id,
    required this.name,
    this.amount = 1,
    this.type = 0,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['$columnId'],
        name: json['$columnName'],
        amount: json['$columnAmount'],
        type: json['$columnType'] ?? 0);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      '$columnId': id,
      '$columnName': name,
      '$columnAmount': amount,
      '$columnType': type
    };
  }

  @override
  Future<int> delete() async {
    return database!.delete(nameTable, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<int> insert() async {
    print('start insert....');
    print(toJson());
    return await database!.insert(nameTable, toJson());
  }

  @override
  Future<List<Map<String, dynamic>>> queryById() async {
    return await database!.query(nameTable,
        where: '$columnId = ?',
        whereArgs: [id],
        columns: [columnName, columnType, columnAmount]);
  }

  @override
  Future<int> update() async {
    return await database!
        .update(nameTable, toJson(), where: '$columnId = ?', whereArgs: [id]);
  }
}
