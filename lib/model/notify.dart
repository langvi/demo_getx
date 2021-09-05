import 'package:demo_getx/main.dart';
import 'package:demo_getx/utils/base_db.dart';

class Notify extends BaseSqlite {
  static final String nameTable = 'notify';
  static final String columnId = 'id';
  static final String columnTitle = 'title';
  static final String columnStatus = 'status';
  int id;
  String title;
  int status;
  Notify({
    required this.title,
    required this.id,
    this.status = 1,
  });
  @override
  Map<String, dynamic> toJson() {
    return {'$columnId': id, '$columnTitle': title, '$columnStatus': status};
  }

  factory Notify.fromMap(Map<String, dynamic> map) {
    return Notify(id: map['id'], title: map['title'], status: map['status']);
  }

  @override
  Future<int> delete() {
    return database!.delete(nameTable, where: '$columnId = ?', whereArgs: [id]);
  }

  @override
  Future<int> insert() async {
    print('start insert noti....');
    return await database!.insert(nameTable, toJson());
  }

  @override
  Future<List<Map<String, dynamic>>> queryById() async {
    return await database!.query(nameTable,
        where: '$columnId = ?',
        whereArgs: [id],
        columns: [columnTitle, columnStatus]);
  }

  @override
  Future<int> update() async {
    return await database!
        .update(nameTable, toJson(), where: '$columnId = ?', whereArgs: [id]);
  }
}

abstract class DataLocal {
  late int id;
  DataLocal(this.id);
  Map<String, dynamic> toJson();
}
