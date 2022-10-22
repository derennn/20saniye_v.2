import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/anasayfa/oyunabaslabutton.dart';
import 'package:yirmibir_saniye/globals/globals.dart';
import 'package:yirmibir_saniye/globals/oyuncusayilari.dart';
import 'package:yirmibir_saniye/menuyedon.dart';
import 'package:yirmibir_saniye/globals/skorlar.dart' as skorlar;

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
          Positioned(
            left: 20,
            right: 20,
            top: skorlar.globalSkorTablosuMap[widget.kazanankim] == 5 ? 140 : 280,
            child: Center(
              child: skorlar.globalSkorTablosuMap[widget.kazanankim] == 5
                  ? Column(
                      children: [
                        Image.asset(
                          'images/ph_confetti.png',
                          scale: 0.8,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            'Oyuncu ${widget.kazanankim} Kazandı!',
                            style: const TextStyle(
                              fontSize: 50,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  : const Text(
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
            top: 360,
            child: Container(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              height: skorlar.globalSkorTablosuOyuncuSayisiList.length>4 ? 200 : null,
              decoration: const BoxDecoration(
                color: defaultGreyColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: RawScrollbar(
                  mainAxisMargin: 20,
                  thumbVisibility: true,
                  thumbColor: arkaplanColor.withOpacity(0.8),
                  radius: Radius.circular(3),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    shrinkWrap: true,
                    children: [
                      for (int i in skorlar.globalSkorTablosuOyuncuSayisiList)
                        SkorTablosuOyuncuIsmi(
                            oyuncuX:
                                skorlar.globalSkorTablosuOyuncuSayisiList[i - 1]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 80,
            right: 80,
            child: Center(
              child: skorlar.globalSkorTablosuMap[widget.kazanankim] == 5
                  ? OyunaBasla(buttonName: 'Yeniden Oyna')
                  : ElevatedButton(
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
                            fontSize: 25,
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

class SkorTablosuOyuncuIsmi extends StatefulWidget {
  SkorTablosuOyuncuIsmi({
    required this.oyuncuX,
    Key? key,
  }) : super(key: key);

  int oyuncuX;

  @override
  State<SkorTablosuOyuncuIsmi> createState() => _SkorTablosuOyuncuIsmiState();
}

class _SkorTablosuOyuncuIsmiState extends State<SkorTablosuOyuncuIsmi> {
  final playerNameController = TextEditingController();
  bool tamamButtonState = false;

  @override
  void dispose() {
    playerNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    playerNameController.addListener(() {
      setState(() {
        tamamButtonState = playerNameController.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        buildShowModalBottomSheet(context);
      },
      style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          padding: const EdgeInsets.only(left: 15, right: 30)),
      child: Column(
        children: [
          Row(
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
                skorlar.updatedPlayerNames.containsKey(widget.oyuncuX) ?
                '${skorlar.updatedPlayerNames[widget.oyuncuX]}' : 'Oyuncu ${widget.oyuncuX}:',
                style: const TextStyle(color: Colors.black, fontSize: 24),
              ),
              const Spacer(),
              Text(
                '${skorlar.globalSkorTablosuMap[widget.oyuncuX]}',
                style: const TextStyle(color: Colors.black, fontSize: 28),
              ),
            ],
          ),
          widget.oyuncuX == skorlar.globalSkorTablosuOyuncuSayisiList.last ?
            const SizedBox(
              height: 10,
              ) :
            const Divider(height: 10, thickness: 1.5)
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: defaultGreyColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setSheetState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      const Text(
                        'Oyuncu Adını Değiştir',
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 340,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: TextField(
                          controller: playerNameController,
                          onChanged: (value) {
                            setSheetState(() {});
                          },
                          decoration: const InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 10, bottom: 5),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: tamamButtonState ?
                            () {
                          skorlar.updatedPlayerNames[widget.oyuncuX] = playerNameController.text;
                          Navigator.pop(context);
                            }
                        : null,
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(120, 45),
                          backgroundColor: defaultOrangeColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                        ),
                        child: const Text(
                          'Tamam',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
      },
    ).whenComplete(() {
      playerNameController.clear();
    });
  }
}