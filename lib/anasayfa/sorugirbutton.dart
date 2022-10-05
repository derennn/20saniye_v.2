import 'package:flutter/material.dart';
import 'package:yirmibir_saniye/globals.dart';

class SoruGir extends StatefulWidget {
  const SoruGir({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  State<SoruGir> createState() => _SoruGirState();
}

class _SoruGirState extends State<SoruGir> {
  final sorugirController = TextEditingController();
  bool tamamButonuState = false;

  @override
  void dispose() {
    sorugirController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sorugirController.addListener(() {
      setState(() {
        tamamButonuState = sorugirController.text.isNotEmpty;
      });
    });
  }

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
          widget.content,
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
                          'Soru gir',
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
                            controller: sorugirController,
                            onChanged: (value) {
                              setSheetState(() {});
                            },
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 5),
                              hintText: '20 saniye içinde kaç tane...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: tamamButonuState
                              ? () {
                                  buildShowDialog(context);
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
    ).whenComplete(() => sorugirController.clear());
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Sorulara eklendi!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          backgroundColor: defaultGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: defaultOrangeColor),
              child: Text(
                'Tamam',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    ).whenComplete(() => sorugirController.clear());
  }
}
