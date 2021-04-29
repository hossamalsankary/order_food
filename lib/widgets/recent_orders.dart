import 'package:flutter/material.dart';
import 'package:order/widgets/food_config.dart';

class RecentOrders extends StatelessWidget {
  final Map fooddata;
  RecentOrders(this.fooddata);
  _buildRecentOrder(BuildContext context, Map order) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 320.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          width: 1.0,
          color: const Color(4278190080),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    height: 100.0,
                    width: 100.0,
                    image: AssetImage(order["imageUrl"]),
                    fit: BoxFit.cover,
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
                          order["name"],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "order.restaurant.name",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          " price \$${order["price"]}",
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
          Container(
            margin: EdgeInsets.only(top: 49),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_bag_outlined,
                ),
                iconSize: 20.0,
                color: Colors.green,
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'hey #hossam Cheack this out',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          height: 120.0,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: Collecting.of(context)!.card.length,
            itemBuilder: (BuildContext context, int index) {
              Map order = Collecting.of(context)!.card[index];
              return _buildRecentOrder(context, order);
            },
          ),
        ),
      ],
    );
  }
}
