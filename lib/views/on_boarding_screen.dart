import 'package:flutter/material.dart';
import 'package:shopapp/helper/cach.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:shopapp/views/login.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  final List<OnBoardingModel> board = [
    OnBoardingModel(
        title: 'OnBoard 1 Title',
        body: 'OnBoard 1 Body',
        image: 'assets/1.jpg'),
    OnBoardingModel(
        title: 'OnBoard 2 Title',
        body: 'OnBoard 2 Body',
        image: 'assets/2.jpg'),
    OnBoardingModel(
        title: 'OnBoard 3 Title',
        body: 'OnBoard 3 Body',
        image: 'assets/3.jpg'),
  ];
  bool islast = false;
  void submit() {
    ChachHelper.saveData(key: 'onBoarding', value: true)!.then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(color: defaultColor),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == board.length - 1) {
                    setState(() {
                      islast = true;
                    });
                    print('Last');
                  } else {
                    print('Not Last');
                    setState(() {
                      islast = false;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return BuildBoardingItem(
                    board: board[index],
                  );
                },
                itemCount: board.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: board.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: defaultColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (islast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(
      {required this.image, required this.title, required this.body});
}

class BuildBoardingItem extends StatelessWidget {
  BuildBoardingItem({
    super.key,
    required this.board,
  });

  OnBoardingModel board;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(board.image),
          ),
        ),
        Text(
          board.title,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Text(
          board.body,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
