import 'package:flutter/material.dart';
import 'package:order/screens/foodScreen/fooditem_screen.dart';

import 'package:order/widgets/food_config.dart';
import 'package:order/widgets/rating_stars.dart';
import 'package:order/widgets/sweetopicty.dart';
import 'package:order/widgets/widgets.dart';

class RestaurantScreen extends StatefulWidget {
  final Map restaurant;
  final Map food;

  RestaurantScreen({required this.restaurant, required this.food});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  double info = 47;
  int flexspace = 10;
  IconData showmore = Icons.restaurant_menu_rounded;

  _buildMenuItem(Map menuItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodItem(menuItem),
          ),
        );
      },
      child: SweetOpicty(
        time: 800,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Hero(
                tag: menuItem["imageUrl"],
                child: Container(
                  height: 160.0,
                  width: 160.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(menuItem["imageUrl"]),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
              Container(
                height: 160.0,
                width: 160.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black87.withOpacity(0.3),
                      Colors.black54.withOpacity(0.3),
                      Colors.black38.withOpacity(0.3),
                    ],
                    stops: [0.1, 0.4, 0.6, 0.9],
                  ),
                ),
              ),
              Positioned(
                bottom: 65.0,
                child: Column(
                  children: <Widget>[
                    Text(
                      menuItem["name"],
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '\$${menuItem["price"]}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_bag_outlined,
                      ),
                      iconSize: 20.0,
                      color: Colors.green,
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => FoodItem(menuItem),
                        //   ),
                        // );
                        setState(() {});
                        Map foodata = menuItem;
                        foodata["count"] = 1;
                        if (!Collecting.of(context)!.card.contains(foodata)) {
                          Collecting.of(context)!.card.add(foodata);
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: widget.restaurant["imageUrl"],
                child: Image(
                  height: 199.0,
                  width: MediaQuery.of(context).size.width,
                  image: AssetImage(widget.restaurant["imageUrl"]),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.yellow,
                        iconSize: 30.0,
                        onPressed: () => Navigator.pushNamed(context, "home")),
                    FlatButton(
                        child: Badge(Collecting.of(context)!.card.length),
                        onPressed: () =>
                            Navigator.popAndPushNamed(context, "card")),
                  ],
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            height: info,
            child: Padding(
              padding: EdgeInsets.only(top: 3.0, right: 25, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: flexspace,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Text(
                        //   '0.2 miles away',
                        //   style: TextStyle(
                        //     fontSize: 18.0,
                        //   ),
                        // ),
                        RatingStars(int.parse(widget.restaurant["rating"])),
                        Text(
                          widget.restaurant["name"],
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 6.0),
                  Expanded(
                    child: Text(
                      "${widget.restaurant["address"]}\n \n Give a call : 01068944209   ",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //  Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: <Widget>[
          //     FlatButton(
          //       padding: EdgeInsets.symmetric(horizontal: 30.0),
          //       color: Theme.of(context).primaryColor,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: Text(
          //         'Reviews',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20.0,
          //         ),
          //       ),
          //       onPressed: () {},
          //     ),
          //     FlatButton(
          //       padding: EdgeInsets.symmetric(horizontal: 30.0),
          //       color: Theme.of(context).primaryColor,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10.0),
          //       ),
          //       child: Text(
          //         'Contact',
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontSize: 20.0,
          //         ),
          //       ),
          //       onPressed: () {},
          //     ),
          //   ],
          // ),
          SizedBox(height: 10.0),
          GestureDetector(
            onTap: () {
              setState(() {
                info == 47 ? info = 170 : info = 47;
                flexspace == 10 ? flexspace = 1 : flexspace = 10;
              });
            },
            child: Container(
              // padding: EdgeInsets.symmetric(horizontal: ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(showmore),
                  SizedBox(width: 5.0),
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(1),
              shrinkWrap: true,
              addRepaintBoundaries: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: List.generate(widget.food.length, (index) {
                List food = List.from(widget.food.keys);
                Map fooddata = widget.food[food[index]];
                //return Text(widget.food[food[index]].toString());

                return _buildMenuItem(fooddata);
              }),
            ),
          )
        ],
      ),
    );
  }
}
