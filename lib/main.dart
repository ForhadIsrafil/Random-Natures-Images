import 'dart:math';
import 'package:flutter/material.dart';
import 'package:random_nature/models/imageDataModel.dart';
import 'package:random_nature/utils/image_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Natures',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Random Natures'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<ImageLink> ImageData;
  Random random = Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ImageData = getImageData();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            letterSpacing: 10,
          ),
        ),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: GestureDetector(
        onTap: () {
          Future.delayed(const Duration(seconds: 2), () {
            setState(() {
              ImageData = getImageData();
            });
          });
        },
        child: Container(
          color: Color.fromARGB(random.nextInt(255), random.nextInt(255),
              random.nextInt(255), random.nextInt(255)),
          // padding: const EdgeInsets.all(8),
          // Change button text when light changes state.
          child: FutureBuilder<ImageLink>(
            future: ImageData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    padding: const EdgeInsets.all(5.0),
                    children: [
                      Text(
                        snapshot.data!.description,
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.teal,
                          // letterSpacing: 5.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        snapshot.data!.alt_description.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          // letterSpacing: 5.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 55.0),
                        child: Image.network(snapshot.data!.small_image_url),
                      )
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                // return Text("${snapshot.error}");
                return Container(
                  // height: 350.0,
                  // width: 450.0,
                  // decoration: BoxDecoration(
                  //   color: Colors.red,
                  //   border: Border.all(
                  //     color: Colors.blueGrey,
                  //     width: 6.0,
                  //   ),
                  //   shape: BoxShape.rectangle,
                  //   borderRadius: BorderRadius.circular(15.0),
                  // ),
                  alignment: Alignment.center,
                  // margin: const EdgeInsets.only(top: 20.0),
                  // padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    "Failed To Load Data",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 20.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0),
                  ),
                );
              }
              // By default, show a loading spinner/Progress.
              return const LinearProgressIndicator();
            },
          ),
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
