import 'package:todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:sqflite_common/sqlite_api.dart';

class MigrationV2 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE todo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        description VARCHAR(500) NOT NULL,
        data_hora DATETIME,
        finalizado INTEGER,
        userId TEXT NOT NULL
      )
    ''');
  }

  @override
  void update(Batch batch) {
    // Para atualizações de versão
    batch.execute('ALTER TABLE todo ADD COLUMN userId TEXT;');

    // batch
    //     .execute('ALTER TABLE todo ADD COLUMN userId TEXT NOT NULL DEFAULT ""');
  }
}
