import 'package:app_calorie/models/coupon.dart';
import 'package:app_calorie/models/couponsList.dart';
import 'package:app_calorie/pages/couponsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListRadioMembers extends StatefulWidget {
  const ListRadioMembers({super.key});

  @override
  State<ListRadioMembers> createState() => listRadioMembersState();
}

class listRadioMembersState extends State<ListRadioMembers> {
  final List<String> _members = ['Nike', 'Lowa', 'Bottecchia'];
  final List<double> _membNum = [1, 2, 3];
  List<String> pathsImages = [
    'assets/nike.png',
    'assets/lowa.png',
    'assets/bottecchia.png',
  ];

  num? currentValue;

  void _couponGeneration(BuildContext context, num? val) {
    if (val != null) {
      double value = val as double;
      Coupon newCoupon = generateCoupon(value);
      Provider.of<CouponsList>(context, listen: false).addCoupon(newCoupon);
      Navigator.of(context)
         .push(MaterialPageRoute(builder: (context) => CouponsPage()));
    } else {
      ScaffoldMessenger(
        child: Text('Choose a brand first'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          child: ListView.builder(
            itemCount: _members.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                minVerticalPadding: 0.5,
                title: Text(_members[index]),
                leading: Radio(
                  fillColor: MaterialStateColor.resolveWith(
                      (states) => const Color(0xFF89453C)),
                  value: _membNum[index],
                  groupValue: currentValue,
                  onChanged: (val) {
                    setState(() {
                      currentValue = val;
                      print('currentvalue $currentValue');
                    });
                  },
                ),
                trailing: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Image.asset(
                    pathsImages[index],
                  ),
                ),
                visualDensity: const VisualDensity(horizontal: -2),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => _couponGeneration(context, currentValue),
          child: Icon(Icons.done),
        ),
      ],
    );
  }
}
