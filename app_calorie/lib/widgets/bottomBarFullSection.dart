import 'package:app_calorie/pages/couponsPage.dart';
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
        Container(height:200 ,child: const ListRadioMembers()),
        ElevatedButton(
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CouponsPage())),
          child: Icon(Icons.done),
        ),
      ],
    );
  }
}
