import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/globals.dart';

class NasilOynanir extends StatelessWidget {
  const NasilOynanir({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;
  final List nasiloynanir = const [
    'Nasıl Oynanır?',
    'Hakem sizsiniz, hangi cevapların kabul edileceğine karar vermek sizin elinizde!',
    '''• Kaç kişi olduğunuzu girin.
• Tüm oyuncular kendine oyuncu sayısı dahilinde birer sayı seçsin (örneğin 6 kişi oynanıyorsa herkes 1’den 6’ya kadar bir sayı seçsin).
• Oyun her roundda rastgele 2 kişiyi eşleştirecek. Eşleşen kişiler ekrandaki soruyu gördükten sonra açık artırmaya başlasın.
• Rakibinizin sayamayacağı bir sayı söylediğini düşündüğünüzde “lie!” diyin ve Başla! butonuna basın.
• Başla butonuna basıldığında en yüksek sayıyı söyleyen oyuncunun 20 saniyelik süresi başlar. Bu süre içinde dediği kadar sayabilirse bete giren oyuncu, sayamazsa diğer oyuncu kazanır.
• Kazanan 1 puan alır, sıradaki maç dediğinizde oyun rastgele farklı iki oyuncuyu eşleştirir ve yeni round başlar, toplamda 5 puan olan oyunu kazanır.
''',
    '• Açık arıtırma sırasında oyuncular uzun süre düşünmeden hızlıca tekliflerini söylemelidir.'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: defaultGreyColor),
      child: TextButton(
        onPressed: () {
          buildShowModalBottomSheet(context);
        },
        style: TextButton.styleFrom(
          foregroundColor: arkaplanColor,
        ),
        child: Text(
          content,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          textScaleFactor: 1.7,
        ),
      ),
    );
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
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
        return Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 15, bottom: 25),
              child: Column(
                children: [
                  Image.asset(
                    'images/sliding_line.png',
                    scale: 0.9,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    nasiloynanir[0],
                    style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    nasiloynanir[1],
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500, height: 1.2),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: nasiloynanir[2],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2),
                              ),
                              TextSpan(
                                text: nasiloynanir[3],
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: defaultOrangeColor,
                                    height: 1.2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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