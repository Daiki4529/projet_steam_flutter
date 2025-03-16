import 'package:flutter/material.dart';

class CardGame extends StatelessWidget {
  final String gameName;

  const CardGame({super.key, required this.gameName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        start: 10,
        top: 5,
        end: 10,
        bottom: 5
      ),
      width: double.infinity,
      height: 125,
      decoration: BoxDecoration(
        color: Color(0xFF182332),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        children: [
          Image.asset(
            'res/img/destiny2.jpg',
            width: 100,
            height: 100,
          ),
          SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$gameName",
                style: TextStyle(color: Colors.white)
              ),
              Text(
                "Nom de l'éditeur",
                style: TextStyle(color: Colors.white)
              ),
              Text(
                "Prix : 10.00",
                style: TextStyle(color: Colors.white)
              )
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: Color(0xFF4800FF),
              minimumSize: Size(120,double.infinity),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(5)
                )
              )
            ),
            child: Text(
              "En savoir plus",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              )
            )
          )
        ],
      ),
    );
  }
}
