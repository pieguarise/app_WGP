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
      Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
              decoration: const InputDecoration(
            icon: Icon(
              Icons.monetization_on,
              color: Colors.orange,
            ),
            hintText:
                "Select the import - TO DO - IMPLEMENTAZIONE DEL CONTROLLO SULL'IMPORTO",
          )))
    ]);
  }
}
