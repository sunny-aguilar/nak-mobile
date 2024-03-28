import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nak_app/screens/home_screen.dart';
import 'package:nak_app/services/theme_service.dart' as service;
import 'package:nak_app/components/cards.dart' as  cards;
import 'package:nak_app/components/buttons.dart' as buttons;
import 'package:nak_app/components/screen_args.dart' as screenArgs;

class PreviewBlog extends StatelessWidget {
  const PreviewBlog({super.key});

  @override
  Widget build(BuildContext context) {

    // extract the args from the current route
    final args = ModalRoute.of(context)!.settings.arguments as screenArgs.BlogArgs;

    String getCurrentDate() {
      String date = DateFormat.yMMMMd('en_US').format(DateTime.now());
      return date;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/img/nak_letters_bw.png', height: 30.0,),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          IconButton(
            icon: Get.isDarkMode ? const Icon(Icons.wb_sunny_outlined) : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              service.ThemeService().switchTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          cards.LargeGreyPictureCard(
            userImage: 'assets/img/users/profile.webp',
            userName: 'Sandro Aguilar',
            storyHeadline: args.title,
            image: 'assets/img/stories/compass_story.jpg',
            date: getCurrentDate(),
            storyText: args.body,
          ),
          const SizedBox(height: 25,),

          // preview blog button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextButton(
              style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.arrow_back_ios), Text('Back to Edits')],),
              onPressed: () {
                // process data if form is valid
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 1100),
                    content: Text('Back to edit screen...')
                  ),
                );
                // function that will prepare the blog preview
                // - have it take you to another page to show the preview
                // - after preview, either go back and edit or post and route to home page
                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 25,),

          // post blog button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextButton(
              style: Get.isDarkMode ? buttons.buttonStyleDark(context) : buttons.buttonStyleLight(context),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.send), Text(' Post Blog')],),
              onPressed: () {
                // process data if form is valid
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(milliseconds: 1400),
                    content: Text('Submitting blog...')
                  ),
                );
                // function that will prepare the blog preview
                // - have it take you to another page to show the preview
                // - after preview, either go back and edit or post and route to home page
                // Navigator.pushReplacement(context, '/home');
                Navigator.of(context, rootNavigator: false).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) => const HomeScreen()),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}