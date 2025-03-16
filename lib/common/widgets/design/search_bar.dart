import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:OtakuWrdd/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:OtakuWrdd/ui/main/controllers/search_controller.dart';

class CustomSearchContainer extends StatelessWidget {
  const CustomSearchContainer({
    super.key,
    required this.text,
    this.icon = Icons.search,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.onChanged,
    this.autofocus = false,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.padding = const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder, autofocus, readOnly;
  final VoidCallback? onTap;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final searchController = Get.find<CustomSearchController>();

    return GestureDetector(
      onTap: () {
        searchController.focusNode.requestFocus();
        onTap?.call();
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 30,
                padding: EdgeInsets.all(ConstantSizes.sm - 3),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(
                    ConstantSizes.cardRadiusMd,
                  ),
                  border:
                      showBorder
                          ? Border.all(color: ConstantColors.grey)
                          : null,
                ),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      color: ConstantColors.white.withOpacity(0.9),
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        controller:
                            controller ?? searchController.textController,
                        focusNode: focusNode ?? searchController.focusNode,
                        readOnly: readOnly,
                        autofocus: autofocus,
                        cursorColor: Colors.white,
                        style: GoogleFonts.roboto(
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.5,
                        ),
                        decoration: InputDecoration(
                          hintText: text,
                          hintStyle: GoogleFonts.roboto(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w400,
                            fontSize: 14.5,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        onChanged: onChanged,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              if (!searchController.isFocused.value) {
                return const SizedBox(width: 0);
              }
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                width: searchController.isFocused.value ? 70 : 0,
                child: Transform.translate(
                  offset: Offset(searchController.isFocused.value ? 0 : 20, 0),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: searchController.isFocused.value ? 1 : 0,
                    child: Row(
                      children: [
                        const SizedBox(width: 15),
                        GestureDetector(
                          onTap: searchController.handleCancel,
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.roboto(
                              color: Colors.white.withOpacity(0.8),
                              fontSize: 16.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
