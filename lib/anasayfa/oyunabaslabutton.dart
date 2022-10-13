import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yirmibir_saniye/bet_ekrani.dart';
import 'package:yirmibir_saniye/globals/globals.dart';
import 'package:yirmibir_saniye/globals/oyuncusayilari.dart';
import 'package:yirmibir_saniye/scoreboard_ekrani.dart';
import 'package:yirmibir_saniye/globals/skorlar.dart' as skorlar;

class OyunaBasla extends StatefulWidget {
  const OyunaBasla({
    required this.buttonName,
    Key? key,
  }) : super(key: key);

  final String buttonName;

  @override
  State<OyunaBasla> createState() => OyunaBaslaState();
}

class OyunaBaslaState extends State<OyunaBasla> {
  final int startingRound = 1;
  final oyuncusayisiController = TextEditingController();
  bool baslaButonuState = false;
  late int oyuncuAdedi;
  late List<int> karsilasanOyuncularList;

  @override
  void dispose() {
    oyuncusayisiController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    oyuncusayisiController.addListener(() {
      if (oyuncusayisiController.text.isNotEmpty && int.parse(oyuncusayisiController.text)>1 && int.parse(oyuncusayisiController.text)<21) {
        setState(() {
          baslaButonuState = true;
        });
      }
      else {
        baslaButonuState = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: defaultOrangeColor,
      ),
      child: TextButton(
        onPressed: () {
          buildShowModalBottomSheetTamam(context);
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
        ),
        child: Text(
          '${widget.buttonName}',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheetTamam(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: defaultGreyColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        const Text(
                          'Oyuncu Sayısını Girin',
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
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            controller: oyuncusayisiController,
                            onChanged: (value) {
                              setSheetState(() {});
                            },
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 5),
                              hintText: 'Kaç kişisiniz?',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: baslaButonuState
                              ? () {
                                  oyuncuAdedi = int.parse(oyuncusayisiController.text);
                                  karsilasanOyuncularList = OyuncuSayilariClass(oyuncuadedi: oyuncuAdedi).oyuncuIsimleriFunc();
                                  skorlar.globalSkorTablosuOyuncuSayisiList = List<int>.generate(oyuncuAdedi!, (int index) => index + 1);
                                  skorlar.globalSkorTablosuMap = skorlar.globalSkorTablosuFunc();
                                  print('${skorlar.globalSkorTablosuMap}');
                                  buildShowModalBottomSheetBasla(context, startingRound, oyuncuAdedi, karsilasanOyuncularList[0], karsilasanOyuncularList[1]);
                                  skorlar.updatedPlayerNames.clear();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(120, 45),
                            backgroundColor: defaultOrangeColor,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
          },
        );
      },
    ).whenComplete(
      () {
        listoflists.clear();
        oyuncusayisiController.clear();
        print('modalbottomkapandi');
      },
    );
  }

  Future<dynamic> buildShowModalBottomSheetBasla(BuildContext context,
      int round, int? oyuncuAdedi, int? oyuncu1, int? oyuncu2) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: defaultGreyColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      )),
      builder: (context) {
        return Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.center,
          children: [
            Container(
              height: 221,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Karşılaşma $round',
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      //'${country.data.last.population != null ? country.data.last.population : 'noData'}',
                      '${skorlar.updatedPlayerNames.containsKey(oyuncu1) ? skorlar.updatedPlayerNames[oyuncu1] : 'Oyuncu ${oyuncu1}'}'
                      ' vs '
                      '${skorlar.updatedPlayerNames.containsKey(oyuncu2) ? skorlar.updatedPlayerNames[oyuncu2] : 'Oyuncu ${oyuncu2}'}',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return BetEkrani(
                                  round: round,
                                  oyuncuAdedi: oyuncuAdedi,
                                  karsilasanOyuncu1: oyuncu1,
                                  karsilasanOyuncu2: oyuncu2);
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(120, 45),
                        backgroundColor: defaultOrangeColor,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                      ),
                      child: const Text(
                        'Başla!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
