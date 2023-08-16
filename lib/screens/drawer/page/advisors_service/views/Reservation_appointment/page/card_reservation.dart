import 'package:flutter/material.dart';
import 'package:tal3thoom/config/custom_shared_prefs.dart';
import 'card_item.dart';

class ReservationsCard extends StatelessWidget {
  final String specialistName;
  final String sessionDate;
  final String start;
  final String end;
  final VoidCallback onTap;
  final Widget button;

   ReservationsCard(
      {Key? key,
      required this.specialistName,
      required this.sessionDate,
      required this.start,
      required this.end,

      required this.onTap, required this.button})
      : super(key: key);

   final bool _isAvailable = Prefs.getBool("isAvailable");


  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    //  double width = MediaQuery.of(context).size.width;
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CardItems(title: "المتخصص", subTitle: specialistName),
        CardItems(title: "تاريخ الجلسة", subTitle: sessionDate),
        CardItems(title: "وقت البداية", subTitle: start),
        CardItems(title: "وقت النهاية", subTitle: end),
        button,

        // _isAvailable != null ? MediaButton(
        //   onPressed: onTap,
        //
        //
        //   color: kButtonGreenDark,
        //   title: "حجز جلسة",
        // ):const CircularProgressIndicator(),


      ],
    );
  }
}
