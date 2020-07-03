import 'package:flutter/material.dart';

class Barchart extends StatefulWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  Barchart(this.label, this.spendingAmount, this.spendingPercent);

  @override
  _BarchartState createState() => _BarchartState();
}

class _BarchartState extends State<Barchart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${widget.spendingAmount.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          width: 18,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                  heightFactor: widget.spendingPercent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(widget.label)
      ],
    );
  }
}
