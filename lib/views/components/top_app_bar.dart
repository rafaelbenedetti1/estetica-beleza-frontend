import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  const TopAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(70.0),
        super(key: key);

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 230,
      toolbarHeight: 90,
      elevation: 16,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 95),
          child: Text('Beleza',
              style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 18,
                  color: Color.fromRGBO(187, 161, 79, 40))),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.only(top: 40, left: 75),
        child: Text('Benedetti',
            style: TextStyle(
                fontFamily: 'DancingScript',
                fontSize: 18,
                color: Color.fromRGBO(187, 161, 79, 40))),
      ),
      title: Row(
        children: [
          Expanded(
              child: SvgPicture.asset("assets/images/logowomann.svg",
                  height: 60,))
        ],
      ),
      backgroundColor: Colors.black87,
    );
  }
}
