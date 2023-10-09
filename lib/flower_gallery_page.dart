import 'package:flower_gallery/flower_gallery_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlowerGalleryPage extends StatelessWidget {
  FlowerGalleryPage({super.key});
  final controller = Get.put(FlowerGalleryPageController());

  void showAppDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Widget child = Stack(
          clipBehavior: Clip.none,
          children: [
            InteractiveViewer(
              transformationController: controller.transformationController,
              minScale: 1,
              maxScale: 5,
              child: Obx(() {
                final index = controller.imgIdx.value;
                return Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              "assets/$index.jpeg",
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Failed to load Image",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            _buildZoomIconAndCloseIcon(context),
            Obx(() {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                left: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.withOpacity(0.4),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.resetInterActiveViewer();
                      controller.onArrowTap(isLeftArrow: true);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_left,
                      color: controller.imgIdx.value == 0
                          ? Colors.grey
                          : Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              );
            }),
            Obx(() {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.35,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple.withOpacity(0.4),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.resetInterActiveViewer();
                      controller.onArrowTap(isLeftArrow: false);
                    },
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: controller.imgIdx.value == 14
                          ? Colors.grey
                          : Colors.black,
                      size: 50,
                    ),
                  ),
                ),
              );
            }),
          ],
        );

        Obx(() {
          if (controller.corruptImgList[controller.imgIdx.value]) {
            child = const Center(
              child: Text("Failed to load image"),
            );
          }
          return const SizedBox.shrink();
        });

        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildZoomIconAndCloseIcon(BuildContext context) {
    return Positioned(
      top: 5,
      right: 10,
      child: Container(
        width: 150,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.purple.withOpacity(0.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              final isZoomInAllowed = controller.isZoomInAllowed.value;
              final isZoomOutAllowed = controller.isZoomOutAllowed.value;
              return Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.onZoomIn,
                    child: Icon(
                      Icons.zoom_in,
                      size: 40,
                      color: isZoomInAllowed ? Colors.black : Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: controller.onZoomOut,
                    child: Icon(
                      Icons.zoom_out,
                      size: 40,
                      color: isZoomOutAllowed ? Colors.black : Colors.grey,
                    ),
                  ),
                ],
              );
            }),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                size: 40,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ajay's Flower Gallery",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 128, 122, 122),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Wrap(
                runSpacing: 40,
                spacing: 40,
                children: [
                  ...List.generate(
                    15,
                    (index) {
                      return ClipOval(
                          child: SizedBox.fromSize(
                        size: const Size.fromRadius(150),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (controller.corruptImgList[index]) {
                              return;
                            }
                            controller.imgIdx.value = index;
                            controller.resetInterActiveViewer();
                            showAppDialog(context);
                          },
                          child: Image.asset(
                            "assets/$index.jpeg",
                            width: 300,
                            height: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              controller.corruptImgList[index] = true;
                              return Container(
                                width: 300,
                                height: 300,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Failed to load Image",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
