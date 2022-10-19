import 'package:flutter/material.dart';
import 'anasayfa/oyunabaslabutton.dart';
import 'package:yirmibir_saniye/globals/globals.dart';
import 'anasayfa/nasiloynanirbutton.dart';
import 'anasayfa/sorugirbutton.dart';
import 'anasayfa/ayarlarbutton.dart';
import 'package:yirmibir_saniye/globals/categories.dart' as categories;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'KurriIsland',
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(),
        //'BetEkrani': (context) => BetEkrani(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
    _categoriesToggle();
  }

  Future<void> _categoriesToggle() async {
    final prefs = await SharedPreferences.getInstance();
    for (var index = 0; index < categories.categoriesMap.length; index++) {
      categories.categoriesMap[index] = (prefs.getBool('$index') ?? true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Scaffold(
          backgroundColor: arkaplanColor,
          body: Body(
            baslik1: '20\nSaniye',
          ),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    required this.baslik1,
    Key? key,
  }) : super(key: key);

  final String baslik1;



  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 140,
          left: 10,
          right: 10,
          child: Baslik(baslik: baslik1),
        ),
        Positioned(
          top: 375,
          left: 60,
          right: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              OyunaBasla(buttonName: 'Oyuna Başla'),
              SizedBox(
                height: 18,
              ),
              NasilOynanir(content: 'Nasıl Oynanır'),
              SizedBox(
                height: 18,
              ),
              SoruGir(content: 'Soru Gir'),
              SizedBox(
                height: 18,
              ),
              Ayarlar(content: 'Ayarlar'),
            ],
          ),
        ),
        const Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Icon(
            Icons.play_arrow_rounded,
            size: 50,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class Baslik extends StatelessWidget {
  const Baslik({
    Key? key,
    required this.baslik,
  }) : super(key: key);

  final String baslik;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: 325,
          height: 190,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: yirmisaniyebaslikColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            baslik,
            style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            textScaleFactor: 4.5,
            textAlign: TextAlign.center,
          ),
        ),
        Row(
          children: const [
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ],
    );
  }
}
