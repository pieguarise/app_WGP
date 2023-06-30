import 'dart:math';

import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/pages/achievementsPage.dart';

import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void>? _couponGeneration(BuildContext context, num? val) async {
    if (val != null) {
      double value = val as double;

      String title = "Nike";
      if (val == 2) {
        title = "Lowa";
      } else if (val == 3) {
        title = "Bottecchia";
      }

      String description = _generateRandomDescription(val);

      Coupons newCoupon = Coupons(null, title, description);

      await Provider.of<DatabaseRepository>(context, listen: false)
          .insertCoupons(newCoupon);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AchievementsPage()));
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
          onPressed: () async {
            List<Totalcal> lista = await Provider.of<DatabaseRepository>(context, listen: false).findAllTotalCal();
            int CalAmountNow = lista.last.amount;
            Totalcal totalcal = Totalcal(null, CalAmountNow-25000);
            await Provider.of<DatabaseRepository>(context, listen: false).insertCal(totalcal);
            SharedPreferences ps = await SharedPreferences.getInstance();
                    // check if i've already made a donation
                    if (ps.getInt("counter") == null) {
                      ps.setInt(
                          'counter', 1);
                    } else {
                      int counter = ps.getInt("counter")!;
                      ps.setInt('counter',
                          counter + 1);
                    }
            _couponGeneration(context, currentValue);
          },
          child: Icon(Icons.done),
        ),
      ],
    );
  }
}

String _generateRandomDescription(double val) {
  int codice = Random().nextInt(2);
  String description = '';
  if (val == 1) {
    // Nike
    if (codice == 0) {
      description = 'Get a 10% discount on shoes department';
    } else if (codice == 1) {
      description = 'Get a 15% discount on running department';
    } else if (codice == 2) {
      description = 'Ticket for the next limited edition shoes raffle';
    }
  } else if (val == 2) {
    // Lowa
    if (codice == 0) {
      description = 'Get a 25% discount on trekking department';
    } else if (codice == 1) {
      description = 'Get a 15% discount on children department';
    } else if (codice == 2) {
      description = 'Free pair of socks on your next purchase';
    }
  } else if (val == 3) {
    // Bottecchia
    if (codice == 0) {
      description = 'Get a 30% discount on your next e-bike purchase';
    } else if (codice == 1) {
      description = 'Get a 15% discount on technical clothing';
    } else if (codice == 2) {
      description = 'Ticket for limited edition bike lottery';
    }
  }
  ;

  return description;
}
