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
  List<BadgesInfo> badgesList = [];
  @override
  Widget build(BuildContext context) {
    badgesList.clear();
    switch (widget.gender) {
      case 'male':
        {
          if (widget.bloodAmount >= badges[2].minBloodForMale)
            badgesList.add(badges[2]);
          if (widget.bloodAmount >= badges[1].minBloodForMale)
            badgesList.add(badges[1]);
          if (widget.bloodAmount >= badges[0].minBloodForMale)
            badgesList.add(badges[0]);
          break;
        }
      case 'female':
        {
          if (widget.bloodAmount >= badges[2].minBloodForFemale)
            badgesList.add(badges[2]);
          if (widget.bloodAmount >= badges[1].minBloodForFemale)
            badgesList.add(badges[1]);
          if (widget.bloodAmount >= badges[0].minBloodForFemale)
            badgesList.add(badges[0]);
          break;
        }
    }
    //print("ilosc odznak + " + badgesList.length.toString());

    return Column(
      children: [
        if (badgesList.length > 0)
          Container(
            height: 410,
            padding: const EdgeInsets.only(left: 25.0),
            child: buildBadgesSwiper(context),
          )
        else
          new Container(
            margin: EdgeInsets.only(left: 35, right: 10, bottom: 10),
            child: Text(S.current.noBadgesMessage,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                    fontSize: 16)),
          ),
      ],
    );
  }

  Swiper buildBadgesSwiper(BuildContext context) {
    return Swiper(
            loop: true,
            itemCount: badgesList.length,
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
                        badgesInfo: badgesList[index],
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
                                  badgesList[index].name,
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
                      child: Image.asset(badgesList[index].iconImage,
                          //width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.25),
                    ),
                  ],
                ),
              );
            },
          );
  }
}
