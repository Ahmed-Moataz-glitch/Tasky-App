import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/app_dialog_widget.dart';
import 'package:tasky/views/widgets/firebase_result.dart';
import 'package:tasky/views/widgets/firebase_task.dart';
import 'package:tasky/views/widgets/priority_dialog.dart';
import 'package:tasky/views/widgets/text_form_field_widget.dart';
import 'package:tasky/views/widgets/validator.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({super.key});

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xDE24252C),
              ),
            ),
            SizedBox(height: 16),
            TextFormFieldWidget(
              controller: titleController,
              validator: Validator.validateName,
              hintText: 'Do math homework',
            ),
            SizedBox(height: 12),
            TextFormFieldWidget(
              controller: descriptionController,
              validator: Validator.validateName,
              hintText: 'Description',
            ),
            SizedBox(height: 20),
            Row(
              children: [
                icon(
                  iconPath: AppAssets.dateIcon,
                  onPressed: () async {
                    selectedDate =
                        await DatePicker.dateOnPressed(context) ?? selectedDate;
                  },
                ),
                SizedBox(width: 12),
                icon(
                  iconPath: AppAssets.priorityIcon,
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => PriorityDialog(
                        onTap: (index) {
                          selectedPriority = index;
                        },
                      ),
                    );
                  },
                ),
                Spacer(),
                icon(iconPath: AppAssets.sendIcon, onPressed: _sendOnPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget icon({required String iconPath, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(iconPath, width: 24, height: 24, fit: BoxFit.contain),
    );
  }

  void _sendOnPressed() async {
    AppDialogWidget.showLoading(context);
    final result = await FirebaseTask.addTask(
      TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        date: selectedDate,
        priority: selectedPriority,
      ),
    );
    switch (result) {
      case FirebaseSuccess<void>():
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      case FirebaseError<void>():
        Navigator.of(context).pop();
        AppDialogWidget.showError(
          context,
          errorMessage: result.message,
        );
    }
  }

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late int selectedPriority;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    selectedDate = DateTime.now();
    selectedPriority = 1;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
}

abstract class DatePicker {
  static Future<DateTime?> dateOnPressed(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
  }
}
