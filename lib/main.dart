import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI Calculator",
      home: BmiApp(),
    );
  }
}

class BmiApp extends StatefulWidget {
  const BmiApp({Key? key}) : super(key: key);

  @override
  State<BmiApp> createState() => _BmiAppState();
}

class _BmiAppState extends State<BmiApp> {
  final _height = TextEditingController();
  final _weight = TextEditingController();
  String _message = 'Please enter your height an weight';
  double? _bmi;
  void _calculate() {
    final double? height = double.tryParse(_height.value.text);
    double? weight = double.tryParse(_weight.value.text);

    // Check if the inputs are valid
    if (height == null || height <= 0 || weight == null || weight <= 0) {
      setState(() {
        _message = "Your height and weigh must be positive numbers";
      });
      return;
    }
    setState(() {
      _bmi = weight / (height * height);
      if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'Your body is fine';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else {
        _message = 'You are obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Center(
        child: Card(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                      labelText: 'Height'
                  ),
                  controller: _height,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Weight',
                  ),
                  controller: _weight,
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    _calculate();
                  },
                  child: const Text("Calculate"),
              ),
              Text(
                _bmi == null ? 'No Result' : _bmi!.toStringAsFixed(2),
                style: const TextStyle(fontSize: 50),
                textAlign: TextAlign.center,
              ),
              Text(
                _message,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


