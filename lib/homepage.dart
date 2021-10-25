// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_senddata_app/model/album_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: (_futureAlbum == null)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        TextField(
                          controller: _controller,
                          decoration:
                              const InputDecoration(hintText: 'Enter Title'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _futureAlbum = createAlbum(_controller.text);
                              });
                            },
                            child: const Text('Create Data'))
                      ])
                : FutureBuilder<Album>(
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Text('${snapshot.data!.title}');
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    },
                    future: _futureAlbum,
                  )));
  }
}
