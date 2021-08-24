// import 'package:sqflite/sqlite_api.dart';

// class LocalDatabaseMock implements DatabaseFactory {
//   @override
//   Future<bool> databaseExists(String path) {
//     // TODO: implement databaseExists
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> deleteDatabase(String path) {
//     // TODO: implement deleteDatabase
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> getDatabasesPath() {
//     // TODO: implement getDatabasesPath
//     throw UnimplementedError();
//   }

//   @override
//   Future<Database> openDatabase(String path, {OpenDatabaseOptions? options}) {
//     // TODO: implement openDatabase
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> setDatabasesPath(String path) {
//     // TODO: implement setDatabasesPath
//     throw UnimplementedError();
//   }
// }

import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:to_do_list/model/note_model.dart';
import 'package:to_do_list/services/local_db.dart';

import '../model/note_model_test.dart';

class LocalDatabaseMock extends Mock implements LocalDatabase {}

void main() {
  @Skip("sqflite cannot run on the machine")
  late LocalDatabaseMock localDatabaseMock;
  setUp(() {
    localDatabaseMock = LocalDatabaseMock();
    localDatabaseMock.open();
  });
  group('Local Database Test', () {
    // test('store the note if the receiving input is a note model', () async {
    //   var a = when(localDatabaseMock.getNoteList)
    //       .thenAnswer((_) async => NoteModelTest().generateFake());
    //   expect(localDatabaseMock.getNoteList, NoteModelTest().generateFake());
    // });
  });
}
