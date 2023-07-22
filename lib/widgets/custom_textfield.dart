import 'package:flutter/material.dart';

import '../style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  const CustomTextField({super.key, required this.controller});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      child: TextField(
        readOnly: true,
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: blue, width: 1.0, style: BorderStyle.solid),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            )),
        maxLines: 1,
        textInputAction: TextInputAction.done,
        minLines: 1,
        autofocus: false,
        // textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 13),
      ),
    );
  }
}
