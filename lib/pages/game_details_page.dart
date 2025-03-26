import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_steam/assets/app_icons.dart';
import 'package:projet_steam/models/game_details.dart';

class ProductPageWithTabs extends StatefulWidget {
  static const double kImageHeight = 450.0;
  final GameDetails gameDetails;

  ProductPageWithTabs({super.key, required this.gameDetails});

  @override
  State<ProductPageWithTabs> createState() => _ProductPageWithTabsState();
}

class _ProductPageWithTabsState extends State<ProductPageWithTabs> {
  int _selectedTabIndex = 0;
  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a2025),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1a2025),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: AppIcons.back.icon,
              onPressed: () => context.pop(),
            ),
            title: Text(
              widget.gameDetails.gameName,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              IconButton(
                icon: AppIcons.like.icon,
                onPressed: () {},
              ),
              IconButton(
                icon: AppIcons.wishlist.icon,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              widget.gameDetails.background,
              width: double.infinity,
              height: ProductPageWithTabs.kImageHeight - 100,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.2),
              colorBlendMode: BlendMode.srcATop,
            ),
          ),
          Positioned.fill(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: ProductPageWithTabs.kImageHeight - 30),
                  Container(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - (ProductPageWithTabs.kImageHeight - 30),
                    ),
                    child: _Body(selectedTabIndex: _selectedTabIndex, onTabSelected: _onTabSelected, gameDetails: widget.gameDetails),
                  ),
                ],
              ),
            ),
          ),

          // Game info card
          Positioned(
            top: ProductPageWithTabs.kImageHeight - 150,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                width: 320,
                height: 120,
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2b343c),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Game image
                    ClipRRect(
                      child: Image.network(
                        widget.gameDetails.coverImage,
                        width: 70,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.gameDetails.gameName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 6.0),
                          Text(
                            widget.gameDetails.editors.join(", "),
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final GameDetails gameDetails;

  const _Body({
    required this.selectedTabIndex,
    required this.onTabSelected,
    required this.gameDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A2025),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.indigo.shade400, width: 2),
              ),
              child: Row(
                children: [
                  _buildTab(0, 'DESCRIPTION'),
                  _buildTab(1, 'AVIS'),
                ],
              ),
            ),
          ),

          Offstage(
            offstage: selectedTabIndex != 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                children: [
                  Html(
                    data: gameDetails.longDescription,
                    style: {
                      "body": Style(fontSize: FontSize(15), color: Colors.white),
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Offstage(
            offstage: selectedTabIndex != 1,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: _ReviewsContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(int index, String title) {
    final isSelected = selectedTabIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTabSelected(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo.shade400 : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewsContent extends StatelessWidget {
  const _ReviewsContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReview(
          username: 'Nom de l\'utilisateur',
          rating: 5,
          comment: 'Bacon ipsum dolor amet rump doner brisket corned beef tri-tip. Burgdoggen t-bone leberkas, tri-tip bacon beef ribs...',
        ),
      ],
    );
  }

  Widget _buildReview({
    required String username,
    required int rating,
    required String comment,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF252D35),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5,
                  (index) => Icon(
                Icons.star,
                color: index < rating ? Colors.amber : Colors.grey.shade700,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            comment,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}