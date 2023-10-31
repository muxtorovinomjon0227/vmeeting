import 'package:flutter/material.dart';

import '../../src/controllers/enter_number_cont.dart';

class AllUsersViewPage extends StatelessWidget {
  final NumberController controller;
  const AllUsersViewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Users Page"),
      ),
    );
  }
}
