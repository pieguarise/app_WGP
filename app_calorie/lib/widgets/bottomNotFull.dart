import 'package:app_calorie/pages/couponsPage.dart';
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
          fontSize: 25,
        ),
      ),
      const SizedBox(
        height: 5,
      ),
      const Text(
        "DON'T WORRY you can still donate money if you want!",
        style: TextStyle(
            fontSize: 15,
            color: Color.fromARGB(255, 90, 88, 88),
            fontStyle: FontStyle.italic),
      ),
      const SizedBox(
        height: 18,
      ),
      Container(
        width: 320,
        height: 250,
        child: Card(
            color: Colors.orange.shade100,
            elevation: 10,
            child: Column(children: [
              const SizedBox(
                height: 5,
              ),
              const Text('Donate',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Fight with us against hunger!!",
                style: TextStyle(
                    color: Colors.orange,
                    fontSize: 18,
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
                      hintText:
                          "Select the import",
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Equivalenza kcal-€ -TODO......',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
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
                    SharedPreferences ps = await SharedPreferences.getInstance();
                    ps.setDouble('donation', double.parse(donationValue.text));
                    ps.remove('donation');
                    print('${ps.getDouble('donation')}');
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CouponsPage()));
                  }
                },
                child: const Icon(Icons.done),
              )
            ])),
      )
    ]);
  }
}
