import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/core/constants/app_colors.dart';
import 'package:libre_skill_tree/core/widget/option_tile.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_bloc.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_event.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_state.dart';
import 'package:libre_skill_tree/features/skill_tree/graphx/skill_tree_graphics.dart';
import 'package:libre_skill_tree/features/skill_tree/models/skill_tree_model.dart';
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
    context.read<SkillTreeBloc>().add(LoadInitialTreeData());
  }

  Future<void> _exportJson() async {
    SkillTreeState state = BlocProvider.of<SkillTreeBloc>(context).state;

    if (state.activeTree == null) return;
    final jsonStr = jsonEncode(state.activeTree!.toJson());
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

  Future<dynamic> _renameNode(String nodeId, BuildContext context) {
    final state = context.read<SkillTreeBloc>().state;
    final node = state.activeTree!.nodes.firstWhere((n) => n.id == nodeId);
    final controller = TextEditingController(text: node.title);

    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(
          child: const Text(
            "Rename Node",
            style: TextStyle(
              color: AppColors.appBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
            onPressed: () {
              // Dispatch the Bloc Event
              context.read<SkillTreeBloc>().add(
                RenameNode(nodeId, controller.text),
              );
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _onNodeTapped(BuildContext context, String nodeId) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text(
                "Add Child",
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<SkillTreeBloc>().add(AddConnectedNode(nodeId));
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(
                "Rename",
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _renameNode(nodeId, context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.upgrade),
              title: const Text(
                "Level Up",
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                await _showDialog(context, nodeId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                "Delete",
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                context.read<SkillTreeBloc>().add(DeleteNode(nodeId));
              },
            ),
          ],
        ),
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
                context.read<SkillTreeBloc>().add(
                  EditLevel(nodeId, Level.root),
                );
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.rootRing, title: "Root"),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.read<SkillTreeBloc>().add(
                  EditLevel(nodeId, Level.rookie),
                );

                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.rookieRing, title: "Rookie"),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.read<SkillTreeBloc>().add(
                  EditLevel(nodeId, Level.veteran),
                );
                Navigator.pop(context);
              },
              child: OptionTile(color: AppColors.veteranRing, title: "Veteran"),
            ),
            SimpleDialogOption(
              onPressed: () {
                context.read<SkillTreeBloc>().add(
                  EditLevel(nodeId, Level.master),
                );
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
        body: BlocBuilder<SkillTreeBloc, SkillTreeState>(
          builder: (context, state) {
            return state.activeTree == null
                ? Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<SkillTreeBloc>().add(CreateNewTree()),
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
                : SceneBuilderWidget(
                    autoSize: true,
                    builder: () => SceneController(
                      front: SkillTreeScene(
                        state.activeTree!,
                        onNodeTap: (id) => _onNodeTapped(context, id),
                        enableZoom: false,
                        initialCameraScale: 0.6,
                      ),
                    ),
                    key: ValueKey(
                      'tree_${state.activeTree!.id}_'
                      'nodes_${state.activeTree!.nodes.length}_'
                      'lvls_${state.activeTree!.nodes.fold(0, (p, n) => p + n.level)}_'
                      'hash_${state.activeTree!.nodes.map((n) => n.title).join().hashCode}',
                    ),
                  );
          },
        ),
      ),
    );
  }
}
