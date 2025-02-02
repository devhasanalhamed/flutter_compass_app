import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).iconTheme.color,
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: Icon(
      //     Icons.menu,
      //     size: 32.0,
      //     color: Color(0xFFF04242),
      //   ),
      // ),
    );
  }
}
