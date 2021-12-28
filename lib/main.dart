import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final isDialOpen = ValueNotifier(false);

  OverlayEntry? entry;
  Offset offset = Offset(20, 40);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        floatingActionButton: SpeedDial(
          // animatedIcon: AnimatedIcons.menu_close,
          icon: Icons.share,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          spacing: 12,
          spaceBetweenChildren: 12,
          closeManually: true,
          onOpen: () => print("Open"),
          onClose: () => print("Close"),
          openCloseDial: isDialOpen,
          children: [
            SpeedDialChild(
                child: Icon(Icons.mail),
                label: "Mail",
                backgroundColor: Colors.red,
                onTap: () => print("Tap")),
            SpeedDialChild(
                child: Icon(Icons.move_to_inbox),
                label: "Moving",
                backgroundColor: Colors.green,
                onTap: showOverlay),
            SpeedDialChild(
              child: Icon(FontAwesomeIcons.facebook),
              label: "FaceBoot",
              backgroundColor: Colors.green,
            ),
            SpeedDialChild(
                child: Icon(FontAwesomeIcons.youtube),
                label: "Youtube",
                backgroundColor: Colors.red,
                onTap: () => print("Tap")),
          ],
        ),
      ),
    );
  }

  void showOverlay() {
    entry = OverlayEntry(
        builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy,
          child: GestureDetector(
            onPanUpdate: (details){
              setState(() {
                offset += details.delta;
              });
              
              entry!.markNeedsBuild();
            },
            child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.tap_and_play),
                label: Text("MovingButton")),
          ),
        ));

    final overlay = Overlay.of(context)!;
    overlay.insert(entry!);
  }
}
