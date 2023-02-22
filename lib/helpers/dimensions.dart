import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;
  static double size30 = (screenHeight * screenWidth * 30) / (800 * 360);
  static double size8 = (screenHeight * screenWidth * 8) / (800 * 360);
  static double height100 = (screenHeight * 100) / 800;
  static double height10 = (screenHeight * 10) / 800;
  static double height8 = (screenHeight * 8) / 800;
  static double height9 = (screenHeight * 9) / 800;

  static double height(double x) {
    return (screenHeight * x) / 800;
  }

  static double width(double x) {
    return (screenWidth * x) / 360;
  }

  static double size(double x) {
    return (screenHeight * screenWidth * x) / (800 * 360);
  }
}
