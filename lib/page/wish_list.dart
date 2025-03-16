import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
              color: Colors.white,
              iconSize: 30,
            ),
            Text(
              'Ma liste de souhaits',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        centerTitle: false,
        backgroundColor: Color(0xFF111822),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF131B27)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'res/svg/wishlist.svg',
              width: 100,
              height: 100,
            ),
            Text(
              "Vous n'avez encore pas liké de contenu.",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "Cliquez sur l'étoile pour en rajouter.",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
