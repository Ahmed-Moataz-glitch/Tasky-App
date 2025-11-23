// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/firebase_task.dart';
import 'package:tasky/views/widgets/modal_bottom_sheet.dart';
import 'package:tasky/views/widgets/priority_dialog.dart';

class EditTaskPage extends StatefulWidget {
  const EditTaskPage({super.key});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  DateTime selectedDate = DateTime.now();
  int selectedPriority = 1;
  bool isDateDefault = true;
  bool isPriorityDefault = true;
  @override
  Widget build(BuildContext context) {
    var task = ModalRoute.of(context)!.settings.arguments as TaskModel;
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
                  decoration: BoxDecoration(color: Color(0x366E6A7C)),
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        task.isCompleted = !task.isCompleted!;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xff5F33E1),
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: task.isCompleted! ? Color(0xff5F33E1) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    task.title ?? '',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff24252C),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const SizedBox(width: 36),
                  Text(
                    task.description ?? '',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff6E6A7C),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28),
              Row(
                children: [
                  Image.asset(AppAssets.dateIcon, width: 24, height: 24),
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
                      selectedDate =
                          await DatePickerWidget.dateOnPressed(context) ??
                          task.date!;
                      isDateDefault = false;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE0DFE3),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      isDateDefault
                          ? '${task.date!.day}/${task.date!.month}/${task.date!.year}'
                          : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
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
                  Image.asset(AppAssets.priorityIcon, width: 24, height: 24),
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
                      await showDialog(
                        context: context,
                        builder: (context) => PriorityDialog(
                          onTap: (index) {
                            selectedPriority = index;
                          },
                        ),
                      );
                      isPriorityDefault = false;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE0DFE3),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      isPriorityDefault
                          ? '${task.priority ?? 1}'
                          : '$selectedPriority',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xDE24252C),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              GestureDetector(
                onTap: () async {
                  await FirebaseTask.deleteTask(task);
                  Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Image.asset(AppAssets.deleteIcon, width: 24, height: 24),
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
                      onPressed: () async {
                        selectedPriority = isPriorityDefault
                            ? task.priority!
                            : selectedPriority;
                        selectedDate = isDateDefault
                            ? task.date!
                            : selectedDate;
                        await FirebaseTask.updateTask(
                          TaskModel(
                            id: task.id,
                            title: task.title,
                            description: task.description,
                            date: selectedDate,
                            priority: selectedPriority,
                            isCompleted: task.isCompleted,
                          ),
                        );
                        Navigator.of(context).pop();
                        // print(task.isCompleted);
                        // print(selectedPriority);
                        // print(task.date);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5F33E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
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
