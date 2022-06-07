import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/components/color_lib.dart';
import 'package:pokedex/components/type_pill.dart';
import 'package:pokedex/controllers/pokemon_controller.dart';
import 'package:provider/provider.dart';

class PokemonView extends StatelessWidget {
  PokemonView({Key? key, required this.name, required this.url})
      : super(key: key);
  String name, url;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonController(),
      child: Pokemon(
        name: name,
        url: url,
      ),
    );
  }
}

class Pokemon extends StatefulWidget {
  Pokemon({Key? key, required this.name, required this.url}) : super(key: key);
  String name, url;

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  @override
  void initState() {
    super.initState();
    final pokemonController =
        Provider.of<PokemonController>(context, listen: false).isLoading
            ? null
            : Provider.of<PokemonController>(context, listen: false);
    pokemonController?.getPokemon(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    List icons = [
      Icons.favorite_border,
      Icons.favorite,
    ];
    ;
    final pokemonController = Provider.of<PokemonController>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => pokemonController.isLoading
          ? Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child:
                    Lottie.asset('assets/lottie_anims/loading_pokeball.json'),
              ),
            )
          : pokemonController.pokemon == null
              ? const Scaffold(
                  body: Center(
                    child: Text('No pokemon'),
                  ),
                )
              : Scaffold(
                  backgroundColor: ColorFromPokemonType.getColor(
                      pokemonController.pokemon!.types[0]),
                  appBar: AppBar(
                    elevation: 0,
                    leading: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    centerTitle: false,
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.sp,
                          vertical: 15.sp,
                        ),
                        child: Text(widget.name,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                    backgroundColor: Colors.transparent,
                    title: Text(
                      pokemonController.pokemon!.name.replaceFirst(
                        pokemonController.pokemon!.name[0],
                        pokemonController.pokemon!.name[0].toUpperCase(),
                      ),
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 29,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  body: Stack(
                    fit: StackFit.loose,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset(
                              'assets/pokeball.png',
                              height: ScreenUtil().setHeight(170),
                              alignment: Alignment.topRight,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(120),
                          left: ScreenUtil().setWidth(7),
                          right: ScreenUtil().setWidth(7),
                        ),
                        child: SizedBox(
                          width: ScreenUtil().screenWidth,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  ScreenUtil().setWidth(20),
                                ),
                                topRight: Radius.circular(
                                  ScreenUtil().setWidth(20),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ListView(
                                    padding: EdgeInsets.all(10.sp),
                                    children: [
                                      SizedBox(height: 80.h),
                                      SizedBox(
                                        height: 35.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return Row(
                                                  children: [
                                                    TypePill(
                                                      type: pokemonController
                                                          .pokemon!
                                                          .types[index]
                                                          .type
                                                          .name,
                                                      color: ColorFromPokemonType
                                                          .getColor(
                                                              pokemonController
                                                                      .pokemon!
                                                                      .types[
                                                                  index]),
                                                    ),
                                                    SizedBox(width: 10.w),
                                                  ],
                                                );
                                              },
                                              itemCount: pokemonController
                                                  .pokemon!.types.length,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        "About",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20.sp,
                                          color: ColorFromPokemonType.getColor(
                                              pokemonController
                                                  .pokemon!.types[0]),
                                        ),
                                      ),
                                      SizedBox(height: 10.h),
                                      Expanded(
                                        flex: 1,
                                        child: GridView.count(
                                          mainAxisSpacing: 10.w,
                                          padding: EdgeInsets.all(10.w),
                                          crossAxisCount: 3,
                                          children: [
                                            PokemonInfo(
                                              title: "Height",
                                              value:
                                                  '${pokemonController.pokemon!.height.toString()} m',
                                            ),
                                            PokemonInfo(
                                              title: "Weight",
                                              value:
                                                  '${pokemonController.pokemon!.weight.toString()} KG',
                                            ),
                                            PokemonInfo(
                                              title: "Abilities",
                                              value: pokemonController
                                                  .pokemon!.abilities
                                                  .map((e) => e.ability.name)
                                                  .join("\n"),
                                            ),
                                            SizedBox(),
                                            Text(
                                              "Base Stats",
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20.sp,
                                                color: ColorFromPokemonType
                                                    .getColor(pokemonController
                                                        .pokemon!.types[0]),
                                              ),
                                            ),
                                            SizedBox(),
                                            PokemonInfo(
                                              title: "HP",
                                              value: pokemonController
                                                  .pokemon!.stats[5].baseStat
                                                  .toString(),
                                            ),
                                            PokemonInfo(
                                              title: "Attack",
                                              value: pokemonController
                                                  .pokemon!.stats[4].baseStat
                                                  .toString(),
                                            ),
                                            PokemonInfo(
                                              title: "Defense",
                                              value: pokemonController
                                                  .pokemon!.stats[3].baseStat
                                                  .toString(),
                                            ),
                                            PokemonInfo(
                                              title: "Sp. Attack",
                                              value: pokemonController
                                                  .pokemon!.stats[2].baseStat
                                                  .toString(),
                                            ),
                                            PokemonInfo(
                                              title: "Sp. Defense",
                                              value: pokemonController
                                                  .pokemon!.stats[1].baseStat
                                                  .toString(),
                                            ),
                                            PokemonInfo(
                                              title: "Speed",
                                              value: pokemonController
                                                  .pokemon!.stats[0].baseStat
                                                  .toString(),
                                            ),
                                          ],
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            pokemonController.pokemon!.sprites.frontDefault,
                            fit: BoxFit.cover,
                            height: ScreenUtil().setHeight(230),
                            alignment: Alignment.topRight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

  PokemonInfo({required String title, required String value}) {
    var pokemonController = Provider.of<PokemonController>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: ColorFromPokemonType.getColor(
                pokemonController.pokemon!.types[0]),
            fontSize: 15.sp,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          value.toString(),
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
          ),
        ),
      ],
    );
  }
}
