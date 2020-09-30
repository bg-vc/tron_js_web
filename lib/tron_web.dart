import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:js' as js;

class TronWeb extends StatefulWidget {
  @override
  _TronWebState createState() => _TronWebState();
}

class _TronWebState extends State<TronWeb> {
  bool tronFlag = false;
  String account = '';
  String balance = '';
  String tokenBalance = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),
          _tronWidget(context),
          SizedBox(height: 10),
          _accountWidget(context),
          SizedBox(height: 10),
          _balanceWidget(context),
          SizedBox(height: 10),
          _sendTrxWidget(context),
          SizedBox(height: 10),
          _contractBalanceOfWidget(context),
          SizedBox(height: 10),
          _contractTransferWidget(context),
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
              'tronWeb.js: ',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              tronFlag ? 'true' : 'false',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        // tronWeb.defaultAddress.base58
        var result = js.context["tronWeb"]["defaultAddress"]["base58"];
        js.context.callMethod('alert', [result]);
        setState(() {
          if (result.toString() != 'false') {
            account = result.toString();
          }
        });
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'account: ',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              //'$account',
              '#########################',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _balanceWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        js.context['setTrxBalance']=setTrxBalance;
        if (account != null && account.trim() != '' && account.trim() != 'false') {
          js.context.callMethod('getTrxBalance', [account]);
        }
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'balance: ',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '$balance TRX',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setTrxBalance(value) {
    print('setTrxBalance value:' + value.toString());
    setState(() {
      final trx = Decimal.tryParse(value?.toString());
      if (trx == null) {
      } else {
        balance = (trx / Decimal.fromInt(10).pow(6)).toString();
      }
      setState(() {});
    });
  }

  Widget _sendTrxWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        if (account != null && account.trim() != '') {
          js.context.callMethod('sendTrx', [
            'TTCT6rgLXGnoJwBuMrVqXjRyyAFgdtgHro',
            3000000]);
        }
      },
      child: Container(
        child: Chip(
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
          backgroundColor: Colors.blue[500],
          label: Text(
            'SendTRX',
            style: GoogleFonts.lato(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _contractBalanceOfWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        js.context['setTokenBalance']=setTokenBalance;
        if (account != null && account.trim() != '') {
          js.context.callMethod('contractBalanceOf', [account]);
        }
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ContractBalanceOfToken: ',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
            SizedBox(width: 10),
            Text(
              '$tokenBalance Token',
              style: GoogleFonts.lato(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setTokenBalance(value) {
    print('setTokenBalance value:' + value.toString());
    setState(() {
      tokenBalance = (Decimal.tryParse(value?.toString())/Decimal.fromInt(10).pow(6)).toString();
    });
  }

  Widget _contractTransferWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        js.context['reloadContractBalanceOf']=reloadContractBalanceOf;
        if (account != null && account.trim() != '') {
          js.context.callMethod('contractTransfer', [
            'TTCT6rgLXGnoJwBuMrVqXjRyyAFgdtgHro',
            2*1e6,
          ]);
        }
      },
      child: Container(
        child: Chip(
          padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
          backgroundColor: Colors.blue[500],
          label: Text(
            'ContractTransferOfToken',
            style: GoogleFonts.lato(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void reloadContractBalanceOf() {
    print('reloadContractBalanceOf');
    if (account != null && account.trim() != '') {
      js.context.callMethod('contractBalanceOf', [account]);
    }
  }

}
