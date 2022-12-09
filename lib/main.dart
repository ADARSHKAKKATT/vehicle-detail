import 'package:flutter/material.dart';
import 'package:model_vehcle/model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Vehcle(),
    );
  }
}

class Vehcle extends StatefulWidget {
  const Vehcle({Key? key}) : super(key: key);

  @override
  State<Vehcle> createState() => _VehcleState();
}

class _VehcleState extends State<Vehcle> {
  List<Icon> symbol = [];
  int nextq = 0;

  bool selectedAns = false;

  List<Demo> car = [
    Demo(img: "image/h_eon.jpg", det: "Hyundai EON", ans: true),
    Demo(img: "image/h_i20.jpg", det: "Ford Figo", ans: false),
    Demo(img: "image/m_alto.jpg", det: "TATA Altroz", ans: false),
    Demo(img: "image/m_brezza.jpg", det: "Maruthi Brezza", ans: true),
    Demo(img: "image/t_altroz.jpg", det: "TATA Sumo", ans: false),
    Demo(img: "image/m_swift.jpg", det: "Maruthi Swift", ans: true),
    Demo(img: "image/m_wagonr.jpg", det: "Maruthi WagonR", ans: true),
    Demo(img: "image/t_nexon.jpg", det: "Maruthi Alto", ans: false),
    Demo(img: "image/t_harrier.jpg", det: "TATA Harrier", ans: true),
  ];

  void nextquestion() {
    if (nextq < car.length - 1) {
      nextq++;
    }
  }

  String? questionText() {
    return car[nextq].det;
  }

  bool? correctanswer() {
    return car[nextq].ans;
  }

  bool? finished() {
    if (nextq == car.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  int? reset() {
    nextq = 0;
  }

  void checkAnswer(bool userPickedAnswer) {
    bool? ans = correctanswer();
    setState(() {
      if (finished() == true) {
        // print("success");
        Alert(
          context: context,
          title: 'Finished !!!',
          desc: 'Reach end of Quiz',
        ).show();
        reset();
        symbol = [];
      } else {
        if (userPickedAnswer == correctanswer()) {
          symbol.add(
            Icon(
              Icons.check,
              color: Colors.green,
              size: 50,
            ),
          );
          print("true");
        } else {
          symbol.add(
            Icon(
              Icons.close,
              color: Colors.red,
              size: 50,
            ),
          );
          print("false");
        }
        nextquestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3D0202),
      appBar: AppBar(
        backgroundColor: Color(0xff3D0202),
        title: Text(
          "Car Details",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(car[nextq].img),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              height: 80,
              width: double.maxFinite,
              // color: Colors.white,
              child: Center(
                child: Text(
                  "${car[nextq].det}",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAns = true;
                      if (car[nextq].ans == true) {}
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(color: Colors.green),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "True",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedAns = false;
                      if (car[nextq].ans == false) {}
                    });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(color: Colors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "False",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(onPressed: () {
            setState(() {
              checkAnswer(selectedAns);
            });
            if (finished() == true) {
              Alert(
                  context: context,
                  title: 'Finished',
                  desc: 'End of your turn!!!');
            /*  reset();
              symbol = [];*/
            }
          }, child: Text("Check"),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(

              children: symbol,
            ),
          )
        ],
      ),
    );
  }
}
