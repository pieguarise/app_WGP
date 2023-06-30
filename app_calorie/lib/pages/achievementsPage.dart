import 'package:app_calorie/database/entities/entities.dart';
import 'package:app_calorie/repository/databaseRepository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementsPage extends StatelessWidget {
  AchievementsPage({Key? key}) : super(key: key);
  
  static const AchievementsPageName = 'Achievements';

  @override
  Widget build(BuildContext context) {
    print('${AchievementsPage.AchievementsPageName} built');
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
        ),
        body: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              gradient: LinearGradient(colors: [
            Colors.orange.shade100,
            const Color.fromARGB(255, 255, 255, 255)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
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
                              }
                  
                            double donat = sp.getDouble('donation')!;
                  
                            if (sp.getInt('counter') == null) {
                              sp.setInt('counter', 0);
                              }
                            
                            final counter = sp.getInt('counter');
                  
                            return Column(
                              children: [
                                Text(
                                "Yours total donation:   $donat\$",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                "Brands total donation:   ${counter!*10}\$",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                "Donated meals:    ${counter*35+ (donat/10*35).toInt()} ",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                                ),
                  
                  
                              ],
                            );
                            } else {
                            return CircularProgressIndicator();
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
                  Consumer<DatabaseRepository>(builder: (context, dbr, child) {
                    return FutureBuilder(
                        initialData: null,
                        future: dbr.findAllCoupons(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final totalCoupons = snapshot.data as List<Coupons>;
                            if (totalCoupons.isNotEmpty) {
                              return toDisplayCoupons(totalCoupons);
                            } else {
                              return Center(
                                child: Text(
                                    "You have not collected any coupon yet",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade700)),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                          
                        });
                  })
                ],
              ),
            ),
          ),
        ));
  }

  Widget toDisplayCoupons(totalCoupons) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: totalCoupons.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: _imageToDisplay((totalCoupons[index].title)),
            trailing: ElevatedButton(
                child: const Text('USE',
                    style: TextStyle(fontSize: 13, color: Colors.white)),
                onPressed: () async {
                  String message =
                      'Congratulations, you used the ${totalCoupons[index].title} coupon';
                  await Provider.of<DatabaseRepository>(context, listen: false)
                      .deleteCoupons(totalCoupons[index]);
                  ScaffoldMessenger.of(
                    context,
                  )
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(content: Text(message)));
                }),
            title: Text(
              totalCoupons[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(totalCoupons[index].description),
          );
        });
  }
}

Image _imageToDisplay(title) {
  return Image.asset("assets/${title.toLowerCase()}.png",
      width: 50, height: 50);
}
