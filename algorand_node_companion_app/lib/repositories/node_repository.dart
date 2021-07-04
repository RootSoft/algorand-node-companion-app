import 'package:nodex_companion_app/database/boxes/node_box.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/repositories/repositories.dart';
import 'package:nodex_companion_app/repositories/repository_event.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/utils/working_directory.dart';

class NodeRepository extends BaseRepository<Node> {
  final NodeBox _nodeBox;
  final WorkingDirectory _workingDirectory;

  NodeRepository({
    required NodeBox nodeBox,
  })  : this._workingDirectory = WorkingDirectory(),
        this._nodeBox = nodeBox;

  /// Check if this device has a local node installed.
  bool get hasLocalNode {
    return _workingDirectory.goal.existsSync();
  }

  @override
  Future<int?> add(Node node) {
    return _nodeBox.add(node);
  }

  @override
  Future<void> remove(id) async {
    return _nodeBox.remove(id);
  }

  @override
  Node? findById(id) {
    return _nodeBox.findById(id);
  }

  Future<Node?> save(Node node) {
    return _nodeBox.save(node);
  }

  @override
  Iterable<Node> all() {
    // Get the list of stored nodes
    final nodes = _nodeBox.all().toList();

    return nodes;
  }

  Stream<RepositoryEvent<Node>> get repositoryChanges =>
      _nodeBox.box.watch().map(convert);

  RepositoryEvent<Node> convert(BoxEvent event) {
    if (event.deleted) {
      return RepositoryEvent<Node>(key: event.key, event: EntityEvent.DELETED);
    }

    final node = findById(event.key);

    return RepositoryEvent<Node>(
      key: event.key,
      event: EntityEvent.SAVED,
      entity: node,
    );
  }
}
