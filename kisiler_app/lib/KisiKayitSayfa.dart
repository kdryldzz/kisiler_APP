import 'package:flutter/material.dart';
import 'package:kisiler_app/Anasayfa.dart';
import 'package:kisiler_app/Kisilerdao.dart';

class Kisikayitsayfa extends StatefulWidget {
  const Kisikayitsayfa({super.key});

  @override
  State<Kisikayitsayfa> createState() => _KisikayitsayfaState();
}

class _KisikayitsayfaState extends State<Kisikayitsayfa> {
  var tfKisiAdi = TextEditingController();
  var tfKisiTel = TextEditingController();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await Kisilerdao().kisiEkle(kisi_ad, kisi_tel);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Anasayfa()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kişi Kayıt"),
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
          kayit(tfKisiAdi.text, tfKisiTel.text);
        },
        tooltip: "Kişi Kayıt",
        icon: Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
