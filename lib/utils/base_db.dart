abstract class BaseSqlite {
  Future<int> insert();
  Future<List<Map<String, dynamic>>> queryById();
  Future<int> update();
  Map<String, dynamic> toJson();
  Future<int> delete();
}
