import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varamala/Views/Upgradeplan.dart';
import 'package:varamala/Views/const.dart';

class PaymenError extends StatefulWidget {
  PaymenError({Key? key}) : super(key: key);

  @override
  PaymenErrorState createState() => PaymenErrorState();
}

class PaymenErrorState extends State<PaymenError> {
  bool btn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Icon(Icons.error_outlined, size: 40),
              SizedBox(
                height: 50,
              ),
              Text(
                "Transaction Failed !!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                color: primaryColor,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Upgrade()),
                      (Route<dynamic> route) => false);
                },
                child: Text(
                  "Go Back",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: RaisedButton(
              //     color: green,
              //     onPressed: (){},
              //     child: Text("Go To Home", style: TextStyle(color: white),),),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
