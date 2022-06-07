import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/controllers/poke_list_controller.dart';
import 'package:pokedex/views/poke_list_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PokeListController(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (context) => PokeListController(),
          lazy: true,
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 680),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Pokedex',
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonList = Provider.of<PokeListController>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Lottie.asset(
                'assets/lottie_anims/loading_pokeball.json',
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.7,
                animate: true,
                controller: _controller,
                addRepaintBoundary: false,
                onLoaded: (composition) {
                  _controller!
                    ..duration = composition.duration
                    ..repeat(
                      reverse: false,
                    )
                    ..forward()
                    ..addListener(() {
                      if (_controller!.isCompleted) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PokeHomePage()));
                      }
                    });
                },
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Center(
              child: Text(
                'Lazy\'s Pokedex',
                style: GoogleFonts.arbutus(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.height * 0.04,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
