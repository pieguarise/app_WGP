import 'package:app_calorie/pages/achievementsPage.dart';
import 'package:app_calorie/pages/home.dart';
import 'package:app_calorie/pages/instructionsPage.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key}) : super(key: key);

  static const UserpageName = 'UserPage';

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weigthController = TextEditingController();
  final TextEditingController heigthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    retrieveValues();
  }

  @override
  Widget build(BuildContext context) {
    print('${UserPage.UserpageName} built');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange.shade300,
          iconTheme:
              const IconThemeData(color: Color.fromARGB(255, 230, 81, 0)),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 500,
                  height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.shade200,
                        const Color.fromARGB(255, 255, 255, 255)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    
                    Text('${nickNameController.text=='' ? '${nameController.text}' : '${nameController.text} (${nickNameController.text})'}',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 70,
                      child: Image.asset(
                        'assets/batman.webp',
                      ),
                    ),
                  ])),
              Container(
                  width: 350,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          MdiIcons.human,
                          color: Colors.orange,
                        ),
                        hintText: 'Name',
                      ),
                      controller: nameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          MdiIcons.emoticonCoolOutline,
                          color: Colors.orange,
                        ),
                        hintText: 'NickName',
                      ),
                      controller: nickNameController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          MdiIcons.cake,
                          color: Colors.orange,
                        ),
                        hintText: 'Age',
                      ),
                      controller: ageController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          MdiIcons.weightKilogram,
                          color: Colors.orange,
                        ),
                        suffix: Text(
                          'kg',
                          style: TextStyle(color: Colors.black),
                        ),
                        hintText: 'Weigth',
                      ),
                      controller: weigthController,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(
                          MdiIcons.tapeMeasure,
                          color: Colors.orange,
                        ),
                        suffix: Text(
                          'cm',
                          style: TextStyle(color: Colors.black),
                        ),
                        hintText: 'Heigth',
                      ),
                      controller: heigthController,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences ps =
                              await SharedPreferences.getInstance();
                          ps.setString('name', nameController.text);
                          ps.setString('nickName', nickNameController.text);
                          ps.setString('age', ageController.text);
                          ps.setString('weigth', weigthController.text);
                          ps.setString('heigth', heigthController.text);
                          setState(() {});
                          
                          // if first time using, after inputing data I go to InstructionsPage
                          if (ps.getBool('firstTime') == null) {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => InstructionsPage()));
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ])),
            ],
          ),
        ));
  }

  void retrieveValues() async {
    final ps = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = ps.getString('name') ?? '';
      nickNameController.text = ps.getString('nickName') ?? '';
      ageController.text = ps.getString('age') ?? '';
      weigthController.text = ps.getString('weigth') ?? '';
      heigthController.text = ps.getString('heigth') ?? '';
    });
  }
}
