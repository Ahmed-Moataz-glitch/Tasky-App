import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_assets.dart';

class PriorityItemWidget extends StatelessWidget {
  const PriorityItemWidget({super.key, required this.index, required this.onTap, required this.isSelected});
  final int index;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xff5F33E1) : null,
          border: Border.all(color: Color(0xff6E6A7C)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          spacing: 5,
          children: [
            Image.asset(
              AppAssets.priorityIcon,
              width: 24,
              height: 24,
              fit: BoxFit.contain,
              color: isSelected ? Color(0xffffffff) : null,
            ),
            Text(
              '$index',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isSelected ? Color(0xDEFFFFFF) : Color(0xDE24252C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
