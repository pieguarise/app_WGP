import 'package:flutter/material.dart';

class bottomBarNotFullSection extends StatelessWidget {
  bottomBarNotFullSection({super.key});

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
        height: 10,
      ),
      const Text(
        "DON'T WORRY you can still donate money if you want!",
        style: TextStyle(
            fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
      ),
      SizedBox(height: 30,),
      Container(
        width: 320,
        height: 200,
        child: Card(
          color: Colors.orange.shade100,
          elevation: 10,
            child: Column(children: [
              SizedBox(height: 5,),
          Text('Donation history',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
                  SizedBox(height: 10,),
          Text(
            "You've already donated: 28€",
            style: TextStyle(
                color: Colors.orange, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20,),
          SizedBox(
            width: 280,
            child: TextFormField(
                    decoration: const InputDecoration(
                  icon: Icon(
                    Icons.monetization_on,
                    color: Colors.orange,
                  ),
                  hintText:
                      "Select the import - TO DO - IMPLEMENTAZIONE DEL CONTROLLO SULL'IMPORTO",
                )),
          ),
          SizedBox(height: 20,),
          Text('Equivalenza kcal-€ -TODO......',style: TextStyle(fontSize: 20),)
        ])),
      )
    ]);
  }
}
