import 'package:app_calorie/pages/achievementsPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bottomBarNotFullSection extends StatelessWidget {
  bottomBarNotFullSection({super.key});
  final TextEditingController donationValue = TextEditingController();
  int? currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        'Train More!',
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange),
      ),
      const SizedBox(
        height: 5,
      ),
      const Text(
        "To make a FREE DONATION and get a COUPON ",
        style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
      ),
      const SizedBox(
        height: 18,
      ),
      Container(
        width: 340,
        height: 250,
        child: Card(
            color: Colors.orange.shade100,
            elevation: 10,
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              const Text('Donate now',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Help World Food Program against hunger",
                style: TextStyle(
                    color: Colors.orange.shade700,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 280,
                child: TextFormField(
                    controller: donationValue,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.monetization_on,
                        color: Colors.orange,
                      ),
                      hintText: "Select the import",
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'For every 10\$ donation, WFP provides\nlifesaving meals to 35 starving people',
                style: TextStyle(color: Color(0xFF424242),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 7,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (double.tryParse(donationValue.text) == null) {
                    ScaffoldMessenger.of(
                      context,
                    )
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                          const SnackBar(content: Text('Insert a number')));
                  } else {
                    SharedPreferences ps =
                        await SharedPreferences.getInstance();
                    // check if i've already made a donation
                    if (ps.getDouble("donation") == null) {
                      ps.setDouble(
                          'donation', double.parse(donationValue.text));
                    } else {
                      double donationAmount = ps.getDouble("donation")!;
                      ps.setDouble('donation',
                          donationAmount + double.parse(donationValue.text));
                    }
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>AchievementsPage()));
                  }
                },
                child: Text('Donate',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              )
            ])),
      )
    ]);
  }
}
