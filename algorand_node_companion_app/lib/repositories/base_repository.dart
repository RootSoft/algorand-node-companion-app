/// A generic repository interface that defines the core functionality that our
/// repositories will have and can be implemented by any object of type T.
///
/// Defining this as an interface allows for it to easily be mocked when testing the app.
///
/// More information:
/// - https://levelup.gitconnected.com/a-practical-approach-to-caching-remote-data-using-hive-in-flutter-b2bcff5bfdef
/// - https://techpotatoes.com/2020/04/06/flutter-development-series-part-3-using-databases-in-flutter/
abstract class Repository<T> {
  Future<void> open(String boxName);
  Future<void> close();
  Future<int?> add(T entity);
  Future<void> store(dynamic key, T entity);
  Future<Iterable<int>?> storeList(Iterable<T> entities);
  T? findById(dynamic id);
  T? first();
  Future<void> remove(dynamic id);
  Future<void> clear();
  Iterable<T> all();
  int count();
}

abstract class BaseRepository<T> implements Repository<T> {
  @override
  Future<void> open(String boxName) async {}

  @override
  Future<void> close() async {}

  @override
  int count() {
    return 0;
  }

  @override
  Iterable<T> all() {
    return [];
  }

  @override
  Future<void> clear() async {
    throw UnimplementedError('.clear method not implemented.');
  }

  @override
  Future<void> remove(id) async {
    throw UnimplementedError('.remove method not implemented.');
  }

  @override
  T? first() {
    throw UnimplementedError('.first method not implemented.');
  }

  @override
  T? findById(dynamic id) {
    throw UnimplementedError('.findById method not implemented.');
  }

  @override
  Future<Iterable<int>?> storeList(Iterable<T> entities) async {
    throw UnimplementedError('.storeList method not implemented.');
  }

  @override
  Future<void> store(dynamic key, T entity) async {
    throw UnimplementedError('.store method not implemented.');
  }

  @override
  Future<int?> add(T entity) async {
    throw UnimplementedError('.store method not implemented.');
  }
}
