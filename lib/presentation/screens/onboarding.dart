import 'package:app_banca/config/config.dart';
import 'package:app_banca/domain/story_model.dart';
import 'package:app_banca/presentation/screens/login.dart';
import 'package:app_banca/presentation/screens/signup.dart';
import 'package:app_banca/presentation/widgets/button_custom.dart';
import 'package:flutter/material.dart';
import 'package:story/story_image.dart';
import 'package:story/story_page_view.dart';

final sampleUsers = [
  UserModel([
    StoryModel("assets/onboarding.png"),
    StoryModel("assets/onboardingtwo.png"),
  ])
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        indicatorDuration: Duration(seconds: 20),
        itemBuilder: (context, pageIndex, storyIndex) {
          final user = sampleUsers[pageIndex];
          final story = user.stories[storyIndex];
          return Stack(
            children: [
              Positioned.fill(
                child: Container(color: Colors.black),
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: StoryImage(
                    key: ValueKey(story.imageUrl),
                    imageProvider: AssetImage(story.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },
        gestureItemBuilder: (context, pageIndex, storyIndex) {
          final user = sampleUsers[pageIndex];
          return Stack(children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            if (user.stories[storyIndex] == user.stories[1])
              Positioned(
                top: MediaQuery.of(context).size.height * 0.6,
                right: 10,
                left: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Toma el control de tus finanzas con confianza y accede a ellas sin restricciones',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            if (user.stories[storyIndex] == user.stories[0])
              Positioned(
                top: MediaQuery.of(context).size.height * 0.60,
                right: 10,
                left: 10,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Accede a créditos con un solo toque y sin complicaciones',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.76,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: Padding(
                padding: const EdgeInsets.only(top: 44, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonCustom(
                        colorBackground: 0xffFFFFFF,
                        colorText: 0xff0E111D,
                        label: 'Ingresar',
                        ontap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteList.login);
                        }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.009,
                    ),
                    ButtonCustom(
                        colorBackground: 0xff5428F1,
                        colorText: 0xffFFFFFF,
                        label: 'Registrarme',
                        ontap: () {
                          Navigator.pushReplacementNamed(
                              context, RouteList.signup);
                        }),
                  ],
                ),
              ),
            ),
          ]);
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          if (pageIndex == 0) {
            return 0;
          }
          return 0;
        },
        pageLength: sampleUsers.length,
        storyLength: (int pageIndex) {
          return sampleUsers[pageIndex].stories.length;
        },
        onPageLimitReached: () {
          //Navigator.pop(context);
        },
      ),
    );
  }
}
