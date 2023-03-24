import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../utils/firebase_utils.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => FilesPageState();
}

class FilesPageState extends State<FilesPage> {
  late Stream<ListResult> images;

  Stream<ListResult> _getFiles() => FirebaseUtils.storage.ref().listAll().asStream();

  Future<void> _pullRefresh() async => setState(() => images = _getFiles());

  @override
  void initState() {
    images = _getFiles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _pullRefresh,
      child: Center(
        child: StreamBuilder(
          stream: images,
          builder: (context, snapshotFiles) {
            if (snapshotFiles.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: Color.fromARGB(255, 123, 118, 155),
              );
            }
            return ListView(
              children: snapshotFiles.data!.items.map(
                (image) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Card(
                      color: Colors.deepPurple,
                      child: ListTile(
                        textColor: Colors.white,
                        title: Text(image.name),
                        leading: FutureBuilder(
                          future: image.getDownloadURL(),
                          builder: (context, snapshotImage) {
                            if (snapshotImage.connectionState == ConnectionState.waiting) {
                              return const CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.transparent,
                                child: CircularProgressIndicator(
                                  color: Color.fromARGB(255, 123, 118, 155),
                                ),
                              );
                            }
                            return CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.deepPurple,
                              backgroundImage: NetworkImage(
                                snapshotImage.data.toString(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
