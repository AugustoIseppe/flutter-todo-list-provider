import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/auth_manager.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Selector<AuthManager, String>(
        selector: (_, authManager) =>
            authManager.user?.displayName ?? 'Não informado',
        builder: (_, userName, __) => Text('E aí, $userName!',
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }
}
