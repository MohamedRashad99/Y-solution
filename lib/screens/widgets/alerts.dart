import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:edge_alerts/edge_alerts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

abstract class Alert {
  /// * show success alert
  static void success(Object msg, {String desc = ''}) {
    edgeAlert(
      Get.context!,
      duration: 2,
      title: msg.toString(),
      icon: FontAwesomeIcons.check,
      backgroundColor: kDarkPrimaryColor,
      description: desc,
    );
  }

  /// * show error alert
  static void error(Object msg, {String desc = ''}) {
    edgeAlert(
      Get.context!,
      title: msg.toString(),
      duration: 4,
      icon: FontAwesomeIcons.times,
      backgroundColor: const Color(0xFFDC3130),
      description: desc,
    );
  }

  /// * show error alert
  static void soon() {
    edgeAlert(
      Get.context!,
      title: 'قريبا في التحديثات',
      icon: Icons.new_releases_outlined,
      backgroundColor: Get.context!.iconColor,
    );
  }
}
