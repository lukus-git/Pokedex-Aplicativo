import 'package:flutter/material.dart';
import 'package:pokedex/common/models/pokemon.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/widgets/detail_appbar_widget.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/widgets/detail_info_widget.dart';
import 'package:pokedex/features/pokedex/screens/details/pages/widgets/detail_list_widget.dart';

class DetailPage extends StatefulWidget {
  DetailPage({
    super.key,
    required this.pokemon,
    required this.list,
    this.onBack,
    required this.controller,
    required this.onChangePokemon,
    this.isDiff = false,
  });

  final Pokemon pokemon;
  final List<Pokemon> list;
  final VoidCallback? onBack;
  final PageController controller;
  final ValueChanged<Pokemon> onChangePokemon;
  final bool isDiff;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late ScrollController scrollController;
  bool isOnTop = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (notification) {
          setState(
            () {
              if (scrollController.position.pixels > 37) {
                isOnTop = false;
              } else if (scrollController.position.pixels <= 36) {
                isOnTop = true;
              }
            },
          );

          return false;
        },
        child: CustomScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          slivers: [
            DetailAppbarWidget(
              pokemon: widget.pokemon,
              onBack: widget.onBack,
              isOnTop: isOnTop,
            ),
            DetailList(
              pokemon: widget.pokemon,
              list: widget.list,
              controller: widget.controller,
              onChangePokemon: widget.onChangePokemon,
              isDiff: widget.isDiff,
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Container(
                      color: widget.pokemon.baseColor,
                    ),
                    DetailInfoWidget(
                     pokemon: widget.pokemon,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
