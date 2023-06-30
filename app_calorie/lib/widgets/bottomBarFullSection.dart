import 'package:app_calorie/widgets/ListRadioMembers.dart';
import 'package:flutter/material.dart';

class bottomBarFullSection extends StatelessWidget {
  bottomBarFullSection({super.key});

  int? currentValue;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Congratulations!',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
        ),
        SizedBox(height: 8),
        Text(
          'Choose which brand will help World Food Program, donating 20K Kcal of food. You will get a Coupon!',
          style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        ListRadioMembers(),
      ],
    );
  }
}
