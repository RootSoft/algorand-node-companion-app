import 'package:algorand_node_companion_app/database/entities.dart';
import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:hive/hive.dart';

class NodeBox extends BaseRepository<Node> {
  final Box<NodeEntity> box;

  NodeBox({required this.box});

  @override
  Future<int?> add(Node node) async {
    if (this.boxIsClosed) return null;

    //Write operations are asynchronous but the new values are immediately available
    return await box.add(NodeEntity.node(node));
  }

  @override
  Future<void> remove(id) async {
    if (this.boxIsClosed) return null;

    return await box.delete(id);
  }

  @override
  Node? findById(id) {
    //Write operations are asynchronous but the new values are immediately available
    return box.get(id)?.unwrap();
  }

  @override
  Node? first() {
    if (this.boxIsClosed) return null;

    //Read operations for normal boxes are synchronous
    try {
      return box.getAt(0)?.unwrap();
    } on RangeError {
      return null;
    }
  }

  @override
  Future<void> store(key, Node node) async {
    if (this.boxIsClosed) return null;

    //Write operations are asynchronous but the new values are immediately available
    return await box.put(key, NodeEntity.node(node));
  }

  @override
  Future<void> clear() async {
    await box.clear();
  }

  @override
  Iterable<Node> all() {
    return box.values.map((entity) => entity.unwrap()).toList();
  }

  Future<Node?> save(Node node) async {
    if (this.boxIsClosed) return null;
    final entity = box.get(node.key);
    if (entity == null) {
      final key = await add(node);
      return node.copyWith(key: key);
    }

    entity.merge(node);
    entity.save();
    return node.copyWith(key: entity.key);
  }

  bool get boxIsOpen => this.box.isOpen;
  bool get boxIsClosed => !(this.box.isOpen);
}
