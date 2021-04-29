import 'package:flutter/material.dart';

import 'package:order/widgets/fancybotton_screen.dart';
import 'package:order/widgets/food_config.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  num price = 0;
  num items = 0;
  @override
  void dispose() {
    super.dispose();
  }

  void countPrice() {
    setState(() {
      price = 0;
      items = 0;
    });
    Collecting.of(context)!.card.forEach((item) {
      price += int.parse(item["price"]) * item["count"];
      items += item["count"];
    });
  }

  @override
  Widget build(BuildContext context) {
    List fooddata = Collecting.of(context)!.card;
    countPrice();
    var mainstyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

    var titleStyle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700);
    var textStyle = TextStyle(fontSize: 19, fontWeight: FontWeight.w600);
    return Scaffold(
      backgroundColor: Colors.white38.withOpacity(0.99),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all_rounded),
            iconSize: 30.0,
            onPressed: () {
              // print(FoodConfig.of(context).jsondata);
              setState(() {});
              Collecting.of(context)!.card.clear();
            },
          ),
        ],
        leading: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_ios,
              size: 30,
            ),
          ),
        ),
        elevation: 0,
        toolbarHeight: 70,
        title: Text('Cart Food'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 6,
              child: ListView.builder(
                itemCount: fooddata.length,
                itemBuilder: (context, index) {
                  Map food = fooddata[index];

                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Collecting.of(context)!.card.removeAt(index);
                      setState(() {});
                    },
                    child: InkWell(
                      highlightColor: Colors.orange.withOpacity(0.4),
                      onLongPress: () {
                        // print(food);
                        // if (Collecting.of(context)!.card[index]["select"] ==
                        //     false) {
                        //   print(Collecting.of(context)!.card[index]["select"]);
                        //   Collecting.of(context)!.card[index]["select"] = true;
                        // } else {
                        //   Collecting.of(context)!.card[index]["select"] = false;
                        // }
                        // setState(() {});
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 4,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.2, 0.4),
                              color: Colors.yellow,
                              spreadRadius: 0.2,
                              blurRadius: 0.2,
                            ),
                            BoxShadow(
                              offset: Offset(0.2, 0.3),
                              color: Colors.white,
                              spreadRadius: 0.2,
                              blurRadius: 0.6,
                            ),
                            BoxShadow(
                              offset: Offset(0.2, 0.5),
                              color: Colors.white,
                              spreadRadius: 0.2,
                              blurRadius: 0.4,
                            ),
                            BoxShadow(
                              offset: Offset(0.2, 0.3),
                              color: Colors.white,
                              spreadRadius: 0.2,
                              blurRadius: 0.2,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Stack(
                                children: [
                                  Container(
                                    //width: 70,
                                    height: 120,
                                    // width: 150,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                          food["imageUrl"],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 110,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0.5),
                                              Colors.yellow.withOpacity(0.4),

                                              // Colors.white.withOpacity(0.2),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight)),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 11, horizontal: 9),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1),
                                      child: Text(
                                        food["name"],
                                        textDirection: TextDirection.rtl,
                                        style: mainstyle.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      food["details"],
                                      style: mainstyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "\n\$${food["price"]} \n",
                                          style: mainstyle.copyWith(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ordercounter(index),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
          Collecting.of(context)!.card.length != 0
              ? Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TotalItimes",
                                    style: titleStyle,
                                  ),
                                  Text(
                                    "\$ $items",
                                    style: textStyle,
                                  )
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 24,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "TotalPrice",
                                    style: titleStyle,
                                  ),
                                  Text(
                                    "\$${price.toString()}",
                                    style: textStyle,
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey,
                                height: 24,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: FancyButton(
                            onpress: () {
                              print(UniqueKey());
                              Navigator.pushNamed(context, "home");
                            },
                            text: "Order Now",
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.2, 0.4),
                          color: Colors.yellow,
                          spreadRadius: 0.2,
                          blurRadius: 0.2,
                        ),
                        BoxShadow(
                          offset: Offset(0.2, 0.3),
                          color: Colors.yellow,
                          spreadRadius: 0.2,
                          blurRadius: 0.6,
                        ),
                        BoxShadow(
                          offset: Offset(0.2, 0.5),
                          color: Colors.white,
                          spreadRadius: 0.2,
                          blurRadius: 0.4,
                        ),
                        BoxShadow(
                          offset: Offset(0.2, 0.3),
                          color: Colors.white,
                          spreadRadius: 0.2,
                          blurRadius: 0.2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ))
              : SizedBox(),
        ],
      ),
    );
  }

  Widget ordercounter(index) {
    return Container(
      width: 90,
      height: 43,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(80),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "-",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            onTap: () {
              setState(() {
                Collecting.of(context)!.card[index]["count"]--;
                Collecting.of(context)!.card[index]["count"] < 0
                    ? Collecting.of(context)!.card[index]["count"] = 0
                    // ignore: unnecessary_statements
                    : null;
              });
            },
          ),
          Text(
            Collecting.of(context)!.card[index]["count"].toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "+",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            onTap: () {
              setState(() {
                Collecting.of(context)!.card[index]["count"]++;
              });
            },
          ),
        ],
      ),
    );
  }
}
