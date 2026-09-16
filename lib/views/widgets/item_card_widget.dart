import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/app_colors.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({super.key, required this.title, required this.date, required this.priority, required this.isCompleted, required this.onTap});
  final String title;
  final DateTime date;
  final int priority;
  final bool isCompleted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.secondary, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primary,
                      width: 2,
                    ),
                  ),
                ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted ? AppColors.primary : null,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.semiBlack,
                  ),
                ),
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              margin: EdgeInsets.only(right: 10, top: 8),
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary, width: 1.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                spacing: 5,
                children: [
                  Image.asset(
                    AppAssets.priorityIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    priority.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.semiBlack,
                    ),
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
