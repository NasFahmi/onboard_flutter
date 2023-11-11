import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'intro_widget.dart';

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();

  int _activePage = 0;

  void onNextPage() {
    if (_activePage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  final List<Map<String, dynamic>> _pages = [
    {
      'color': '#ffe24e',
      'title': 'Selamat Datang di Pawonkoe Admin Dashboard!',
      'image': 'assets/images/welcome.png',
      'description':
          "Kami senang melihat Anda di pusat kendali penjualan makanan ringan Anda. Mari kita mulai perjalanan ini untuk meningkatkan meningkatkan penjualan!",
      'skip': true
    },
    {
      'color': '#a3e4f1',
      'title': 'Pantau Penjualan secara Real-time',
      'image': 'assets/images/graph.png',
      'description':
          'Dengan dashboard kami, pantau penjualan makanan ringan Anda secara langsung. Grafik interaktif dan statistik real-time membantu Anda memahami tren penjualan dan mengidentifikasi produk yang paling diminati pelanggan.',
      'skip': true
    },
    {
      'color': '#31b77a',
      'title': 'Kelola Inventori dengan Mudah',
      'image': 'assets/images/task.png',
      'description':
          'Jangan biarkan stok kosong menghentikan penjualan Anda. Dengan fitur manajemen inventori kami, perbarui stok snack Anda dengan cepat dan efisien. Terapkan strategi restok yang cerdas untuk menghindari kehilangan penjualan.',
      'skip': false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
              controller: _pageController,
              itemCount: _pages.length,
              scrollBehavior: AppScrollBehavior(),
              onPageChanged: (int page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return IntroWidget(
                  index: index,
                  color: _pages[index]['color'],
                  title: _pages[index]['title'],
                  description: _pages[index]['description'],
                  image: _pages[index]['image'],
                  skip: _pages[index]['skip'],
                  onTab: onNextPage,
                );
              }),
          Positioned(
            top: MediaQuery.of(context).size.height / 1.75,
            right: 0,
            left: 0,
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildIndicator())
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < _pages.length; i++) {
      if (_activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if (_activePage == 0) {
      color = '#ffe24e';
    } else if (_activePage == 1) {
      color = '#a3e4f1';
    } else {
      color = '#31b77a';
    }

    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: hexToColor(color),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.grey.shade100,
      ),
    );
  }
}
