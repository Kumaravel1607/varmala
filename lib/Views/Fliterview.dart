import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Occupation.dart';
import 'package:varamala/Views/Astro.dart';
import 'package:varamala/Views/Caste.dart';
import 'package:varamala/Views/Community.dart';
import 'package:varamala/Views/Frontpage.dart';
import 'package:varamala/Views/Profession.dart';
import 'package:varamala/Views/const.dart';

import 'Marital.dart';

class Fliterview extends StatefulWidget {
  @override
  _FliterviewState createState() => _FliterviewState();
}

class _FliterviewState extends State<Fliterview> {
  List<Occupation> _professiontype = [];
  List<Occupation> communitytype = [];
  List<Occupation> castetype = [];
  void initState() {
    super.initState();
    _professiontype = [];
    communitytype = [];
    castetype = [];
    _getocc();
    _getcas();
    _getcom();
  }

  _getocc() {
    Service.getprof().then((users) {
      setState(() {
        _professiontype = users;
      });

      print(_professiontype.length);
    });
  }

  _getcom() {
    Service.getcom().then((users) {
      setState(() {
        communitytype = users;
      });

      print(communitytype.length);
    });
  }

  _getcas() {
    Service.getcas().then((users) {
      setState(() {
        castetype = users;
      });

      print(castetype.length);
    });
  }

  List flittertype = [
    "Astro Status",
    "Marital Status",
    "Profession",
    "Community",
    "Caste",
    "Religion",
    "Nationality"
  ];
  List Astrotype = [
    "Anshik Manglik",
    "Manglik",
    "Non-Manglik",
    "Do Not Believe"
  ];
  List maritaltype = [
    "Never Married",
    "Divorced",
    "Waiting for Divorce",
    "Widowed"
  ];
  List Agetype = ["18-25", "25-30", "30-35", "40+"];
  List religiontype = [
    "Hindhu",
    "Muslim",
    "Sikh",
    "Jain",
    "Buddhist",
    "Christians",
    "Parsi",
    "Jewish",
    "Non-Religious",
    "Others"
  ];
  List Nationalitytype = ["Indian", "NRI", "Both"];

  int _pageController = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      astro(),
      marital(),
      Profession(),
      Community(),
      Caste(),
      Religion(),
      Nationality()
    ];
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Fliters"),
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            tooltip: 'Menu Icon',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Frontpage()));
            },
          ),
        ),
        body: Center(
            child: Row(
          children: <Widget>[
            Container(
              child: ListView.builder(
                  itemCount: flittertype.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _pageController = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          flittertype[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
              color: primaryColor.withOpacity(0.5),
              height: size.height,
              width: size.width * 0.4,
            ),
            // Container(height: size.height,width: 10, child: VerticalDivider(color: primaryColor)),
            Expanded(
              child: Container(
                child: _pages[_pageController],
                color: Colors.white,
                height: size.height,
              ),
            ),
          ],
        )),
      ),
      debugShowCheckedModeBanner: false,
    );
  }

  Widget astro() {
    return ListView.builder(
        itemCount: Astrotype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Astro(index: (index + 1).toString())));
              },
              child: Text(
                Astrotype[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget marital() {
    return ListView.builder(
        itemCount: maritaltype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Marital(index: (index + 1).toString())));
              },
              child: Text(
                maritaltype[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget Age() {
    return ListView.builder(
        itemCount: Agetype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Agetype[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }

  Widget Profession() {
    return ListView.builder(
        itemCount: _professiontype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Professions(index: (index + 1).toString())));
              },
              child: Text(
                _professiontype[index].name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget Community() {
    return ListView.builder(
        itemCount: communitytype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Communities(index: (index + 1).toString())));
              },
              child: Text(
                communitytype[index].name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget Caste() {
    return ListView.builder(
        itemCount: castetype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        Castes(index: (index + 1).toString())));
              },
              child: Text(
                castetype[index].name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget Religion() {
    return ListView.builder(
        itemCount: religiontype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(
              child: Text(
                religiontype[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        });
  }

  Widget Nationality() {
    return ListView.builder(
        itemCount: Nationalitytype.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Nationalitytype[index],
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        });
  }
}
