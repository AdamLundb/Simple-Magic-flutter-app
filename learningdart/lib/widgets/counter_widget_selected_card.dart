import 'package:flutter/material.dart';
import 'package:learningdart/app_colors.dart';
import 'package:learningdart/utils/collection_services.dart';
import 'package:provider/provider.dart';
import 'package:learningdart/providers/login_state_provider.dart';

class CounterWidget extends StatefulWidget {
  final String cardName;
  final String cardSet;

  const CounterWidget({required this.cardName, required this.cardSet,super.key});

  @override
  CounterWidgetState createState() => CounterWidgetState();
}

class CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _setCounterToZero () {
    setState(() {
      _counter = 0;
    });
  }

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
            print("Test");
            final userId = Provider.of<LoginStateProvider>(context, listen: false).userId!;
            final username = Provider.of<LoginStateProvider>(context, listen: false).username!;
            print('User with id: $userId and name : $username');
            addCardToCollection(userId, widget.cardName, widget.cardSet, false, _counter);
            print('User with id: $userId and name : $username added to database: ${widget.cardName}, Count: $_counter');
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