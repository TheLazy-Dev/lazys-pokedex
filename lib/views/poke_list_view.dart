import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/components/api_button.dart';
import 'package:pokedex/controllers/poke_list_controller.dart';
import 'package:pokedex/views/poke_page.dart';
import 'package:provider/provider.dart';

class PokeHomePage extends StatefulWidget {
  const PokeHomePage({Key? key}) : super(key: key);

  @override
  State<PokeHomePage> createState() => _PokeHomePageState();
}

class _PokeHomePageState extends State<PokeHomePage> {
  @override
  void initState() {
    final pokemonList = Provider.of<PokeListController>(context, listen: false);
    pokemonList.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = Provider.of<PokeListController>(context);

    return Scaffold(
      body: pokemonList.isLoading
          ? Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child:
                    Lottie.asset('assets/lottie_anims/loading_pokeball.json'),
              ),
            )
          : pokemonList.pokeList == null
              ? const Center(
                  child: Text('No pokeList'),
                )
              : SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/pokeball.png',
                            height: 50.sp,
                          ),
                          SizedBox(width: 10.sp),
                          Text(
                            'Pokédex',
                            style: TextStyle(
                              fontSize: 50.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            floatingLabelStyle: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.orangeAccent,
                              fontWeight: FontWeight.bold,
                            ),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.search,
                                    color: Colors.grey, size: 24.sp),
                                SizedBox(width: 10.sp),
                                Text('Search',
                                    style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ],
                            ),
                          ),
                          onChanged: (value) {},
                          onEditingComplete: () {},
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                        ),
                        child: Divider(
                          height: 30.sp,
                          thickness: 5.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ApiButton(
                                    color: Color.fromARGB(230, 210, 177, 10),
                                    name: 'Type',
                                    path: Container()),
                                SizedBox(width: 10.sp),
                                ApiButton(
                                    color: Color.fromARGB(230, 210, 53, 10),
                                    name: 'Ability',
                                    path: Container()),
                              ],
                            ),
                            SizedBox(
                              height: 10.sp,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ApiButton(
                                    color: Color.fromARGB(230, 165, 231, 112),
                                    name: 'Generation',
                                    path: Container()),
                                SizedBox(width: 10.sp),
                                ApiButton(
                                    color: Color.fromARGB(230, 10, 200, 210),
                                    name: 'Location',
                                    path: Container()),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.sp,
                        ),
                        child: Divider(
                          height: 30.sp,
                          thickness: 5.sp,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        flex: 100,
                        fit: FlexFit.tight,
                        child: ListView.builder(
                          itemBuilder: ((context, index) {
                            final pokeList = pokemonList.pokeList!.pokeList;
                            final poke = pokeList[index];
                            return ListTile(
                              title: Text(
                                '#${index + 1} ${poke.name.replaceFirst(
                                  poke.name[0],
                                  poke.name[0].toUpperCase(),
                                )}',
                                style: GoogleFonts.poppins(fontSize: 15.h),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PokemonView(
                                        name: '#${index + 1}', url: poke.url),
                                  ),
                                );
                              },
                            );
                          }),
                          itemCount: pokemonList.pokeList!.pokeList.length,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
