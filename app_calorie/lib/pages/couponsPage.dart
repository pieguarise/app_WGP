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
          title: const Text('My Coupons'),
        ),
        body: Consumer<CouponsList>(builder: (context, totalCoupons, child) {
          return Column(
            children: [
              FutureBuilder(
                  future: SharedPreferences.getInstance(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final sp = snapshot.data as SharedPreferences;
                      if (sp.getDouble('donation') == null) {
                        sp.setDouble('donation', 0);
                        return const Text(
                          'DONATION = 0 \$',
                          style: TextStyle(fontSize: 25),
                        );
                      } else {
                        final donat = sp.getDouble('donation')!;
                        return Text(
                          'Donation = $donat \$',
                          style: const TextStyle(fontSize: 25),
                        );
                      }
                    } else {
                      return const Text(
                          'DONATION = 0 \$',
                          style: TextStyle(fontSize: 25),
                        );
                    }
                  })),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: totalCoupons.myCoupons.length,
                  itemBuilder: (BuildContext context, int index) {
                    //return totalCoupons.myCoupons[index].coup;
                    return ListTile(
                      leading: (totalCoupons.myCoupons[index].immagine),
                      trailing: ElevatedButton(
                          child:
                              const Text('USE', style: TextStyle(fontSize: 13)),
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
                  }),
            ],
          );
        }));
  }
}
