import 'package:flutter/material.dart';
import 'package:kisiler_app/Anasayfa.dart';
import 'package:kisiler_app/Kisilerdao.dart';
import 'package:kisiler_app/filmler.dart';

class Kisidetaysayfa extends StatefulWidget {
  final Kisiler kisi;

  Kisidetaysayfa({required this.kisi});

  @override
  State<Kisidetaysayfa> createState() => _KisidetaysayfaState();
}

class _KisidetaysayfaState extends State<Kisidetaysayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {
    await Kisilerdao().kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  void initState() {
    super.initState();

    var kisi = widget.kisi;
    tfKisiAdi.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Detay"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfKisiAdi,
                decoration: InputDecoration(hintText: "kişi Adı"),
              ),
              TextField(
                controller: tfKisiTel,
                decoration: InputDecoration(hintText: "kişi Tel"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          guncelle(widget.kisi.kisi_id, tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: "Kişi ekle",
        icon: Icon(Icons.update),
        label: Text("Guncelle"),
      ),
    );
  }
}
