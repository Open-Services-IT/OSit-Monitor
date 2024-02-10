import 'package:flutter/material.dart';

class CustomBottomBarItem extends StatelessWidget {
  const CustomBottomBarItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onCustomTap,
  });
  final IconData icon;
  final String text;
  final GestureTapCallback? onCustomTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onCustomTap,
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: Colors.deepPurple,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.deepPurple,
                fontSize: 14,
              ),
            ),
          ],
        ),
  );
}
