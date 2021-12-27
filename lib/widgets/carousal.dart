import 'package:flutter/material.dart';

class Carousal extends StatefulWidget {
  const Carousal({Key? key}) : super(key: key);

  @override
  _CarousalState createState() => _CarousalState();
}

class _CarousalState extends State<Carousal> {
  final PageController _pageControl =
      PageController(initialPage: 0, viewportFraction: 0.7);

  int activePage = 0;

  static int totalImg = 28;
  List<int> list = List<int>.generate(totalImg, (index) => index + 1);

  List<Widget> indicators(length, currentIndex) {
    return List<Widget>.generate(length, (index) {
      return GestureDetector(
        onTap: () => setState(() {
          _pageControl.animateToPage(index,
              duration: const Duration(milliseconds: 80),
              curve: Curves.easeInOut);
        }),
        child: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.black : Colors.black26,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          height: screenSize.height / 2.2,
          child: PageView.builder(
            controller: _pageControl,
            onPageChanged: (value) => setState(() {
              activePage = value;
            }),
            itemCount: list.length,
            itemBuilder: (context, index) {
              bool active = index == activePage;
              return AnimatedContainer(
                child: Image.asset(
                  "assets/images/" + list[index].toString() + ".jpg",
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
                margin: EdgeInsets.all(active ? 5 : 30),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: indicators(list.length, activePage),
        ),
      ],
    );
  }
}
