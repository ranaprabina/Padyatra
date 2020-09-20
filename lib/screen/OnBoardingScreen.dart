import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:padyatra/screen/Explore.dart';
import 'package:padyatra/screen/HomePage.dart';

import 'package:padyatra/screen/MainPage.dart';

class OnBoardingScreen extends StatelessWidget {
  final pageDecoration = PageDecoration(
    titleTextStyle: PageDecoration().titleTextStyle.copyWith(
          color: Colors.black,
        ),
    bodyTextStyle: PageDecoration().bodyTextStyle.copyWith(
          color: Colors.black,
        ),
  );
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> getPages() {
      return [
        PageViewModel(
          image: Image.asset("images/trekking-man.png"),
          title: "Explore your desired trekking routes",
          body: "Let the Adventure Begin",
          footer: Text(
            "Padyatra",
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: Image.asset("images/trekking-two-person.png"),
          title: "Explore your desired trekking routes",
          body: "Let the Adventure Begin",
          footer: Text(
            "Padyatra",
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          image: Image.asset("images/trekking-solo.png"),
          title: "Explore your desired trekking routes",
          body: "Let the Adventure Begin",
          footer: Text(
            "Padyatra",
            style: TextStyle(
              color: Colors.teal,
            ),
          ),
          decoration: pageDecoration,
        ),
      ];
    }

    return Scaffold(
      body: IntroductionScreen(
        // globalBackgroundColor: Colors.white,
        dotsDecorator: DotsDecorator(
          activeSize: const Size(20.0, 10.0),
          activeColor: Colors.teal,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        pages: getPages(),
        done: Text(
          "Done",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        onDone: () {
          print("Done clicked");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => GuestUser()));
        },
        showSkipButton: true,
        showNextButton: true,
        skipFlex: 0,
        skip: Text(
          "Skip",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        onSkip: () {
          print("Skip button clicked");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => Explore()));
        },
        next: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
