import 'package:flutter/material.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    super.key,
    this.color,
    required this.title,
    this.borderWidth = 3,
    this.borderRadius = 30,
  });
  final Color? color;
  final String title;
  final double borderWidth;
  final double borderRadius;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(width: widget.borderWidth),
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Center(child: Text(widget.title)),
    );
  }
}
