import 'package:flutter/material.dart';
import 'package:learningdart/app_colors.dart';

class CounterWidget extends StatefulWidget {
  final String cardName;

  const CounterWidget({required this.cardName, super.key});

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    print('Incremented: ${widget.cardName}, Count: $_counter');
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
    print('Decremented: ${widget.cardName}, Count: $_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _decrementCounter,
          icon: Icon(Icons.remove),
          color: Colors.red,
        ),
        Text(
          _counter.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          onPressed: _incrementCounter,
          icon: Icon(Icons.add),
          color: Colors.green,
        ),
        ElevatedButton(
          onPressed: () {
            print('Add to database: ${widget.cardName}, Count: $_counter');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.backgroundColor,
          ),
          child: Text('Add'),
        ),
      ],
    );
  }
}