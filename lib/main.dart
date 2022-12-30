import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:app_gpt/openai/completions_api.dart';
import 'package:app_gpt/theme/theme.dart';
import 'package:app_gpt/theme/gradients/time_gradient.dart';

void main() {
  runApp(MyApp());
}

String nam = 'raghav';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppGPT',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State {
  // final myController = TextEditingController();
  int tok = 500;
  String outD = '';

  outDisplay(String value) async {
    // setState(() async {
    //   outD = await CompletionsApi.outDisplay(1000, value);
    //   debugPrint("Testing output '$outD'");
    // });
    if (value == '') {
      tok = 0;
    } else {
      tok = 500;
    }
    debugPrint('value');
    String val = await CompletionsApi.outDisplay(tok, value);
    setState(() {
      outD = val;
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   myController.addListener(outDisplay);
  //   // setState(() {
  //   //   outD = "Raghav";
  //   //   // outD = CompletionsApi.outDisplay(25, myController.text).toString();
  //   // });
  // }

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the widget tree.
  //   // This also removes the _printLatestValue listener.
  //   myController.dispose();
  //   super.dispose();
  // }

  // void outDisplay() {
  //   setState(() {
  //     outD = CompletionsApi.outDisplay(25, myController.text).toString();
  //     debugPrint("Testing output $outD");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: TimeGradient(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.6,
                        // child: FittedBox(
                        //   fit: BoxFit.fitWidth,
                        child: TextField(
                          // controller: myController,
                          onSubmitted: (value) => outDisplay(value),
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter a search term',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // 'Hello',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        // ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: FractionallySizedBox(
                        widthFactor: 0.8,
                        // child: FittedBox(
                        //   fit: BoxFit.fitWidth,
                        child: Text(
                          '$outD',
                          // state.dailyForecast ?? Strings.noWeather,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
