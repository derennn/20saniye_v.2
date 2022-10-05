import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/globals.dart';
import 'dart:async';
import 'package:yirmibir_saniye/scoreboard_ekrani.dart';

class GeriSayim extends StatefulWidget {
  GeriSayim({
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
  State<GeriSayim> createState() => GeriSayimState();
}

class GeriSayimState extends State<GeriSayim> {

  Timer? _timer;
  int start = 20;
  static int bittiButonunaBasildiMi = 1;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (Timer timer) {
        if (start == 0 && bittiButonunaBasildiMi == 1) {
          buildShowModalBottomSheetOyunaBasla(context);
          setState(() {
            timer.cancel();
          });
        } else if (bittiButonunaBasildiMi == 1) {
          setState(() {
            start--;
          });
        }
        else if (bittiButonunaBasildiMi == 2) {
          setState(() {
            start = start;
          });
        }
        else if (bittiButonunaBasildiMi ==3) {
          setState(() {
            timer.cancel();
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 230,
        width: 230,
        padding: const EdgeInsets.only(top: 50,bottom: 20),
        decoration: ShapeDecoration(
          shape: const CircleBorder(),
          color:defaultOrangeColor,
          shadows: [
            BoxShadow(
              color:defaultOrangeColor.withOpacity(0.1),
              spreadRadius: 6,
              blurRadius: 40,
            ),
          ],
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          alignment: Alignment.center,
          child: Text(
            '$start',
            style: const TextStyle(color: Colors.white),
          ),
        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ScoreBoardEkrani(round: widget.round,oyuncuAdedi: widget.oyuncuAdedi,karsilasanOyuncu1: widget.karsilasanOyuncu1, karsilasanOyuncu2: widget.karsilasanOyuncu2,);
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
                    onPressed: () {},
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
    );
  }
}