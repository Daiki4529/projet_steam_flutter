import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum AppIcons {
  back("res/svg/back.svg"),
  close("res/svg/close.svg"),
  emptyLike("res/svg/empty_like.svg"),
  emptyWishlist("res/svg/empty_wishlist.svg"),
  likeFull("res/svg/like_full.svg"),
  like("res/svg/like.svg"),
  wishlistFull("res/svg/wishlist_full.svg"),
  wishlist("res/svg/wishlist.svg");

  final String assetPath;
  const AppIcons(this.assetPath);

  Widget get icon => SvgPicture.asset(assetPath);
}