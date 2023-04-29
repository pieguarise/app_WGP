import 'package:flutter/material.dart';
import 'package:app_calorie/models/training.dart';



Widget _toDisplayText(List<Training> recentTrainings){
  if (compareTrainings(recentTrainings)){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Congratulations!",
            style: TextStyle(
              color: Colors.orange,
              fontSize: 22,
              fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 8),
          Text(
            "Your last recent training session was the best among your last five.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF424242),
              fontSize: 20,
              fontStyle: FontStyle.italic)
          ),
          SizedBox(height: 10),
          Text(
            "WE WILL DOUBLE YOUR DONATION!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24,
              fontWeight: FontWeight.bold)
          ),
        ],
      ),
    );
  } else {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Good job!",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 23,
            fontWeight: FontWeight.w600)
        ),
        SizedBox(height: 8),
        Text(
          "Reminder: When your most recent training session is the best among your last 5 session, we will DOUBLE your donation",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF424242),
            fontSize: 20,
            fontStyle: FontStyle.italic)
        )
      ],
    );
  }
}


class HomePage extends StatefulWidget {
  static const route = '/HomePage/';
  static const routeDisplayName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              textAlign: TextAlign.center,
              'Calories consumed in your last training session:',
              style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 20
                )),
            const SizedBox(height: 10),
            Text(
             '${sessions1[0].calories} calories',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 20),

            Container(
              color: Colors.orange.shade200,
              child: Center(child: const Text("Graph here")),
              height: 280,
              width: 400,
            ),
            
            const SizedBox(height: 10),

            _toDisplayText(sessions1),

            const SizedBox(height: 25),
    
            SizedBox(
              width:200,
              height:50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0))),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'DONATE  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                        )),
                    Icon(
                      Icons.monetization_on_outlined,
                      color: Colors.white,
                      size: 33,
                      )
                  ],
                ),
              ),
            )
            //CustomPlot(data: data)
          ],
        ),
      ),
    );
  
  }
}