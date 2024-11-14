import 'package:fitness_buddy/routes/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();
  int currentPage = 0;

  _onPageViewChange(int page) {
    if (kDebugMode) {
      print("Current Page: " + page.toString());
    }
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: PageView(
              controller: pageController,
              onPageChanged: _onPageViewChange,
              children: <Widget>[
                _buildPage(
                  image: 'assets/images/onboarding1.png',
                  title: 'Seja bem-vindo ao\nFitness Buddy',
                  description: 'Sua companhia fitness personalizada',
                ),
                _buildPage(
                  image: 'assets/images/onboarding2.png',
                  title: 'Acompanhe o seu progresso',
                  description: 'Monitore sua jornada fitness',
                ),
                _buildPage(
                  image: 'assets/images/onboarding3.png',
                  title: 'Mantenha-se motivado',
                  description: 'Sinta-se inspirado a buscar seus objetivos',
                ),
                // Add more pages as needed
              ],
            ),
          ),
          SmoothPageIndicator(
              controller: pageController, // PageController
              count: 3,
              effect: SwapEffect(
                type: SwapType.yRotation,
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: Theme.of(context).primaryColor,
              ), // your preferred effect
              onDotClicked: (index) {}),
          TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRoutes.login);
              },
              child: const Text('Pular')),
        ],
      ),
      bottomSheet: (currentPage == 2) ? _buildBottomSheet() : null,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 10, 90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            (currentPage != 0)
                ? FloatingActionButton(
                    onPressed: () {
                      if (pageController.hasClients) {
                        final currentPage = pageController.page?.toInt() ?? 0;
                        pageController.animateToPage(
                          currentPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_back),
                  )
                : const SizedBox(),
            (currentPage != 2)
                ? FloatingActionButton(
                    onPressed: () {
                      if (pageController.hasClients) {
                        final currentPage = pageController.page?.toInt() ?? 0;
                        pageController.animateToPage(
                          currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSheet() {
    return GestureDetector(
      onTap: () {
        pageController.page == 2
            ? Navigator.pushReplacementNamed(context, AppRoutes.login)
            : pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
      },
      child: Container(
        height: 60,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: pageController.page == 2
              ? const Text(
                  'Comece agora',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              : const Text(
                  'Avançar',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          image,
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        const SizedBox(height: 20),
        Text(
          textAlign: TextAlign.center,
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
