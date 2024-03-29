import 'package:coffee_shop/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/user_list.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.home,
            color: Color(0xFFE57734),
            size: 35,
          ),
          Material(
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>USerListPage(),));
              },
              child: Icon(
                Icons.favorite,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
          Icon(
            Icons.notifications,
            color: Colors.white70,
            size: 35,
          ),
          Icon(
            Icons.person,
            color: Colors.white70,
            size: 35,
          ),
        ],
      ),
    );
  }
}