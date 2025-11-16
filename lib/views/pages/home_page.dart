import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff24252C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: (){},
        child: Image.asset(
          'assets/icons/add_icon.png',
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
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/tasky_icon.png',
                      width: 78,
                      height: 28,
                    ),
                    Spacer(),
                    Image.asset(
                      'assets/icons/logout_icon.png',
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
                'assets/icons/home_icon.png',
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
}