import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MaterialApp(home: FirstModuleApp()));

class FirstModuleApp extends StatefulWidget {
  const FirstModuleApp({super.key});

  @override
  State<StatefulWidget> createState() => _FirstModuleAppState();
}

class _FirstModuleAppState extends State<StatefulWidget> {
  // This widget is the root of your application.
  String _token = "";
  static const commonPlatform = MethodChannel('com.example.flutter_module');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String tempToken = await commonPlatform.invokeMethod('nativeMethod');
      setState(() {
        _token = tempToken;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        String tempToken = await commonPlatform.invokeMethod('nativeMethod');
        setState(() {
          _token = tempToken;
        });
      }),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('First Module App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Token received is:',
            ),
            Text(
              _token,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
      ),
    );
  }
}
