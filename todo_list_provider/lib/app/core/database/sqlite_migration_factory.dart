import 'migrations/migration.dart';
import 'migrations/migration_v2.dart';

// class SqliteMigrationFactory {
//   List<Migration> getCreateMigrations() => [
//         MigrationV1(),
//       ];
//   List<Migration> getUpgradeMigrations(int version) => [];
// }

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [
        MigrationV2(), // Nova criação usa V2 diretamente
      ];

  List<Migration> getUpgradeMigrations(int oldVersion) {
    final migrations = <Migration>[];
    if (oldVersion < 2) {
      migrations.add(MigrationV2());
    }
    return migrations;
  }
}
