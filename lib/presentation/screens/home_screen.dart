import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeScreenController controller = HomeScreenController(
      ref,
    );

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        bottom: PreferredSize(
            preferredSize: Size(size.width, 2),
            child: Divider(
              color: Colors.black,
              thickness: 2,
              indent: size.width * 0.1,
              endIndent: size.width * 0.1,
            )),
        centerTitle: true,
        leading: controller.content?.userImage != null
            ? CircleAvatar(
                backgroundImage:
                    NetworkImage(controller.content?.userImage ?? ''),
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          )
        ],
        title: Text(controller.content?.header ?? 'Habit Tracker'),
      ),
      body: const Center(
        child: Text('Tracker Main Screen'),
      ),
    );
  }
}
