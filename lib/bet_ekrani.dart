import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/geri%20sayim%20ekrani/gerisayim_sayaci.dart';
import 'package:yirmibir_saniye/globals.dart';
import 'geri sayim ekrani/gerisayim_ekrani.dart';
import 'package:yirmibir_saniye/menuyedon.dart';
import 'package:yirmibir_saniye/skorlar.dart' as skorlar;

class BetEkrani extends StatefulWidget {
  BetEkrani({
    Key? key,
    required this.round,
    this.oyuncuAdedi,
    this.karsilasanOyuncu1,
    this.karsilasanOyuncu2,
  }) : super(key: key);

  int round;
  int? oyuncuAdedi;
  int? karsilasanOyuncu1;
  int? karsilasanOyuncu2;

  @override
  State<BetEkrani> createState() => _BetEkraniState();
}

class _BetEkraniState extends State<BetEkrani> {
  int kalanhak = 2;

  void nextround() {
    setState(() {
      widget.round++;
    });
  }

  void kalanhakfunc() {
    while (kalanhak > 0) {
      setState(() {
        kalanhak--;
      });
      break;
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: arkaplanColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const MenuyeDon(),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Karsilasma(round: widget.round, karsilasanOyuncu1: widget.karsilasanOyuncu1, karsilasanOyuncu2: widget.karsilasanOyuncu2,),
                SoruKutucugu(size: size),
                SoruyuAtla(kalanhak: kalanhak, kalanhakfunc: kalanhakfunc),
              ],
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
                  GeriSayimState.bittiButonunaBasildiMi=1;
                  nextround();
                  Navigator.push(context,
                    MaterialPageRoute(
                      builder: (context) {
                        return GeriSayimEkrani(round: widget.round, oyuncuAdedi: widget.oyuncuAdedi, karsilasanOyuncu1: widget.karsilasanOyuncu1, karsilasanOyuncu2: widget.karsilasanOyuncu2);
                      },
                    ),
                  );
                },
                child: Text(
                  'Başla!',
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

class SoruyuAtla extends StatefulWidget {
  const SoruyuAtla({
    Key? key,
    required this.kalanhakfunc,
    required this.kalanhak,
  }) : super(key: key);

  final int kalanhak;
  final VoidCallback kalanhakfunc;

  @override
  State<SoruyuAtla> createState() => _SoruyuAtlaState();
}

class _SoruyuAtlaState extends State<SoruyuAtla> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: widget.kalanhakfunc,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: const Text(
                'soruyu atla',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
            Text(
              'Kalan hakkın: ${widget.kalanhak}',
              style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 18,
                  color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class Karsilasma extends StatelessWidget {
  Karsilasma({
    Key? key,
    required this.round,
    this.karsilasanOyuncu1,
    this.karsilasanOyuncu2,
  }) : super(key: key);

  final int round;
  int? karsilasanOyuncu1;
  int? karsilasanOyuncu2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Karşılaşma $round',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textScaleFactor: 2.8,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          '${skorlar.updatedPlayerNames.containsKey(karsilasanOyuncu1) ? skorlar.updatedPlayerNames[karsilasanOyuncu1] : 'Oyuncu ${karsilasanOyuncu1}'}'
          ' vs '
          '${skorlar.updatedPlayerNames.containsKey(karsilasanOyuncu2) ? skorlar.updatedPlayerNames[karsilasanOyuncu2] : 'Oyuncu ${karsilasanOyuncu2}'}',
          style: TextStyle(color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: 26,
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}

class SoruKutucugu extends StatelessWidget {
  const SoruKutucugu({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: defaultGreyColor,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    '20 Saniye içinde kaç tane renk sayabilirsiniz?',
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.8,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Açık artırma başlasın...',
                    textScaleFactor: 1.2,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}