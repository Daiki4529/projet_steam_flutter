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
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Nom de l'éditeur",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Prix : 10.00",
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsetsDirectional.only(
                start: 25,
                end: 25
              ),
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
              "En savoir\nplus",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            )
          )
        ],
      ),
    );
  }
}
