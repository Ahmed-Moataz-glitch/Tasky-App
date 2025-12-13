// ignore_for_file: use_build_context_synchronously

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/app_dialog_widget.dart';
import 'package:tasky/views/widgets/app_routes.dart';
import 'package:tasky/views/widgets/firebase_result.dart';
import 'package:tasky/views/widgets/firebase_task.dart';
import 'package:tasky/views/widgets/item_card_widget.dart';
import 'package:tasky/views/widgets/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TaskModel> tasks = [];
  DateTime _selectedValue = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTasks(_selectedValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff24252C),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: _addOnPressed,
        child: Image.asset(AppAssets.addIcon, width: 30, height: 30),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(AppAssets.taskyIcon, width: 78, height: 28),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(AppRoutes.loginPage);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          AppAssets.logoutIcon,
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xffFF4949),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              DatePicker(
                DateTime.now(),
                height: 100,
                initialSelectedDate: DateTime.now(),
                selectionColor: Color(0xff5F33E1),
                selectedTextColor: Color(0xffffffff),
                onDateChange: (date) async {
                  setState(() {
                    _selectedValue = date;
                    _getTasks(date);
                  });
                },
              ),
              const SizedBox(height: 12),
              isLoading ? _loadingState() : _listOfTasks(),
            ],
          ),
        ),
      ),
    );
  }

  void _addOnPressed() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => ModalBottomSheet(),
    ).whenComplete(() async {
      await _getTasks(_selectedValue);
    });
  }

  Future<void> _getTasks(DateTime date) async {
    isLoading = true;
    final result = await FirebaseTask.getTasks(date);
    switch (result) {
      case FirebaseSuccess<List<TaskModel>>():
        tasks = result.data ?? [];
        tasks.sort((task1, task2) {
          final task1Priority = task1.priority;
          final task2Priority = task2.priority;
          return task1Priority!.compareTo(task2Priority!);
        });
      case FirebaseError<List<TaskModel>>():
        AppDialogWidget.showError(context, errorMessage: result.message);
    }
    isLoading = false;
    setState(() {});
  }

  Widget _loadingState() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [CircularProgressIndicator.adaptive()],
      ),
    );
  }

  Widget _listOfTasks() {
    return tasks.isEmpty
        ? _emptyState()
        : Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemBuilder: (context, index) => ItemCardWidget(
                title: tasks[index].title ?? '',
                date: tasks[index].date ?? DateTime.now(),
                priority: tasks[index].priority ?? 1,
                isCompleted: tasks[index].isCompleted ?? false,
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(
                        AppRoutes.editTaskPage,
                        arguments: tasks[index],
                      )
                      .whenComplete(() async {
                        _getTasks(_selectedValue);
                      });
                },
              ),
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemCount: tasks.length,
            ),
          );
  }

  Widget _emptyState() {
    return Column(
      children: [
        SizedBox(height: 90),
        Image.asset(
          AppAssets.homeIcon,
          width: 352,
          height: 238,
          fit: BoxFit.contain,
        ),
        SizedBox(height: 15),
        Text(
          'What do you want to do today?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Color(0xDE24252C),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Tap + to add your tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xff404147),
          ),
        ),
      ],
    );
  }

  // Widget continterWidget({required String title}) {
  //   return Align(
  //     alignment: Alignment.centerLeft,
  //     child: Container(
  //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //       margin: EdgeInsets.only(left: 12),
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Color(0xff6E6A7C), width: 1),
  //         borderRadius: BorderRadius.circular(6),
  //       ),
  //       child: Text(
  //         title,
  //         style: TextStyle(
  //           fontSize: 12,
  //           fontWeight: FontWeight.w400,
  //           color: Color(0xDE24252C),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
