import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 253, 173),
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          const Icon(
            Icons.sort,
            size: 25,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'E-Commerce',
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
            ),
          ),
          const Spacer(),
          badges.Badge(
              badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red, padding: EdgeInsets.all(6)),
              badgeContent: const Text(
                '9',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/list_chat'),
                child: Icon(Icons.message_sharp),
              )),
        ],
      ),
    );
  }
}
