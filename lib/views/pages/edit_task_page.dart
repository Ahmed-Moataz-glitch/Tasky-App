import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/modal_bottom_sheet.dart';
import 'package:tasky/views/widgets/priority_dialog.dart';

class EditTaskPage extends StatelessWidget {
  const EditTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Color(0x366E6A7C),
                  ),
                  child: Image.asset(
                    AppAssets.closeIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    value: 0,
                    groupValue: 1,
                    // activeColor: Color(0xff5F33E1),
                    fillColor: WidgetStateProperty.all(Color(0xff5F33E1)),
                  ),
                  Text(
                    'Do Math Homework',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              Text(
                'Description',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6E6A7C),
                ),
              ),
              SizedBox(height: 28),
              Row(
                children: [
                  Image.asset(
                    AppAssets.dateIcon,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Task Time :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await DatePicker.dateOnPressed(context);
                    }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x166E6A7C),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Today',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xDE24252C),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              Row(
                children: [
                  Image.asset(
                    AppAssets.priorityIcon,
                    width: 24,
                    height: 24,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Task Priority :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await showDialog(context: context, builder: (context) => PriorityDialog(
                        onTap: (index){},
                      ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0x166E6A7C),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xDE24252C),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.deleteIcon,
                      width: 24,
                      height: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Delete Task',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffFF4949),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5F33E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        'Edit Task',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
