import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:icecream_app/animated_background.dart';
import 'package:icecream_app/place_order.dart';

void main() {
  runApp(const SampleStack());
}

class SampleStack extends StatefulWidget {
  const SampleStack({super.key});

  @override
  State<SampleStack> createState() => _SampleStackState();
}

class _SampleStackState extends State<SampleStack>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;

  bool _isMoved = false;
  bool _isDarkMode = false;
  SampleScreen sampleScreen = const SampleScreen();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animation = Tween(begin: 70.0, end: 250.0).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastEaseInToSlowEaseOut))
      ..addListener(() {
        setState(() {});
      });
    _imageAnimation = Tween(begin: 60.0, end: 280.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine))
      ..addListener(() {
        setState(() {});
      });
    _textAnimation = Tween(begin: 5.0, end: 20.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic))
      ..addListener(() {
        setState(() {});
      });
  }

  void _startAnimation() {
    if (_isMoved) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isMoved = !_isMoved;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _createAnimatedCards() {
    List<Widget> cards = [];

    List<Color> colors = [
      Colors.redAccent,
      Colors.blueAccent,
      const Color.fromARGB(255, 70, 232, 153),
      Colors.orangeAccent,
      Colors.black
    ];

    List<String> images = [
      'images/icecream_category/gelato.png',
      'images/icecream_category/icePop.png',
      'images/icecream_category/shake.png',
      'images/icecream_category/cake2.png',
      'images/icecream_category/softServe.png',
    ];

    for (int i = 0; i < colors.length; i++) {
      cards.add(AnimatedCard(
        color: colors[i],
        animation: _animation,
        animationImg: _imageAnimation,
        image: images[i],
        animation1: _startAnimation,
      ));
    }

    return cards;
  }

  List<Widget> _createAnimatedTitles() {
    List<Widget> titles = [];

    List<int> energy = [1200, 1500, 1000, 980, 1360];
    List<int> calories = [150, 200, 680, 430, 310];
    List<int> calcium = [20, 15, 27, 15, 10];
    List<int> suger = [0, 10, 6, 7, 9, 11];
    List<String> title = ['Gelato', 'IcePop', 'Shake', 'Globe', 'Soft Serve'];
    for (int i = 0; i < title.length; i++) {
      titles.add(Details(
        title: title[i],
        energy: energy[i],
        calories: calories[i],
        calcium: calcium[i],
        suger: suger[i],
        animation: _animation,
        animationTxt: _textAnimation,
      ));
    }
    return titles;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> animatedCards = _createAnimatedCards();
    List<Widget> animatedtitles = _createAnimatedTitles();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            sampleScreen,
            GestureDetector(
              onTap: _startAnimation,
              child: Container(
                width: double.infinity,
                height: _animation.value + 100,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(237, 19, 239, 213),
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Color.fromARGB(237, 19, 239, 213),
                    ], end: Alignment.bottomRight, begin: Alignment.topLeft),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(150),
                        bottomLeft: Radius.circular(15))),
                child: Swiper(
                  itemCount: animatedCards.length,
                  itemBuilder: (context, index) {
                    return animatedCards[index];
                  },
                  layout: SwiperLayout.STACK,
                  itemWidth: _imageAnimation.value,
                  itemHeight: _imageAnimation.value,
                  viewportFraction: 0.3,
                  scale: 0.6,
                  fade: 0.1,
                  scrollDirection: Axis.horizontal,
                  curve: Curves.fastEaseInToSlowEaseOut,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: _startAnimation,
                child: Container(
                  width: double.infinity,
                  height: _animation.value + 100,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color.fromARGB(237, 41, 154, 210),
                        // Colors.green,
                        Colors.white,
                        Colors.white,
                        Colors.white,
                        // Colors.green,
                        Color.fromARGB(237, 41, 154, 210),
                      ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150),
                        topRight: Radius.circular(15),
                      )),
                  child: Swiper(
                    itemCount: animatedtitles.length,
                    itemBuilder: (context, index) {
                      return animatedtitles[index];
                    },
                    layout: SwiperLayout.STACK,
                    itemWidth: _animation.value - 10,
                    itemHeight: _animation.value - 10,
                    viewportFraction: 0.3,
                    scale: 0.6,
                    fade: 0.1,
                    scrollDirection: Axis.horizontal,
                    curve: Curves.fastEaseInToSlowEaseOut,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 210,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(51, 255, 255, 255),
                        Color.fromARGB(146, 96, 125, 139),
                        Color.fromARGB(51, 255, 255, 255),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GradientAnimationText(
                    text: const Text(
                      'Ice  &  Ice',
                      style: TextStyle(
                        fontFamily: 'Cherry',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    colors: !_isDarkMode
                        ? [
                            const Color.fromARGB(255, 1, 50, 90),
                            const Color.fromARGB(255, 1, 96, 6),
                            const Color.fromARGB(255, 93, 56, 0),
                            Colors.blueGrey
                          ]
                        : [
                            const Color.fromARGB(255, 147, 194, 232),
                            const Color.fromARGB(255, 1, 96, 6),
                            const Color.fromARGB(255, 93, 56, 0),
                            Colors.blueGrey
                          ],
                    duration: const Duration(seconds: 2),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                  elevation: 30,
                  foregroundColor: Colors.cyan,
                  splashColor: Colors.orangeAccent,
                  onPressed: _toggleTheme,
                  child: _isDarkMode
                      ? const Icon(
                          Icons.light_mode,
                        )
                      : const Icon(Icons.dark_mode),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({
    super.key,
    required this.color,
    required this.animation,
    required this.animationImg,
    required this.image,
    required this.animation1,
  });

  final Color color;
  final Animation<double> animation;
  final Animation<double> animationImg;
  final String image;
  final VoidCallback animation1;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: animation.value - 10,
        height: animation.value - 10,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          color: color,
        ),
      ),
      GestureDetector(
        child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return Image.asset(
              image,
              height: animationImg.value - 5,
              width: animationImg.value - 5,
            );
          },
        ),
        onTap: () => animation1(),
        onDoubleTap: () {
          Get.to(() => const PlaceOrder(),
              transition: Transition.leftToRightWithFade,
              duration: const Duration(milliseconds: 1000));
        },
      ),
    ]);
  }
}

