import 'package:OtakuWrdd/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class NewsFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Function(bool) onSelected;

  const NewsFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.black.withOpacity(0.5),
      selectedColor: ConstantColors.secondary.withOpacity(0.3),
      checkmarkColor: ConstantColors.secondary,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.white.withOpacity(0.7),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: selected ? ConstantColors.secondary : Colors.transparent,
        ),
      ),
    );
  }
}
