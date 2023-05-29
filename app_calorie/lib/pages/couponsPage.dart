import 'package:app_calorie/models/coupon.dart';
import 'package:app_calorie/models/couponsList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CouponsPage extends StatelessWidget {
  int? val;
  CouponsPage({Key? key, this.val}) : super(key: key);
  //static const CouponspageName = 'CouponsPage';

  @override
  Widget build(BuildContext context) {
    //print('${CouponsPage.CouponspageName} built');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
        ),
        body: Consumer<CouponsList>(builder: (context, totalCoupons, child) {
          return Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Colors.orange.shade100,
              const Color.fromARGB(255, 255, 255, 255)
            ], begin: Alignment.topCenter, end: Alignment.center)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Achievements',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Donations',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Center(
                    child: FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            final sp = snapshot.data as SharedPreferences;
                            if (sp.getDouble('donation') == null) {
                              sp.setDouble('donation', 0);
                              return const Text(
                                "You've totally donated:  0\$",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              );
                            } else {
                              final donat = sp.getDouble('donation')!;
                              return Text(
                                "You've totally donated:  $donat\$",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              );
                            }
                          } else {
                            return const Text(
                              "You've totally donated:  0\$",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            );
                          }
                        })),
                  ),
                  SizedBox(height: 20),
                  Text('Coupons',
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  toDisplayCoupons(totalCoupons),
                ],
              ),
            ),
          );
        }));
  }

  Widget toDisplayCoupons(CouponsList totalCoupons) {
    if (totalCoupons.myCoupons.length > 0) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: totalCoupons.myCoupons.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: (totalCoupons.myCoupons[index].immagine),
              trailing: ElevatedButton(
                  child: const Text('USE', style: TextStyle(fontSize: 13)),
                  onPressed: () {
                    String message =
                        'Congratulations, you used the ${totalCoupons.myCoupons[index].title} coupon';
                    Provider.of<CouponsList>(context, listen: false)
                        .deleteCoupon(index);
                    ScaffoldMessenger.of(
                      context,
                    )
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(content: Text(message)));
                  }),
              title: Text(
                totalCoupons.myCoupons[index].title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(totalCoupons.myCoupons[index].description),
            );
          });
    } else {
      return Center(
        child: Text("You have not collected any coupon yet",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade700
            )),
      );
    }
  }
}
