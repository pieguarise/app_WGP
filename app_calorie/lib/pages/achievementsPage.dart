import 'package:app_calorie/pages/couponsPage.dart';
import 'package:flutter/material.dart';
import 'package:app_calorie/widgets/radialScoreBoard.dart';
import 'package:app_calorie/models/training.dart';

class AchievementsPage extends StatelessWidget {
  AchievementsPage({Key? key}) : super(key: key);

  static const AchievementsPageName = 'AchievementsPage';

  @override
  Widget build(BuildContext context) {
    //print('${AchievementsPage.AchievementsPageName} built');
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          Container(
              width: 700,
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
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'YOUR KCAL COUNTER',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        width: 280,
                        height: 280,
                        child: scoreBoard(context, session: sessions2))
                  ])),
          bottomFullBarSection(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CouponsPage())),
          child: const Icon(Icons.done),
          //Provider.of<Cart>(context, listen: false).clearCart(),
        ));
  }
}

//Page

class bottomFullBarSection extends StatelessWidget {
  bottomFullBarSection({super.key});

  int? currentValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Congratulations!',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        const Text(
          'select the member to get the discount!',
          style: TextStyle(
              fontSize: 15, color: Colors.grey, fontStyle: FontStyle.italic),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
              height: 250, width: 350, child: const listViewMembers()),
        ),
      ],
    );
  }
}

class listViewMembers extends StatefulWidget {
  const listViewMembers({super.key});

  @override
  State<listViewMembers> createState() => _listViewMembersState();
}

class _listViewMembersState extends State<listViewMembers> {
  final List<String> _members = ['Nike', 'Lowa', 'Bottecchia'];
  final List<double> _membNum = [1, 2, 3];
  //final List<bool> members_bool = [false, false, false];
  List<String> pathsImages = [
    'assets/nike.png',
    'assets/lowa.png',
    'assets/bottecchia.png',
  ];

  num? currentValue;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
