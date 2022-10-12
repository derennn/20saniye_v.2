import 'package:flutter/material.dart';
import 'oyuncusayilari.dart';
import 'skorlar.dart' as skorlar;
import 'dart:math' as math;

class MenuyeDon extends StatelessWidget {
  const MenuyeDon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 5,
      child: TextButton(
        onPressed: () {
          skorlar.globalSkorTablosuOyuncuSayisiList.clear();
          listoflists.clear();
          Navigator.of(context).popUntil((route) => route.isFirst);
          skorlar.updatedPlayerNames.clear();
        },
        child: Row(
          children: [
            Transform.rotate(
              angle: -math.pi / -5.0,
              child: const Icon(
                Icons.undo_rounded,
                color: Colors.white,
                size: 26,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Menüye Dön',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textScaleFactor: 1.5,
            ),
          ],
        ),
      ),
    );
  }
}