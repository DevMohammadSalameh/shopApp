// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../shared/styles/colors.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {

    List<OnBoardModel> models = [
      OnBoardModel("assets/images/onBoardImage1.jpg", "The first title",
          "The first description "),
      OnBoardModel("assets/images/onBoardImage2.jpg", "The second title",
          "The second description "),
      OnBoardModel("assets/images/onBoardImage3.jpg", "The third title",
          "The third description ")
    ];

    bool isLast = false;

    var pageController = PageController();
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CacheHelper.setData(key: "skippedLanding", value: true);
              navigateAndFinish(context, LoginScreen());
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemBuilder: (context, index) => onBoardingItem(models[index]),
              itemCount: 3,
              onPageChanged: (pageIndex){
                if(pageIndex == models.length-1) {
                  isLast = true;
                  }
                else{
                  isLast = false;
                }
              },
              physics: BouncingScrollPhysics(),
              controller: pageController,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(controller: pageController, count: models.length,
                effect: ExpandingDotsEffect(activeDotColor: primaryColor),),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      CacheHelper.setData(key: "skippedLanding", value: true);
                      navigateAndFinish(context, LoginScreen());
                    }
                    else{pageController.nextPage(
                        duration: Duration(
                          seconds: 1,
                        ),
                        curve: Curves.fastOutSlowIn);}
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget onBoardingItem(OnBoardModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image.asset(
          model.image,
          fit: BoxFit.fill,
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              Text(model.desc),
              SizedBox(height: 15),
            ],
          ),
        )
      ],
    );
  }
}

class OnBoardModel {
  final String image;
  final String title;
  final String desc;

  OnBoardModel(this.image, this.title, this.desc);
}
