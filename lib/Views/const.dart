import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const api_url = "https://varmalaa.com/api/Demo/";
const appcolor = Color(0xFF17C5CC);
const primaryColor = Color(0xFF842269);
const secondaryColor = Color(0xFF6C4D74);
const primaryColor_bg = Color(0xFFFAE8F5);

//const razorpay_key = "rzp_test_LZrNqWO50uBv8W";

const razorpay_key = "rzp_live_a7hAodDx96wDap";

const String currency = "₹";

pr(values) => print(values);

divider() => Divider(
      color: Colors.grey,
      thickness: 0.5,
      height: 3,
    );
divider2() => Divider(
      color: Colors.grey,
      thickness: 0.3,
      height: 3,
    );
divider3() => Divider(
      color: Colors.grey,
      height: 0,
      thickness: 0.5,
    );

textDecoration(hint) => InputDecoration(
      fillColor: Colors.white,
      // prefixIcon: Icon(icon, color: black,),
      filled: true,
      contentPadding: EdgeInsets.only(left: 10),
      // contentPadding: EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
      hintText: (hint),
      hintStyle: TextStyle(
        color: primaryColor,
        fontSize: 16.0,
      ),
      border: new OutlineInputBorder(
        borderSide: new BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedErrorBorder: new OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      errorBorder: new OutlineInputBorder(
        borderSide: new BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 1),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
