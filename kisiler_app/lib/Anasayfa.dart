import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kisiler_app/KisiDetaySayfa.dart';
import 'package:kisiler_app/KisiKayitSayfa.dart';
import 'package:kisiler_app/Kisilerdao.dart';
import 'package:kisiler_app/filmler.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  Future<List<Kisiler>> tumKisileriGoster() async {
    var kisiListesi = Kisilerdao().tumKisiler();

    return kisiListesi;
  }

  Future<List<Kisiler>> aramaYap(String aramaKelimesi) async {
    var kisiListesi = Kisilerdao().kisiArama(aramaKelimesi);

    return kisiListesi;
  }

  Future<void> sil(int kisi_id) async {
    await Kisilerdao().kisiSil(kisi_id);
    setState(() {});
  }

  Future<bool> uygulamayiKapat() async {
    await exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              uygulamayiKapat();
            },
            icon: Icon(
              Icons.arrow_back,
            )),
        title: aramaYapiliyorMu
            ? TextField(
                decoration: InputDecoration(
                  hintText: "aramak için bir şey giriniz",
                ),
                onChanged: (aramaSonucu) {
                  print("arama sonucu : $aramaSonucu");
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Text("Kişiler Uygulaması"),
        backgroundColor: Colors.blue,
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                  icon: Icon(
                    Icons.cancel,
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                  ))
        ],
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Kisiler>>(
          future:
              aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKisileriGoster(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var kisiListesi = snapshot.data;
              return ListView.builder(
                itemCount: kisiListesi?.length,
                itemBuilder: (context, index) {
                  var kisi = kisiListesi?[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Kisidetaysayfa(
                                    kisi: kisi,
                                  )));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              kisi!.kisi_ad,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(kisi.kisi_tel),
                            IconButton(
                                onPressed: () {
                                  sil(kisi.kisi_id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Kisikayitsayfa()));
        },
        tooltip: "Kişi ekle",
        child: Icon(Icons.add),
      ),
    );
  }
}
