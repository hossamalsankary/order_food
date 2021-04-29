import 'dart:async';

import 'package:flutter/material.dart';
import 'package:order/widgets/fancybotton_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/restaurant2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.6),

                  Colors.black.withOpacity(0.6),
                  // Colors.yellowAccent.withOpacity(0.3)
                ],
                // begin: Alignment.topRight,
                // end: Alignment.bottomRight,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    style: Theme.of(context)
                        .textTheme
                        .display3!
                        .copyWith(color: Colors.white, fontSize: 49),
                    children: [
                      TextSpan(
                        text: "Let's ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "Eat!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * .6,
                  child: FancyButton(
                    text: "Go",
                    filcolor: Colors.orange.withOpacity(0.444),
                    onpress: () {
                         Navigator.popAndPushNamed(context, "home");

                    },
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.yellow.withOpacity(0.1),
                  Colors.black.withOpacity(0.222),
                  Colors.yellowAccent.withOpacity(0.1)
                ],
                // begin: Alignment.topRight,
                // end: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
