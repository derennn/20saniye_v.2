import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/globals.dart';
import 'gerisayim_sayaci.dart';
import 'package:yirmibir_saniye/scoreboard_ekrani.dart';
import 'package:yirmibir_saniye/menuyedon.dart';

class GeriSayimEkrani extends StatefulWidget {
  GeriSayimEkrani({
    required this.round,
    this.oyuncuAdedi,
    this.karsilasanOyuncu1,
    this.karsilasanOyuncu2,
    Key? key,
  }) : super(key: key);

  int round;
  int? oyuncuAdedi;
  int? karsilasanOyuncu1;
  int? karsilasanOyuncu2;

  @override
  State<GeriSayimEkrani> createState() => _GeriSayimEkraniState();
}

class _GeriSayimEkraniState extends State<GeriSayimEkrani> {
  int DogruYanit = 0;
  bool DY = true;

  void saymakicinbas() {
    setState(() {
      DogruYanit++;
      DY = false;
    });
  }

  void gerial() {
    while (DogruYanit > 0) {
      setState(() {
        DogruYanit--;
      });
      break;
    }
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
            top: 160,
            right: 25,
            left: 25,
            child: Text(
              '20 Saniye içinde kaç araba markası sayabilirsiniz?',
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          GeriSayim(
              round: widget.round,
              oyuncuAdedi: widget.oyuncuAdedi,
              karsilasanOyuncu1: widget.karsilasanOyuncu1,
              karsilasanOyuncu2: widget.karsilasanOyuncu2),
          Positioned(
            bottom: 40,
            right: 40,
            left: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Transform.translate(
                  offset: const Offset(0, 6),
                  child: TextButton(
                    onPressed: gerial,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                    ),
                    child: Column(
                      children: const [
                        Text(
                          'Geri Al',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(
                            Icons.u_turn_left,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: saymakicinbas,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: defaultGreyColor,
                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                    ),
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: DY
                            ? const Text('saymak\nicin\nbas',
                                textAlign: TextAlign.center)
                            : Text(
                                '$DogruYanit',
                              ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    GeriSayimState.bittiButonunaBasildiMi = 2;
                    print('${GeriSayimState.bittiButonunaBasildiMi}');
                    buildShowModalBottomSheetOyunaBasla(context);
                  },
                  child: const Text(
                    'Bitti',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheetOyunaBasla(BuildContext context) {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kim Kazandı?',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      GeriSayimState.bittiButonunaBasildiMi = 3;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScoreBoardEkrani(
                              round: widget.round,
                              oyuncuAdedi: widget.oyuncuAdedi,
                              karsilasanOyuncu1: widget.karsilasanOyuncu1,
                              karsilasanOyuncu2: widget.karsilasanOyuncu2,
                              kazanankim: widget.karsilasanOyuncu1,
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 45),
                      backgroundColor: const Color(0XFFF4A261),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: Text(
                      'Oyuncu ${widget.karsilasanOyuncu1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      GeriSayimState.bittiButonunaBasildiMi = 3;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScoreBoardEkrani(
                              round: widget.round,
                              oyuncuAdedi: widget.oyuncuAdedi,
                              karsilasanOyuncu1: widget.karsilasanOyuncu1,
                              karsilasanOyuncu2: widget.karsilasanOyuncu2,
                              kazanankim: widget.karsilasanOyuncu2,
                            );
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 45),
                      backgroundColor: const Color(0XFFF28482),
                      elevation: 0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: Text(
                      'Oyuncu ${widget.karsilasanOyuncu2}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).whenComplete(
      () {
        GeriSayimState.bittiButonunaBasildiMi = 1;
        print('${GeriSayimState.bittiButonunaBasildiMi}');
      },
    );
  }
}
