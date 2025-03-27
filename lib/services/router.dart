import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_steam/pages/temp_game_details_page.dart';
import 'package:projet_steam/pages/home_page.dart';
import 'package:projet_steam/pages/like_list.dart';
import 'package:projet_steam/pages/wish_list.dart';

import '../components/game_details_loader.dart';

final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
        routes: <RouteBase>[
          GoRoute(
            path: "likelist",
            builder: (BuildContext context, GoRouterState state) {
              return LikeList();
            }
          ),
          GoRoute(
              path: "wishlist",
              builder: (BuildContext context, GoRouterState state) {
                return WishList();
              }
          ),
          GoRoute(
              path: "game/:id",
              builder: (BuildContext context, GoRouterState state) {
                // use state.params to get router parameter values
                final id = state.pathParameters["id"];
                return GameDetailsLoader(
                    appId: id!,
                    builder: (context, gameDetails) {
                      return GameDetailsPage(gameDetails: gameDetails);
                    }
                );
              },
          )
        ]
      )
    ]
);