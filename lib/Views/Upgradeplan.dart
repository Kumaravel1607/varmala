import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Membership.dart';
import 'package:varamala/Views/Payment_faild.dart';
import 'package:varamala/Views/Transcation_history.dart';

import 'package:varamala/Views/const.dart';
import 'Frontpage.dart';
import 'package:http/http.dart' as http;

class Upgrade extends StatefulWidget {
  @override
  _UpgradeState createState() => _UpgradeState();
}

class _UpgradeState extends State<Upgrade> {
  late SharedPreferences preferences;

  late Razorpay razorpay;
  @override
  void initState() {
    super.initState();
    get_plan();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  List<Membership> plan = [];
  get_plan() async {
    Service.member().then((transcation) {
      if (mounted) {
        setState(() {
          plan = transcation;
          print(transcation[0]);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  //"key": "rzp_test_LZrNqWO50uBv8W",
  //key : rzp_live_a7hAodDx96wDap

  String plan_id = "";
  var total_amount;
  void sliveropenCheckout(price, title) {
    var options = {
      "key": razorpay_key,
      "amount": num.parse(price) * 100,
      "name": "Varmalaa ",
      "description": title,
      "prefill": {"contact": "", "email": ""},
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  // void glodopenCheckout() {
  //   var options = {
  //     "key": "rzp_test_LZrNqWO50uBv8W",
  //     "amount": num.parse(gint) * 100,
  //     "name": "Varmalaa",
  //     "description": "Payment for the Order No:3",
  //     "prefill": {"contact": "", "email": ""},
  //     "external": {
  //       "wallets": ["paytm"]
  //     }
  //   };

  //   try {
  //     razorpay.open(options);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // void diamondopenCheckout() {
  //   var options = {
  //     "key": "rzp_test_LZrNqWO50uBv8W",
  //     "amount": num.parse(dint) * 100,
  //     "name": "Varmalaa",
  //     "description": "Payment for the Order No:4",
  //     "prefill": {"contact": "", "email": ""},
  //     "external": {
  //       "wallets": ["paytm"]
  //     }
  //   };

  //   try {
  //     razorpay.open(options);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void handlerPaymentSuccess(PaymentSuccessResponse response) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    print(response);
    Map data = {
      "plan_id": plan_id,
      "user_id": id,
      "razorpay_payment_id": response.paymentId,
      "total_amount": total_amount,
      "payment_status": "Success",
    };
    print(data);
    var url = "https://varmalaa.com/api/Demo/save_transcation";
    var res = await http.post(Uri.parse(url), body: data);
    print("Pament success");
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          // _loading = false;
        });

        print(jsonDecode(res.body));
        _alerBox("Payment Successfully");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => transcation_history()));
      }
    }
    Toast.show("Payment success", context);
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("Payment error");

    // Navigator.of(context, rootNavigator: true).pushReplacement(
    //     MaterialPageRoute(builder: (BuildContext context) => PaymenError()));
    // print("12345678901234567890");
    Toast.show("Payment error", context);
  }

  void handlerExternalWallet() {
    print("External Wallet");
    // Toast.show("External Wallet", context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("MEMBERSHIP PLAN"),
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Frontpage()));
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: plan.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      sliveropenCheckout(plan[index].price, plan[index].title);

                      setState(() {
                        plan_id = plan[index].id;
                        total_amount = plan[index].price;
                      });
                    },
                    child: plans(plan[index].title, plan[index].description,
                        plan[index].price));
              })
          // body: SingleChildScrollView(
          //   child: Column(
          //     children: [
          //       InkWell(
          //           onTap: () {
          //             sliveropenCheckout();
          //           },
          //           child: plans(
          //               "SLIVER PLAN",
          //               "3 Months Paid subscription with all the access everything will be visible) (Can see all the contact details, can send unlimited messages to anyone for a period of 3 months) (Including GST)..",
          //               "Price: INR 1200.00")),
          //       InkWell(
          //           onTap: () {
          //             glodopenCheckout();
          //           },
          //           child: plans(
          //               "GLOD PLAN",
          //               "6 Months Paid subscription with all the access everything will be visible) (Can see all the contact details, can send unlimited messages to anyone for a period of 6 months) (Including GST)..",
          //               "Price: INR 1800.00")),
          //       InkWell(
          //         onTap: () {
          //           diamondopenCheckout();
          //         },
          //         child: plans(
          //             "DIAMOND PLAN ",
          //             "This is a special plan for those who are not comfortable in handling online sites and its technicalities. This Plan offers you manual interventions from profile creation to personal assistance in finding a suitable match. One of our team member will be assigned to you. He/ She will forward you 3 suitable profiles with all their information weekly. this plan will be for 6 months durations (Including GST).. *Terms and Conditions Applied.",
          //             "Price: INR 5000.00"),
          //       )
          //     ],
          //   ),
          // ),
          ),
    );
  }

  Widget plans(String planname, String description, String price) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 5,
        child: Container(
          color: primaryColor.withOpacity(0.2),
          child: Column(
            children: [
              Container(
                height: 40,
                color: primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      planname,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    description,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    price.toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
