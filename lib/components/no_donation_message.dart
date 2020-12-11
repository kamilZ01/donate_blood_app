import 'package:donate_blood/generated/l10n.dart';
import 'package:flutter/material.dart';

class NoDonationMessage extends StatefulWidget {
  @override
  _NoDonationMessageState createState() => _NoDonationMessageState();
}

class _NoDonationMessageState extends State<NoDonationMessage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                  text: S.current.youHaveNotDonated,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                TextSpan(
                  text: S.current.blood,
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: S.current.yetOne,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: S.current.blood,
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: S.current.donationCanSaveUpToThree,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: S.current.lives,
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: S.current.forSomeoneYour,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: S.current.blood,
                  style: TextStyle(
                    color: Colors.red,
                    // fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                  text: S.current.isTheBestGiftEver,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
