import 'package:flower_gallery/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlowerGalleryPageController extends GetxController {
  double minScale = 1.0;
  double maxScale = 1.0;
  final isZoomInAllowed = true.obs;
  final isZoomOutAllowed = false.obs;
  final imgIdx = 0.obs;
  final corruptImgList = <bool>[];

  final transformationController = TransformationController();

  @override
  void onInit() {
    super.onInit();
    for (int i = 0; i < 15; i++) {
      corruptImgList.add(false);
    }
  }

  void onZoomIn() {
    if (minScale >= 4.5) {
      isZoomInAllowed.value = false;
      AppToast.showAppToast("Can't zoom in further");
      return;
    }
    minScale += 0.1;
    transformationController.value =
        Matrix4.diagonal3Values(minScale, minScale, 0.1);

    maxScale = minScale;
    isZoomOutAllowed.value = true;
  }

  void onZoomOut() {
    if (maxScale == 1.0) {
      isZoomOutAllowed.value = false;
      AppToast.showAppToast("Can't zoom out further");
      return;
    }

    maxScale -= 0.1;
    transformationController.value =
        Matrix4.diagonal3Values(maxScale, maxScale, 0.1);

    minScale = maxScale;
    isZoomInAllowed.value = true;
  }

  void onArrowTap({required bool isLeftArrow}) {
    if (isLeftArrow) {
      if (imgIdx.value > 0) {
        imgIdx.value--;
        return;
      }
    } else {
      if (imgIdx.value < 14) {
        imgIdx.value++;
        return;
      }
    }
  }

  void resetInterActiveViewer() {
    transformationController.value = Matrix4.identity();
    minScale = 1.0;
    maxScale = 1.0;
    isZoomOutAllowed.value = false;
    isZoomInAllowed.value = true;
  }
}
