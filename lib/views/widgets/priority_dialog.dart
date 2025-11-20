import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/priority_item_widget.dart';

class PriorityDialog extends StatefulWidget {
  const PriorityDialog({super.key, required this.onTap});
  final void Function(int) onTap;

  @override
  State<PriorityDialog> createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  List<int> priorityList = List.generate(10, (index) => index + 1);
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: AlertDialog(
        backgroundColor: Color(0xffffffff),
        title: Column(
          children: [
            Text(
              'Task Priority',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xDE24252C),
              ),
            ),
            Divider(color: Color(0xff979797), thickness: 1),
          ],
        ),
        content: Wrap(
          spacing: 16,
          runSpacing: 12,
          children: priorityList
              .map(
                (index) => PriorityItemWidget(
                  index: index,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      widget.onTap(index);
                    });
                  },
                ),
              )
              .toList(),
        ),
        actions: [
          SizedBox(
            height: 48,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffFFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5F33E1),
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5F33E1),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
