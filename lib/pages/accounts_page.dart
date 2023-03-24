import 'package:flutter/material.dart';

import '../models/account.dart';
import '../utils/firebase_utils.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => AccountsPageState();
}

class AccountsPageState extends State<AccountsPage> {
  Stream<List<Account>> _getAccounts() {
    FirebaseUtils.setCollection('Accounts');
    return FirebaseUtils.collection.snapshots().map((snapshot) => snapshot.docs.map((doc) => Account.fromSnapshot(doc)).toList());
  }

  Future<String> _getAccountsImage(String imageName) => FirebaseUtils.storage.ref().child(imageName).getDownloadURL();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: _getAccounts(),
        builder: (context, snapshotFriends) {
          if (snapshotFriends.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(
              color: Color.fromARGB(255, 123, 118, 155),
            );
          }
          return ListView(
            children: snapshotFriends.data!.map(
              (account) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Card(
                    color: Colors.deepPurple,
                    child: ListTile(
                      textColor: Colors.white,
                      title: Text(
                        account.userName,
                      ),
                      subtitle: Text(
                        style: const TextStyle(color: Colors.grey),
                        account.status ? 'Online' : 'Offline',
                      ),
                      leading: FutureBuilder(
                        future: _getAccountsImage(account.image),
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
                            child: CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.transparent,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: account.status ? Colors.green : Colors.transparent,
                                  radius: 7,
                                ),
                              ),
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
    );
  }
}
