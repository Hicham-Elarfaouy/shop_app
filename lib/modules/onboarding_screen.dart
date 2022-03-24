import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/modules/login_screen.dart';
import 'package:flutter_app6/shared/components/elements.dart';
import 'package:flutter_app6/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoiardingScreen extends StatefulWidget {

  @override
  State<OnBoiardingScreen> createState() => _OnBoiardingScreenState();
}

class _OnBoiardingScreenState extends State<OnBoiardingScreen> {

  PageController BoardingController = new PageController();

  bool isLastPage = false;

  void submit(){
    CacheHelper.putshared(key: 'isBoarding', value: true).then((value) {
      navigateToAndFinish(context, LoginScreen());
    }).catchError((error) {
      print(error.toString());
    });
  }

  List<BoardingModel> BoardingItems = [
    BoardingModel(
      image: 'assets/onBoarding1.png',
      title: 'First Title',
      lorum: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    BoardingModel(
      image: 'assets/onBoarding2.png',
      title: 'Second Title',
      lorum: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
    BoardingModel(
      image: 'assets/onBoarding3.png',
      title: 'Third Title',
      lorum: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        actions: [
          TextButton(
            onPressed: submit,
            child: Text(
              'Skip'
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: BoardingController,
                itemCount: BoardingItems.length,
                itemBuilder: (context, index) => BoardingItem(BoardingItems[index]),
                onPageChanged: (index){
                  if(index == BoardingItems.length - 1){
                    setState(() {
                      isLastPage = true;
                    });
                  }else{
                    setState(() {
                      isLastPage = false;
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: BoardingController,
                    count: BoardingItems.length,
                    effect: ExpandingDotsEffect(
                      expansionFactor: 2,
                      activeDotColor: Colors.blue,
                    ),
                  ),
                  FloatingActionButton(
                    onPressed: (){
                      if(isLastPage){
                        submit();
                      }else{
                        BoardingController.nextPage(
                          duration: Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastOutSlowIn,
                        );
                      }
                    },
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
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

Widget BoardingItem(BoardingModel model) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  child: Column(
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}'),

        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 2,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20,
      ),
      Text(
        '${model.lorum}',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    ],
  ),
);

class BoardingModel{
  final String image;
  final String title;
  final String lorum;

  BoardingModel({
    required this.image,
    required this.title,
    required this.lorum,
});
}