import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/core/constants/app_colors.dart';
import 'package:libre_skill_tree/core/widget/option_tile.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';
import 'package:libre_skill_tree/features/skill_tree/graphx/skill_tree_graphics.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum Level { root, rookie, veteran, master }

class SkillTreeScreen extends StatefulWidget {
  final SkillTreeRepository repository;
  const SkillTreeScreen({super.key, required this.repository});

  @override
  State<SkillTreeScreen> createState() => _SkillTreeScreenState();
}

class _SkillTreeScreenState extends State<SkillTreeScreen> {
  SkillTreeModel? activeTree;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() async {
    final trees = await widget.repository.getAllTrees();
    if (trees.isNotEmpty) {
      setState(() => activeTree = trees.first);
    }
  }

  void _createNewTree() async {
    final newTree = SkillTreeModel(
      name: "SkillTree1",
      nodes: [
        SkillNodeModel(
          id: "root",
          title: "New Goal",
          x: 0,
          y: 0,
          level: 0,
          locked: false,
        ),
      ],
      edges: [],
    );
    await widget.repository.saveTree(newTree);
    setState(() => activeTree = newTree);
  }

  Future<void> _exportJson() async {
    if (activeTree == null) return;
    final jsonStr = jsonEncode(activeTree!.toJson());
    //Clipboard.setData(ClipboardData(text: jsonStr));

    debugPrint(jsonStr);
    await Permission.storage.request();
    final directory = await getDownloadsDirectory();
    final path = directory!.path;
    final file = File('$path/Libre_SkillTree.json');
    await file.writeAsString(jsonStr);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 6),
          content: Text(
            "JSON copied to clipboard \n file at location: \n $path",
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
    }
  }

  void _realignTree() async {
    debugPrint("calling realignTree");
    if (activeTree == null || activeTree!.nodes.isEmpty) return;

    double getSubtreeWidth(String parentId) {
      //extracting all the edges having parentId root
      final children = activeTree!.edges
          .where((e) => e.fromNodeId == parentId)
          .toList();
      if (children.isEmpty) return 120.0; // Base width for a single node

      double totalWidth = 0;
      for (var edge in children) {
        totalWidth += getSubtreeWidth(edge.toNodeId);
      }
      return totalWidth;
    }

    void positionNodes(String nodeId, double leftBoundary, double y) {
      final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);
      final childrenEdges = activeTree!.edges
          .where((e) => e.fromNodeId == nodeId)
          .toList();

      double subtreeWidth = getSubtreeWidth(nodeId);
      node.x = leftBoundary + (subtreeWidth / 2);
      node.y = y;

      double currentLeft = leftBoundary;
      for (var edge in childrenEdges) {
        double childWidth = getSubtreeWidth(edge.toNodeId);
        positionNodes(edge.toNodeId, currentLeft, y + 150);
        currentLeft += childWidth;
      }
    }

    // 3. Execute realignment
    // We treat the root as the center of its own universe
    double rootWidth = getSubtreeWidth("root");
    positionNodes("root", -(rootWidth / 2), 0);

    // 4. Save the calculated positions back to Isar
    await widget.repository.saveTree(activeTree!);
    _refreshTree();
  }

  void _addConnectedNode(String parentId) async {
    if (activeTree == null) return;
    final newId = DateTime.now().millisecondsSinceEpoch.toString();

    final newNode = SkillNodeModel(
      id: newId,
      title: "New Node",
      x: 0,
      y: 0,
      locked: true,
    );

    activeTree!.nodes = List<SkillNodeModel>.from(activeTree!.nodes)
      ..add(newNode);
    activeTree!.edges = List<SkillEdgeModel>.from(activeTree!.edges)
      ..add(SkillEdgeModel(fromNodeId: parentId, toNodeId: newId));

    await widget.repository.saveTree(activeTree!);
    _realignTree();
  }

  Future<dynamic> _renameNode(String nodeId, BuildContext context) {
    final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);
    final controller = TextEditingController(text: node.title);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Rename Node"),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: "Enter node name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              node.title = controller.text;
              await widget.repository.saveTree(activeTree!);
              _refreshTree();
              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteNode(String nodeId) async {
    if (nodeId == "") return;
    if (nodeId == "root") {
      widget.repository.deleteTree(activeTree!.name);
      setState(() => activeTree = null);
      return;
    }
    final List<String> deletedNodes = [nodeId];
    for (var edge in activeTree!.edges) {
      if (edge.fromNodeId == nodeId && edge.toNodeId != '') {
        deletedNodes.add(edge.toNodeId);
        _deleteNode(edge.toNodeId);
      }
    }

    activeTree!.nodes = activeTree!.nodes
        .where((n) => deletedNodes.contains(n.id) != true)
        .toList();

    activeTree!.edges = activeTree!.edges
        .where((e) => e.fromNodeId != nodeId && e.toNodeId != nodeId)
        .toList();

    await widget.repository.saveTree(activeTree!);
  }

  void _editLevel(String nodeId, Level level) async {
    final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);

    switch (level) {
      case Level.rookie:
        node.level = 1;
        break;
      case Level.veteran:
        node.level = 2;
        break;
      case Level.master:
        node.level = 3;
        break;
      default:
        node.level = 0;
    }

    // Unlock logic (example: if parent is leveled up, children could unlock)
    // For now, we just save the level
    await widget.repository.saveTree(activeTree!);
    _refreshTree();
  }

  void _refreshTree() async {
    final updatedTrees = await widget.repository.getAllTrees();
    setState(() {
      activeTree = updatedTrees.firstWhere((t) => t.id == activeTree?.id);
    });
  }

  void _onNodeTapped(BuildContext context, String nodeId) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text("Add Child"),
            onTap: () {
              Navigator.pop(context);
              _addConnectedNode(nodeId);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text("Rename"),
            onTap: () async {
              Navigator.pop(context);
              await _renameNode(nodeId, context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: const Text("Level Up"),
            onTap: () async {
              Navigator.pop(context);
              await _showDialog(context, nodeId);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text("Delete"),
            onTap: () {
              Navigator.pop(context);
              _deleteNode(nodeId);
              _realignTree();
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, String nodeId) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Center(
            child: Text(
              "Select Level",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.appBackground,
              ),
            ),
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                _editLevel(nodeId, Level.root);
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.rootRing, title: "Root"),
            ),
            SimpleDialogOption(
              onPressed: () {
                _editLevel(nodeId, Level.rookie);
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.rookieRing, title: "Rookie"),
            ),
            SimpleDialogOption(
              onPressed: () {
                _editLevel(nodeId, Level.veteran);
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.veteranRing, title: "Veteran"),
            ),
            SimpleDialogOption(
              onPressed: () {
                _editLevel(nodeId, Level.master);
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.masterRing, title: "Master"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          backgroundColor: AppColors.appBackground,
          foregroundColor: Colors.white,
          title: Text(
            "Libre SkillTree",
            style: TextStyle(
              letterSpacing: 3,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _exportJson,
              icon: const Icon(Icons.download),
            ),
          ],
        ),
        body: activeTree == null
            ? Center(
                child: ElevatedButton(
                  onPressed: _createNewTree,
                  child: const Text(
                    "Start New Tree",
                    style: TextStyle(
                      color: AppColors.appBackground,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : InteractiveViewer(
                maxScale: 10,
                child: Transform.scale(
                  scale: 0.15,
                  child: SceneBuilderWidget(
                    autoSize: true,
                    builder: () => SceneController(
                      front: SkillTreeScene(
                        activeTree!,
                        onNodeTap: (id) => _onNodeTapped(context, id),
                      ),
                    ),
                    key: ValueKey(
                      'tree_${activeTree!.id}_'
                      'nodes_${activeTree!.nodes.length}_'
                      'lvls_${activeTree!.nodes.fold(0, (p, n) => p + n.level)}',
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
