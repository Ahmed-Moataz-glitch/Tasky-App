import 'package:flutter/material.dart';
import 'package:tasky/views/widgets/app_assets.dart';
import 'package:tasky/views/widgets/app_routes.dart';
import 'package:tasky/views/widgets/modal_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff24252C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: _addOnPressed,
        child: Image.asset(
          AppAssets.addIcon,
          width: 30,
          height: 30,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.editTaskPage);
                  // Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Row(
                  children: [
                    Image.asset(
                      AppAssets.taskyIcon,
                      width: 78,
                      height: 28,
                    ),
                    Spacer(),
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
              SizedBox(height: 85),
              Image.asset(
                AppAssets.homeIcon,
                width: 352,
                height: 238,
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
    );
  }
}