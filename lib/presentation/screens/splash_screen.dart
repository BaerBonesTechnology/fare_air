import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/load_screen_controller.dart';

class LoadScreen extends ConsumerWidget {
  const LoadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    try {
      final InitialLoadScreenController controller =
          InitialLoadScreenController(ref, context);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text(e.toString()),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));
    }

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
