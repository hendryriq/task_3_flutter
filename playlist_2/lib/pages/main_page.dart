import 'package:flutter/material.dart';
import 'package:tdd_demo/entities/user.dart';
import 'package:tdd_demo/repository/user_repository.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController controller = TextEditingController(text: '0');
  User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TDD demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user == null ? const Text('no data') : Text('ID: ${user!.id}'),
            if (user != null) Text('Name: ${user!.name}'),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      user = await UserRepository()
                          .getUser(int.tryParse(controller.text) ?? 0);

                      setState(() {});
                    },
                    child: const Text('Get User')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
