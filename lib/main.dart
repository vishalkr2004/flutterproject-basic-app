
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// #docregion MyApp
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Startup Name Generator',
        theme: ThemeData(          // Add the 5 lines from here...
    appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
        foregroundColor: Colors.yellow,
    ),
        ),

      home: const RandomWords(),


    );
  }
// #enddocregion build
}
// #enddocregion MyApp

// #docregion RWS-var
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  // #enddocregion RWS-var

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder
    return Scaffold(
      appBar: AppBar(
      title: const Text('Startup Name Generator'),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: _pushSaved,
          tooltip: 'Saved Suggestions',
        ),
      ],
      ),
      body : ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider();
        /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        final alreadySaved = _saved.contains(_suggestions[index]);
        // #docregion listTile
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
          trailing: Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.deepOrange : null,
              semanticLabel: alreadySaved ? 'Remove from saved' : 'Save'
          ),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              } else {
                _saved.add(_suggestions[index]);
              }
            });
            // #enddocregion listTile
          },
        );
        // #enddocregion itemBuilder
      },
      ),
    );
  }
// #enddocregion RWS-build
// #docregion RWS-var


void _pushSaved() {
  Navigator.of(context).push(
    // Add lines from here...
    MaterialPageRoute<void>(
      builder: (context) {
        final tiles = _saved.map(
              (pair) {
            return ListTile(
              title: Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final divided = tiles.isNotEmpty
            ? ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList()
            : <Widget>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        );
      },
    ), // ...to here.
  );
}
}
// #enddocregion RWS-var

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}