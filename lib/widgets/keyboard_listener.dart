import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class keyBoardArrow extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  Scaffold myScaffold;
  keyBoardArrow(
      {super.key, required this.scrollController, required this.myScaffold});

  @override
  State<keyBoardArrow> createState() => _keyBoardArrowState();
}

class _keyBoardArrowState extends State<keyBoardArrow> {
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          if (widget.scrollController.offset <
              widget.scrollController.position.maxScrollExtent) {
            widget.scrollController.jumpTo(widget.scrollController.offset + 50);
          }
        }
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          if (widget.scrollController.offset >
              widget.scrollController.position.minScrollExtent) {
            widget.scrollController.jumpTo(widget.scrollController.offset - 50);
          }
        }
      },
      child: widget.myScaffold,
    );
  }
}
