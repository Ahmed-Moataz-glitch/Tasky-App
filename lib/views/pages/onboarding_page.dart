import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasky/views/widgets/app_assets.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  var pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(height: 150),
            SizedBox(
              width: 375,
              height: 240,
              child: PageView.builder(
                controller: pageController,
                itemBuilder: (context, index) {
                  return Image.asset(
                    onboardingPages[currentIndex].imagePath,
                    width: 375,
                    height: 240,
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: onboardingPages.length,
              ),
            ),
            const SizedBox(height: 24),
            SmoothPageIndicator(
              controller: pageController,
              count: onboardingPages.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Color(0xff5F33E1),
                dotColor: Color(0xffAFAFAF),
                dotHeight: 8,
                dotWidth: 8,
                spacing: 10,
              ),
            ),
            SizedBox(height: 50),
            Text(
              onboardingPages[currentIndex].title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xDE24252C),
              ),
            ),
            SizedBox(height: 42),
            Text(
              onboardingPages[currentIndex].description,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xDE6E6A7C),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 107),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if(currentIndex < onboardingPages.length - 1){
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                      setState(() {
                        currentIndex++;
                      });
                    } else {
                      Navigator.of(context).pushNamed('/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff5F33E1),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentIndex < onboardingPages.length - 1 ? 'NEXT' : 'GET STARTED',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageItem {
  final String imagePath;
  final String title;
  final String description;

  OnboardingPageItem({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}

List<OnboardingPageItem> onboardingPages = [
  OnboardingPageItem(
    imagePath: AppAssets.onboardingIcon1,
    title: 'Manage your tasks',
    description:
        'You can easily manage all of your daily\ntasks in DoMe for free',
  ),
  OnboardingPageItem(
    imagePath: AppAssets.onboardingIcon2,
    title: 'Create daily routine',
    description:
        'In Tasky  you can create your personalized\nroutine to stay productive',
  ),
  OnboardingPageItem(
    imagePath: AppAssets.onboardingIcon3,
    title: 'Orgonaize your tasks',
    description:
        'You can organize your daily tasks by\nadding your tasks into separate categories',
  ),
];
