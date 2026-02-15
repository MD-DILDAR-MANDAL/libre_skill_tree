import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphx/graphx.dart';
import 'package:libre_skill_tree/core/constants/app_colors.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_bloc.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_event.dart';
import 'package:libre_skill_tree/features/skill_tree/bloc/skill_tree_state.dart';
import 'package:libre_skill_tree/features/skill_tree/graphx/skill_tree_graphics.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _shareKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    context.read<SkillTreeBloc>().add(LoadInitialTreeData());
  }

  Future<void> _shareTreeImage() async {
    try {
      RenderRepaintBoundary? boundary =
          _shareKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;

      if (boundary == null) return;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final imagePath = await File('${directory.path}/skill_tree.png').create();
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareXFiles([
        XFile(imagePath.path),
      ], text: 'Check out my Skill Tree! Download now from mandalverse_labs');
    } catch (e) {
      debugPrint("Error sharing image: $e");
    }
  }

  void _handleNodeTap(String nodeId, String nodeTitle) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.deepOrangeAccent,
        duration: const Duration(seconds: 3),
        content: Text(
          "$nodeTitle : \nGo to skilltree to edit/add/delet/level upgrade",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocBuilder<SkillTreeBloc, SkillTreeState>(
        builder: (context, state) {
          if (state.activeTree == null) {
            return const Center(
              child: Text(
                "No active tree ",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          final activeTree = state.activeTree!;
          return Stack(
            children: [
              RepaintBoundary(
                key: _shareKey,
                child: Container(
                  color: AppColors
                      .appBackground, // Ensures image has blue background
                  child: Stack(
                    children: [
                      InteractiveViewer(
                        child: SceneBuilderWidget(
                          autoSize: true,
                          builder: () => SceneController(
                            front: SkillTreeScene(
                              state.activeTree!,
                              enableZoom: true,
                              initialCameraScale: 0.25,
                              onNodeTap: (id) {
                                final node = activeTree.nodes.firstWhere(
                                  (n) => n.id == id,
                                );
                                _handleNodeTap(id, node.title);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        right: 20,
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/icons/icon.png',
                              width: 26,
                              height: 26,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.account_tree,
                                    color: Colors.amber,
                                    size: 24,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Libre SkillTree",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Oxanium',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                top: 50,
                left: 20,
                child: Text(
                  "Overview",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                top: 45,
                right: 20,
                child: IconButton(
                  onPressed: _shareTreeImage,
                  icon: const Icon(Icons.share, color: Colors.white, size: 28),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
