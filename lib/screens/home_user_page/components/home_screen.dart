import 'package:donate_blood/components/header_curved_container.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:donate_blood/screens/home_user_page/components/user_information.dart';
import 'package:donate_blood/screens/profile_details/components/user_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'badge_detail_page.dart';
import 'data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }

  ScrollController controller = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            CustomPaint(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              painter: HeaderCurvedContainer(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
            ),
            Column(
              children: [
                UserDetail(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Text(
                      S.current.recentDonations,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                UserInformation(controller),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 25,
                        ),
                        child: Text(
                          S.current.yourBadges,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 410,
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Swiper(
                        itemCount: badges.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                            color: Colors.grey,
                            activeSize: 15,
                            space: 5,
                          ),
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => DetailPage(
                                    badgesInfo: badges[index],
                                  ),
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(height: 100),
                                    Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(32.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            SizedBox(
                                              height: 100,
                                            ),
                                            Text(
                                              badges[index].name,
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                fontSize: 25,
                                                color: const Color(0xff47455f),
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  S.current.readMore,
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    fontSize: 18,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    badges[index].iconImage,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
