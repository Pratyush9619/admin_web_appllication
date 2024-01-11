import 'package:flutter/material.dart';
import '../style.dart';

Widget cards(BuildContext context, String desc, String img, int index) {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: blue,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            width: 220,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image:
                    DecorationImage(image: NetworkImage(img), fit: BoxFit.fill),
              ),
            ),

            //Image.asset(img, fit: BoxFit.cover),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              desc,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    ),
  );
}
