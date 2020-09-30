import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;


class TronWeb extends StatefulWidget {
  @override
  _TronWebState createState() => _TronWebState();
}

class _TronWebState extends State<TronWeb> {
  bool tronFlag = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          _tronWidget(context),
        ],
      ),
    );
  }

  Widget _tronWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          tronFlag = js.context.hasProperty('tronWeb');
          js.context.callMethod('alert', [tronFlag]);
        });
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'tronWeb.js',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              tronFlag ? 'yes' : 'no',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
