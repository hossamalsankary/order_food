import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order/widgets/fancybotton_screen.dart';
import 'package:order/widgets/food_config.dart';
import 'package:order/widgets/sweetopicty.dart';
import 'package:order/widgets/widgets.dart';

class FoodItem extends StatefulWidget {
  final Map food;
  FoodItem(this.food);
  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  int ordercount = 1;
  TextStyle iconstyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white);
  Widget build(BuildContext context) {
    TextStyle mainStyle = TextStyle(fontSize: 25, fontWeight: FontWeight.w700);

    return Scaffold(
      body: SweetOpicty(
        time: 1000,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        widget.food["imageUrl"],
                      )),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.yellow.withOpacity(0.4),

                    // Colors.white.withOpacity(0.2),
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.0, vertical: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          color: Colors.yellow,
                          iconSize: 30.0,
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                        ),
                      ),
                      FlatButton(
                          child: Badge(Collecting.of(context)!.card.length),
                          onPressed: () =>
                              Navigator.pushNamed(context, "card")),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(top: 30, right: 15, left: 15),
                height: MediaQuery.of(context).size.height / 1.9,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "\n\$",
                                style: mainStyle.copyWith(
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                widget.food["price"],
                                style: mainStyle,
                              )
                            ],
                          ),
                        ),
                        Text(
                          widget.food["name"],
                          style: mainStyle,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          simpleIcon(
                            icondata: Icons.star_rate,
                            iconcolor: Colors.orange,
                            text: "2.5",
                          ),
                          simpleIcon(
                            icondata: Icons.local_fire_department,
                            iconcolor: Colors.red,
                            text: " 66 Calories",
                          ),
                          simpleIcon(
                            icondata: Icons.alarm,
                            iconcolor: Colors.orange,
                            text: "30 min",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Details ",
                            style: mainStyle.copyWith(
                              fontSize: 19,
                            ),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            widget.food["details"],
                            style: mainStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 2,
              //left: MediaQuery.of(context).size.width / 2,
              right: MediaQuery.of(context).size.width / 2.7,
              child: ordercounter(),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(

      //   mini: false,
      //   child: Icon(
      //     Icons.add,
      //     size: 25,
      //     color: Colors.white,
      //   ),
      //   backgroundColor: Colors.orange,
      // ),
      floatingActionButton: FancyButton(
        text: "Add This ",
        onpress: () {
          Map newfood = widget.food;
          newfood["count"] = ordercount;
          newfood["select"] = false;

          print(newfood);

          if (!Collecting.of(context)!.card.contains(newfood)) {
            Collecting.of(context)!.card.add(newfood);
            print(Collecting.of(context)!.card);
          }
          setState(() {});
        },
      ),
    );
  }

  Widget simpleIcon(
      {required IconData icondata, String? text, Color? iconcolor}) {
    return Container(
      child: Row(
        children: [
          Icon(
            icondata,
            color: iconcolor,
          ),
          SizedBox(
            width: 2,
          ),
          Text(text!)
        ],
      ),
    );
  }

  // ignore: missing_return
  Widget ordercounter() {
    return Container(
      width: 111,
      height: 52,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Text(
              "-",
              style: iconstyle,
            ),
            onTap: () {
              setState(() {
                ordercount--;
                // ignore: unnecessary_statements
                ordercount < 0 ? ordercount = 0 : null;
              });
            },
          ),
          Text(
            ordercount.toString(),
            style: iconstyle.copyWith(fontSize: 26),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Text(
              "+",
              style: iconstyle.copyWith(fontSize: 25),
            ),
            onTap: () {
              setState(() {
                ordercount++;
              });
            },
          ),
        ],
      ),
    );
  }
}
