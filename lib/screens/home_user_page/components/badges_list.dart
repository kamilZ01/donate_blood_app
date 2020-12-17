import 'package:donate_blood/Screens/home_user_page/components/badge_detail_page.dart';
import 'package:donate_blood/Screens/home_user_page/components/data.dart';
import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BadgesList extends StatefulWidget {
  final int bloodAmount;
  final String gender;
  BadgesList(this.bloodAmount, this.gender);

  @override
  _BadgesListState createState() => _BadgesListState();
}

class _BadgesListState extends State<BadgesList> {
  List<BadgesInfo> currentBadges = new List();
  @override
  Widget build(BuildContext context) {
    currentBadges.clear();
    switch(widget.gender){
      case 'male':{
        if(widget.bloodAmount >= badges[0].minBloodForMale)
          currentBadges.add(badges[0]);
        if(widget.bloodAmount >= badges[1].minBloodForMale)
          currentBadges.add(badges[1]);
        if(widget.bloodAmount >= badges[2].minBloodForMale)
          currentBadges.add(badges[2]);
        break;
      }
      case 'female':{
        if(widget.bloodAmount >= badges[0].minBloodForFemale)
          currentBadges.add(badges[0]);
        if(widget.bloodAmount >= badges[1].minBloodForFemale)
          currentBadges.add(badges[1]);
        if(widget.bloodAmount >= badges[2].minBloodForFemale)
          currentBadges.add(badges[2]);
        break;
      }
    }

    return Container(
      height: 410,
      padding: const EdgeInsets.only(left: 25.0),
      child: Swiper(
        loop: false,
        itemCount: currentBadges.length,
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
                    badgesInfo: currentBadges[index],
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
                          borderRadius: BorderRadius.circular(32.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              currentBadges[index].name,
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
                    currentBadges[index].iconImage,
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
