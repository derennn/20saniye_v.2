import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/anasayfa/oyunabaslabutton.dart';
import 'package:yirmibir_saniye/globals.dart';
import 'package:yirmibir_saniye/oyuncusayilari.dart';
import 'package:yirmibir_saniye/menuyedon.dart';
import 'package:yirmibir_saniye/skorlar.dart' as skorlar;

class ScoreBoardEkrani extends StatefulWidget {
  ScoreBoardEkrani({
    required this.round,
    this.oyuncuAdedi,
    this.karsilasanOyuncu1,
    this.karsilasanOyuncu2,
    required this.kazanankim,
    Key? key,
  }) : super(key: key);

  int round;
  int? oyuncuAdedi;
  int? karsilasanOyuncu1;
  int? karsilasanOyuncu2;
  int kazanankim;

  @override
  State<ScoreBoardEkrani> createState() => _ScoreBoardEkraniState();
}

class _ScoreBoardEkraniState extends State<ScoreBoardEkrani> {
  late List<int> karsilasanOyuncularList;

  @override
  void initState() {
    print('${skorlar.globalSkorTablosuMap}');
    skorlar.globalSkorTablosuMap[widget.kazanankim]++;
    print('${skorlar.globalSkorTablosuOyuncuSayisiList}');
    print('${skorlar.globalSkorTablosuMap}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: arkaplanColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MenuyeDon(),
          const Positioned(
            left: 0,
            right: 0,
            top: 255,
            child: Center(
              child: Text(
                'Skor Tablosu',
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            right: 30,
            top: 350,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6),
              decoration: const BoxDecoration(
                color: defaultGreyColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  for (int i in skorlar.globalSkorTablosuOyuncuSayisiList) SkorTablosuOyuncuIsmi(oyuncuX: skorlar.globalSkorTablosuOyuncuSayisiList[i-1]),
                ],
              ),

            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: defaultOrangeColor,
                  padding: EdgeInsets.all(20),
                ),
                onPressed: () {
                  print('${skorlar.globalSkorTablosuMap}');
                  print('${skorlar.globalSkorTablosuOyuncuSayisiList}');
                  karsilasanOyuncularList = OyuncuSayilariClass(oyuncuadedi: widget.oyuncuAdedi!).oyuncuIsimleriFunc();
                  OyunaBaslaState().buildShowModalBottomSheetBasla(context, widget.round, widget.oyuncuAdedi, karsilasanOyuncularList[0], karsilasanOyuncularList[1]);
                },
                child: const Text(
                  'Sıradaki Maç',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SkorTablosuOyuncuIsmi extends StatelessWidget {
  SkorTablosuOyuncuIsmi({
    required this.oyuncuX,
    Key? key,
  }) : super(key: key);

  int oyuncuX;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        splashFactory: NoSplash.splashFactory,
        padding: EdgeInsets.symmetric(horizontal: 12)
      ),
      child: Row(
        children: [
          const Icon(
            Icons.edit,
            color: Colors.black,
            size: 26,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            'Oyuncu $oyuncuX: ${skorlar.globalSkorTablosuMap[oyuncuX]}',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
