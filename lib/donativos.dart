import 'package:flutter/material.dart';

class Donativos extends StatefulWidget {
  final donativos;
  Donativos({Key? key, required this.donativos}) : super(key: key);

  @override
  State<Donativos> createState() => _DonativosState();
}

class _DonativosState extends State<Donativos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Donativos Obtenidos'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              ListTile(
                leading: Image.asset("assets/paypal.png"),
                trailing: Text(
                  "${widget.donativos["paypal"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              ListTile(
                leading: Image.asset("assets/credit_card.png"),
                trailing: Text(
                  "${widget.donativos["tarjeta"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(
                  Icons.attach_money_sharp,
                  size: 64,
                ),
                trailing: Text(
                  "${widget.donativos["acumulado"] ?? 0.0}",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              Column(
                children: <Widget>[
                  if (widget.donativos["acumulado"] >= 10000)
                    Image.asset("assets/thank_you.png"),
                ],
              )
            ],
          ),
        ));
  }
}
