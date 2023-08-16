import 'package:flutter/material.dart';

import 'constants.dart';
class InstructionVideo extends StatelessWidget {
  final String text;

  const InstructionVideo(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    List<String> lines = text.split('\n');

    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lines.map((line) {
          return customText20(title:
            line,
            color: kBlackText.withOpacity(0.9),
          );
        }).toList(),
      ),
    );
  }

  Widget customText20({required String title, required Color color}) {
    return Text(title,
        textAlign: TextAlign.start,

        softWrap: true,
        style: TextStyle(color: color, fontSize: 14, fontFamily: 'DinMedium'));
  }
}

