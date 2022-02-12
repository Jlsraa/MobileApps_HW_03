import 'package:flutter/material.dart';
import 'package:tarea_03/donativos.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? currentSelectionRadio;
  var totalPaypal = 0.0;
  var totalTarjeta = 0.0;
  var currentDropdownValue;
  var donacionTotal = 0.0;
  var progress = 0.0;

  var assetsRadioGroup = {
    0: "assets/paypal.png",
    1: "assets/credit_card.png",
  };

  var radioGroup = {
    0: "Paypal",
    1: "Tarjeta",
  };

  var dropItemsGroup = {
    0: 100,
    1: 350,
    2: 850,
    3: 1050,
    4: 9999,
  };

  List<Widget> radioGroupGenerator() {
    return radioGroup.entries
        .map(
          (radioItem) => ListTile(
            leading: Image.asset(
              assetsRadioGroup[radioItem.key]!,
              height: 64,
              width: 44,
            ),
            title: Text("${radioItem.value}"),
            trailing: Radio(
                value: radioItem.key,
                groupValue: currentSelectionRadio,
                onChanged: (int? newSelectedRadio) {
                  currentSelectionRadio = newSelectedRadio;
                  setState(() {});
                }),
          ),
        )
        .toList();
  }

  // Dropdown esta conformado por una lista
  dropDownItemsGenerator() {
    return dropItemsGroup.entries //Cada linea dentro del mapa
        .map((e) => DropdownMenuItem(
              child: Text(e.value.toString()),
              value: e.value,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donaciones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Es para una buena causa",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              "Elija modo de donativo",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 30),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.black45,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: radioGroupGenerator(),
                ),
              ),
            ),
            Container(
              child: ListTile(
                title: Text("Cantidad a donar:"),
                trailing: DropdownButton(
                  items: dropDownItemsGenerator(),
                  value: currentDropdownValue,
                  onChanged: (selected) {
                    currentDropdownValue = selected;
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    minHeight: 20,
                    value: progress,
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    "${progress}%",
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () {
                  if (currentSelectionRadio == 0) {
                    totalPaypal += currentDropdownValue;
                  } else {
                    totalTarjeta += currentDropdownValue;
                  }
                  donacionTotal = totalPaypal + totalTarjeta;
                  progress += (donacionTotal * 100) / 10000;
                  if (progress >= 100) {
                    progress = 100;
                  }

                  setState(() {});
                },
                child: Text(
                  "Donar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text(
          '+',
          style: TextStyle(fontSize: 35),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Donativos(
                donativos: {
                  "paypal": totalPaypal,
                  "tarjeta": totalTarjeta,
                  "acumulado": donacionTotal,
                  "metaCumplida": donacionTotal >= 10000 ? true : false,
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
