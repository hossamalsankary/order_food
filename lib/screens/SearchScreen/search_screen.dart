import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:order/data/loaddata.dart';
import 'package:order/screens/cart_screen.dart';
import 'package:order/screens/foodScreen/fooditem_screen.dart';
import 'package:order/widgets/food_config.dart';
import 'package:order/widgets/sweetopicty.dart';
import 'package:order/widgets/widgets.dart';

class Search extends StatefulWidget {
  final String searchvalue;
  Search(this.searchvalue);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late String searchval;
  int resulat = 0;

  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    searchval = widget.searchvalue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 160,
        elevation: 0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios),
          ),
          iconSize: 30.0,
          onPressed: () {
            // print(FoodConfig.of(context).jsondata);
            setState(() {});
            print(Collecting.of(context)!.card);
          },
        ),
        actions: <Widget>[
          FlatButton(
            child: Badge(Collecting.of(context)!.card.length),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CartScreen(),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _controller,
              onChanged: (value) {
                setState(() {
                  searchval = value;
                });
              },
              onSubmitted: (val) {
                setState(() {
                  searchval = val;
                });
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    width: 0.8,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                hintText: 'Search ',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor,
                  ),
                  onPressed: () {
                    setState(() {
                      searchval = _controller.value.text;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: loadAsset(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var decodedata = jsonDecode(snapshot.data.toString());
            Map<String, Map> data = Map.from(decodedata);
            List searchmap = [];
            List<Widget> fooditems = [];

            _buildfooditrm() {
              // print(data);
              data["food"]!.forEach(
                (key, value) {
                  String name = value["name"];
                  //print(!name.contains("k"));
                  if (searchval != "") {
                    if (name.contains(searchval)) {
                      searchmap.add(value);
                    }
                  }
                },
              );
              searchmap.forEach((element) {
                fooditems.add(NiceFoodCart(
                  food: element,
                ));
              });
            }

            _buildfooditrm();
            resulat = fooditems.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      resulat == 0
                          ? "Hey Sorry Someting Went Wrong"
                          : "Hey We Found ($resulat) Of resulat",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: fooditems,
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class NiceFoodCart extends StatelessWidget {
  final Map food;
  NiceFoodCart({required this.food});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(food["imageUrl"]),
                  fit: BoxFit.cover,
                ),
                color: Colors.red,
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
          ),
          Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.yellow.withOpacity(0.2),
                    ]),
                borderRadius: BorderRadius.circular(10)),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  food["name"],
                  style: TextStyle(
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          color: Colors.yellow,
                          blurRadius: 10,
                          offset: Offset(0.7, 0.5))
                    ],
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                RawMaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FoodItem(food)),
                    );
                  },
                  child: Text(
                    "View",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  shape: StadiumBorder(),
                  splashColor: Colors.yellowAccent,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
