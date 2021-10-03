
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import '../UsersScreens/checkInternet.dart';




class PDFScreen extends StatefulWidget {
  final String path;

  PDFScreen({Key key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {

  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  initState(){
    super.initState();
    CheckInternet().checkConnection(context);
  }
  @override
  void dispose() {
    CheckInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Certifecation"),
        actions: <Widget>[

        ],
      ),
      body:  widget.path!=""? const PDF().fromUrl(widget.path):Center(
        child: Text("didn't add cetifecation yet!"),
      ),
    );
  }
}