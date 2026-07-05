import 'package:flutter/material.dart';

class GridCards extends StatelessWidget {
  const GridCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: AlignmentGeometry.bottomLeft,
                  end: AlignmentGeometry.topRight,
                  colors: [
                    const Color(0xFF060B1B),
                    const Color(0xFF003B57),
                  ]),
              borderRadius: BorderRadius.circular(12),
            ),
          );
        },
      ),
    );
  }
}
