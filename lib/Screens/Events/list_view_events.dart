import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/constants.dart';
import 'package:flutter/material.dart';

class ListViewEvents extends StatefulWidget {
  @override
  _ListViewEventsState createState() => _ListViewEventsState();
}

class _ListViewEventsState extends State<ListViewEvents> {
  var titleList = [
    "Whole blood",
    "Platelets",
    "Plasma",
    "Whole blood",
    "Platelets",
    "Plasma",
  ];

  var descList = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque auctor.",
  ];

  var imgList = [
    "assets/icons/event.png",
    "assets/icons/event.png",
    "assets/icons/event.png",
    "assets/icons/event.png",
    "assets/icons/event.png",
    "assets/icons/event.png",
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(
        //     "Events List",
        //   ),
        //   automaticallyImplyLeading: false,
        // ),
        body: Container(
      // height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            painter: HeaderCurvedContainer(),
          ),
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
              top: 65,
              bottom: 55,
            ),
            // padding: EdgeInsets.all(70.0),
            child: Text(
              "Upcoming Events",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: imgList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialogFunc(context, imgList[index], titleList[index],
                        descList[index]);
                  },
                  child: Container(
                    width: 140,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: <Widget>[
                            Wrap(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child:
                                          Image.asset('assets/icons/event.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            titleList[index],
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: width,
                                            child: Text(
                                              // descList[index],
                                              "Show more information",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}

showDialogFunc(context, img, title, desc) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: kPrimaryLightColor,
              ),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      img,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text(
                        "Warsaw, Wojskowa 15",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range_outlined),
                      Text(
                        "15/05/2020, 16:30:00",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[500],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
