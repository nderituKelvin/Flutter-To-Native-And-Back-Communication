import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Native to Dart Communication',
            theme: ThemeData(
                primarySwatch: Colors.blue,
            ),
            home: MyHomePage(title: 'Native to Dart Communication'),
        );
    }
}

class MyHomePage extends StatefulWidget {
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    String theMessage = "No Message Yet";
    static const platForm = const MethodChannel('flutter.native/helper');
    @override
    Widget build(BuildContext context) {
        platForm.setMethodCallHandler(_handleNativeMessage);
        return Scaffold(
            appBar: AppBar(
                title: Text(widget.title),
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            theMessage,
                            style: Theme.of(context).textTheme.display1,
                        ),
                    ],
                ),
            ),

            floatingActionButton: FloatingActionButton(
                child: Icon(
                    Icons.message
                ),
                onPressed: (){
                    communicate();
                }
            ),
        );
    }

    Future<dynamic> _handleNativeMessage(MethodCall call) async{
        switch(call.method){
            case "helloFromJava":
                debugPrint(call.arguments);
        }
    }

    Future<void> communicate() async{
        String response = "";
        setState(() {
          theMessage = "Invoking";
        });
        try{
            final String result = await platForm.invokeMethod('helloFromNativeCode');
            response = result;
            setState(() {
              theMessage = response;
            });
        }on PlatformException catch(e){
            setState(() {
                theMessage = "Invokation Error: "+e.message;
            });
        }
    }
}
