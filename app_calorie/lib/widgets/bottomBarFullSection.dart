import 'package:app_calorie/widgets/ListRadioMembers.dart';
import 'package:flutter/material.dart';

class bottomBarFullSection extends StatelessWidget {
  bottomBarFullSection({super.key});

  int? currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const Text(
          'select the member to get the discount!',
          style: TextStyle(
              fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
              height: 250, width: 350, child: const ListRadioMembers()),
        ),
      ],
    );
  }
}
