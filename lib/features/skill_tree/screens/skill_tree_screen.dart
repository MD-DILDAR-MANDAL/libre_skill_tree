import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/features/skill_tree/data/skill_tree_model.dart';
import 'package:libre_skill_tree/features/skill_tree/graphx/skill_tree_graphics.dart';
import 'package:libre_skill_tree/features/skill_tree/repository/skill_tree_repository.dart';

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
      name: "New Skill Tree",
      nodes: [
        SkillNodeModel(
          id: "root",
          title: "New Goal",
          x: 0,
          y: 0,
          locked: false,
        ),
      ],
      edges: [],
    );
    await widget.repository.saveTree(newTree);
    setState(() => activeTree = newTree);
  }

  void _exportJson() {
    if (activeTree == null) return;
    final jsonStr = jsonEncode(activeTree!.toJson());
    debugPrint(jsonStr);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("JSON copied to log")));
  }

  void _realignTree() async {
    if (activeTree == null || activeTree!.nodes.isEmpty) return;

    // 1. Helper to calculate how much total horizontal space a node needs
    double getSubtreeWidth(String parentId) {
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

    // 2. Recursive function to position nodes
    void positionNodes(String nodeId, double leftBoundary, double y) {
      final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);
      final childrenEdges = activeTree!.edges
          .where((e) => e.fromNodeId == nodeId)
          .toList();

      double subtreeWidth = getSubtreeWidth(nodeId);
      // Center the node within its allocated subtree width
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

  void _renameNode(String nodeId) {
    final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);
    final controller = TextEditingController(text: node.title);

    showDialog(
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
              Navigator.pop(context);
              _refreshTree();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _deleteNode(String nodeId) async {
    if (nodeId == "root") return; // Safety check

    activeTree!.nodes = activeTree!.nodes.where((n) => n.id != nodeId).toList();
    activeTree!.edges = activeTree!.edges
        .where((e) => e.fromNodeId != nodeId && e.toNodeId != nodeId)
        .toList();

    await widget.repository.saveTree(activeTree!);
    _realignTree(); // Added this to fix layout after deletion
  }

  void _editLevel(String nodeId) async {
    final node = activeTree!.nodes.firstWhere((n) => n.id == nodeId);

    // Increment level or reset if max reached
    node.level = (node.level + 1) % (node.maxLevel + 1);

    // Unlock logic (example: if parent is leveled up, children could unlock)
    // For now, we just save the level
    await widget.repository.saveTree(activeTree!);
    _refreshTree();
  }

  // Helper to ensure state is fresh and GraphX triggers a rebuild
  void _refreshTree() async {
    final updatedTrees = await widget.repository.getAllTrees();
    setState(() {
      // Find the tree we were just editing by ID
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
            onTap: () {
              Navigator.pop(context);
              _renameNode(nodeId);
            },
          ),
          ListTile(
            leading: const Icon(Icons.upgrade),
            title: const Text("Level Up"),
            onTap: () {
              Navigator.pop(context);
              _editLevel(nodeId);
            },
          ),
          if (nodeId != "root")
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text("Delete"),
              onTap: () {
                Navigator.pop(context);
                _deleteNode(nodeId);
              },
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Skill Tree"),
        actions: [
          IconButton(onPressed: _exportJson, icon: const Icon(Icons.download)),
        ],
      ),
      body: activeTree == null
          ? Center(
              child: ElevatedButton(
                onPressed: _createNewTree,
                child: const Text("Start New Tree"),
              ),
            )
          : SceneBuilderWidget(
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
    );
  }
}
