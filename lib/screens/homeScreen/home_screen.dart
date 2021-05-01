import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:order/animation/ScaleRoute.dart';
import 'dart:convert';

import 'package:order/data/loaddata.dart';
import 'package:order/screens/SearchScreen/search_screen.dart';
import 'package:order/screens/cart_screen.dart';
import 'package:order/screens/restaurantScreen/restaurant_screen.dart';
import 'package:order/screens/singin_screen/SignInPage.dart';

import 'package:order/widgets/food_config.dart';
import 'package:order/widgets/rating_stars.dart';
import 'package:order/widgets/recent_orders.dart';
import 'package:order/screens/homeScreen/components/searchWidget.dart';
import 'package:order/widgets/sweetopicty.dart';
import 'package:order/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map fooddata = {};
  TextEditingController _controller = TextEditingController();
  String val = "";
  int opictytime = 500;
  void onpress() {
    print(val);
    if (val.length > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) {
            return Search(_controller.value.text);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        leading: CircleAvatar(
          child: IconButton(
            icon: FaIcon(FontAwesomeIcons.signInAlt),
            onPressed: () {
              Navigator.push(
                  context,
                  ScaleRoute(
                    page: SignInPage(),
                  ));
            },
          ),
          backgroundColor: Colors.white,
        ),
        actions: <Widget>[
          FlatButton(
            child: Badge(Collecting.of(context)!.card.length),
            onPressed: () => Navigator.push(
              context,
              ScaleRoute(
                page: CartScreen(),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchWidget(
              controller: _controller,
              onchange: (value) {
                setState(() {
                  val = value;
                });
              },
              onSubmitted: (val) {
                if (val.length > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return Search(val);
                      },
                    ),
                  );
                }
              },
              onpressIcon: onpress,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: loadAsset(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var jsondata = jsonDecode(snapshot.data.toString());
            Map data = Map.from(jsondata);
            Collecting.of(context)!.maindata = data;
            final Map rest = data["restaurant"];
            final Map food = data["food"];
            fooddata = food;
            _buildRestaurants() {
              List<Widget> restaurantList = [];

              rest.forEach((key, value) {
                restaurantList.add(
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantScreen(
                            restaurant: value,
                            food: food,
                          ),
                        ),
                      );
                      Collecting.of(context)!.restaurant = value;
                      Collecting.of(context)!.food = food;
                    },
                    child: SweetOpicty(
                      time: restaurantList.length == 0
                          ? opictytime
                          : opictytime + 500,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[200]!,
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Hero(
                                tag: value["imageUrl"],
                                child: Image(
                                  height: 150.0,
                                  width: 150.0,
                                  image: AssetImage(value["imageUrl"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      value["name"],
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    RatingStars(int.parse(value["rating"])),
                                    SizedBox(height: 4.0),
                                    Text(
                                      value["address"],
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(
                                      '0.2 miles away',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });

              return Column(children: restaurantList);
            }

            return ListView(
              children: <Widget>[
                Collecting.of(context)!.card.length > 0
                    ? RecentOrders(fooddata)
                    : SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        'Nearby Restaurants',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    _buildRestaurants(),
                  ],
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            );
          }
        },
      ),
    );
  }
}
