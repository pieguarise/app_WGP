// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CouponsDao? _couponsDaoInstance;

  TrainingsDao? _trainingsDaoInstance;

  TotalcalDao? _totalcalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Coupons` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Trainings` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `calories` INTEGER NOT NULL, `technique` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Totalcal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `amount` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CouponsDao get couponsDao {
    return _couponsDaoInstance ??= _$CouponsDao(database, changeListener);
  }

  @override
  TrainingsDao get trainingsDao {
    return _trainingsDaoInstance ??= _$TrainingsDao(database, changeListener);
  }

  @override
  TotalcalDao get totalcalDao {
    return _totalcalDaoInstance ??= _$TotalcalDao(database, changeListener);
  }
}

class _$CouponsDao extends CouponsDao {
  _$CouponsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _couponsInsertionAdapter = InsertionAdapter(
            database,
            'Coupons',
            (Coupons item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                }),
        _couponsDeletionAdapter = DeletionAdapter(
            database,
            'Coupons',
            ['id'],
            (Coupons item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Coupons> _couponsInsertionAdapter;

  final DeletionAdapter<Coupons> _couponsDeletionAdapter;

  @override
  Future<List<Coupons>> findAllCoupons() async {
    return _queryAdapter.queryList('SELECT * FROM Coupons',
        mapper: (Map<String, Object?> row) => Coupons(row['id'] as int?,
            row['title'] as String, row['description'] as String));
  }

  @override
  Future<void> insertCoupons(Coupons coupon) async {
    await _couponsInsertionAdapter.insert(coupon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCoupons(Coupons coupon) async {
    await _couponsDeletionAdapter.delete(coupon);
  }
}

class _$TrainingsDao extends TrainingsDao {
  _$TrainingsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _trainingsInsertionAdapter = InsertionAdapter(
            database,
            'Trainings',
            (Trainings item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'calories': item.calories,
                  'technique': item.technique
                }),
        _trainingsDeletionAdapter = DeletionAdapter(
            database,
            'Trainings',
            ['id'],
            (Trainings item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'calories': item.calories,
                  'technique': item.technique
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Trainings> _trainingsInsertionAdapter;

  final DeletionAdapter<Trainings> _trainingsDeletionAdapter;

  @override
  Future<List<Trainings>> findAllTrainings() async {
    return _queryAdapter.queryList('SELECT * FROM Trainings',
        mapper: (Map<String, Object?> row) => Trainings(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            row['calories'] as int,
            row['technique'] as String));
  }

  @override
  Future<void> insertTrainings(Trainings training) async {
    await _trainingsInsertionAdapter.insert(training, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTrainings(Trainings training) async {
    await _trainingsDeletionAdapter.delete(training);
  }
}

class _$TotalcalDao extends TotalcalDao {
  _$TotalcalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _totalcalInsertionAdapter = InsertionAdapter(
            database,
            'Totalcal',
            (Totalcal item) =>
                <String, Object?>{'id': item.id, 'amount': item.amount}),
        _totalcalDeletionAdapter = DeletionAdapter(
            database,
            'Totalcal',
            ['id'],
            (Totalcal item) =>
                <String, Object?>{'id': item.id, 'amount': item.amount});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Totalcal> _totalcalInsertionAdapter;

  final DeletionAdapter<Totalcal> _totalcalDeletionAdapter;

  @override
  Future<List<Totalcal>> findAllTotalcal() async {
    return _queryAdapter.queryList('SELECT * FROM Totalcal',
        mapper: (Map<String, Object?> row) =>
            Totalcal(row['id'] as int?, row['amount'] as int));
  }

  @override
  Future<void> insertCal(Totalcal totalcal) async {
    await _totalcalInsertionAdapter.insert(totalcal, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCal(Totalcal totalcal) async {
    await _totalcalDeletionAdapter.delete(totalcal);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
