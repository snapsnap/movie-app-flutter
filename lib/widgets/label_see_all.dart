import 'package:flutter/material.dart';

class LabelSeeAll extends StatelessWidget {
  final String label;
  final void Function()? onTap;

  const LabelSeeAll({
    super.key,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 5, right: 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 255, 249, 231),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.amber,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 0,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Align(
              alignment: Alignment.centerRight,
              child: Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                      letterSpacing: 0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    applyTextScaling: true,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
