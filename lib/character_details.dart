import 'package:character_viewer_exercise/character.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({
    super.key,
    required this.details,
  });

  final Character details;

  @override
  Widget build(BuildContext context) {
    print(details.icon.url);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 35,
              ),
              CircleAvatar(
                radius: 125,
                // backgroundImage: const NetworkImage(
                //   'https://picsum.photos/id/237/200/300',
                // ),
                foregroundImage: NetworkImage(
                  'https://duckduckgo.com/${details.icon.url}',
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              // NetworkImage(
              //   'https://duckduckgo.com/${details.icon.url}',
              // ),
              Text(
                details.text,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
