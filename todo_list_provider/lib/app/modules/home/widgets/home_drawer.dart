import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

import '../../../core/auth/auth_manager.dart';
import '../../../core/ui/messages.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');
  HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Selector<AuthManager, String?>(
                  selector: (_, authManager) => authManager.user?.photoURL,
                  builder: (context, photoUrl, child) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                          ? NetworkImage(photoUrl)
                          : const AssetImage('assets/account.png'),
                    );
                  },
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Selector<AuthManager, String>(
                        selector: (_, authManager) =>
                            authManager.user?.displayName ?? 'Não informado',
                        builder: (_, userName, __) => Text(userName,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      ),
                      Selector<AuthManager, String>(
                        selector: (_, authManager) =>
                            authManager.user?.email ?? 'Não informado',
                        builder: (_, userEmail, __) => Text(userEmail,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Alterar nome do usuario
          ListTile(
            title: const Text('Alterar nome'),
            leading: const Icon(Icons.person),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Alterar nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                        decoration: const InputDecoration(
                          hintText: 'Digite o novo nome',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            final nameValue = nameVN.value;
                            if (nameValue.isEmpty) {
                              Messages.of(context)
                                  .showError('Insira um nome válido');
                            } else {
                              Loader.show(context);
                              await context
                                  .read<UserService>()
                                  .updateDisplayName(nameValue);
                              Loader.hide();
                              Navigator.of(context).pop();
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                      ],
                    );
                  });
            },
          ),
          ListTile(
            title: const Text('Home'),
            leading: const Icon(Icons.home),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              context.read<AuthManager>().logout();
            },
          ),
        ],
      ),
    );
  }
}
