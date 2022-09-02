import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onAvatarPressed;
  final VoidCallback onSitePressed;
  final Color avatarBorderColor;
  final Color siteButtonBorderColor;

  const CustomAppBar({
    required this.onAvatarPressed,
    required this.onSitePressed,
    this.avatarBorderColor = Colors.transparent,
    this.siteButtonBorderColor = Colors.transparent,
    super.key,
  });

  @override
  Widget build(context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[900],
      title: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          side: BorderSide(
            color: siteButtonBorderColor,
          ),
        ),
        onPressed: onSitePressed,
        child: const Text("Site oficial"),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: avatarBorderColor,
            ),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: onAvatarPressed,
            icon: FluttermojiCircleAvatar(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