class Details extends StatelessWidget {
  const Details({
    super.key,
    required this.energy,
    required this.calories,
    required this.calcium,
    required this.suger,
    required this.animation,
    required this.animationTxt,
    required this.title,
  });
  final int energy;
  final int calories;
  final int calcium;
  final int suger;
  final Animation<double> animation;
  final Animation<double> animationTxt;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: animation.value + 30,
      height: animation.value + 30,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(233, 27, 116, 106),
            Color.fromARGB(233, 41, 154, 210),
            Color.fromARGB(226, 19, 239, 213),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: animationTxt.value + 4,
                fontWeight: FontWeight.w900,
                color: Colors.white),
          ),
          TextStl(
              animationTxt: animationTxt,
              text1: 'Energy $energy',
              text2: 'Kcal'),
          TextStl(
              animationTxt: animationTxt,
              text1: 'Calories $calories',
              text2: 'Kcal'),
          TextStl(
              animationTxt: animationTxt,
              text1: 'Calcium $calcium',
              text2: '%'),
          TextStl(
              animationTxt: animationTxt, text1: 'Sugar $suger', text2: 'g'),
        ],
      ),
    );
  }
}

class TextStl extends StatelessWidget {
  const TextStl({
    super.key,
    required this.text1,
    required this.text2,
    required this.animationTxt,
  });
  final Animation<double> animationTxt;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text1,
          style: TextStyle(
              fontSize: animationTxt.value - 3,
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
        Text(
          text2,
          style: TextStyle(
              fontSize: animationTxt.value - 3,
              fontWeight: FontWeight.w400,
              color: Colors.white60),
        ),
      ],
    );
  }
}
