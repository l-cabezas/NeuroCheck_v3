
import 'package:neurocheck/core/data/local/extensions/local_error_extension.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'i_local_storage_caller.dart';

part 'shared_pref_local_storage_caller.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPrefs(SharedPrefsRef ref) {
  throw UnimplementedError('sharedPrefsProvider has not initialized!');
}

@Riverpod(keepAlive: true)
ILocalStorageCaller localStorageCaller(LocalStorageCallerRef ref) {
  return SharedPrefsLocalStorageCaller(
    sharedPreferences: ref.watch(sharedPrefsProvider),
  );
}

class SharedPrefsLocalStorageCaller implements ILocalStorageCaller {
  SharedPrefsLocalStorageCaller({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;


  @override
  Future<bool> saveData({
    required String key,
    required dynamic value,
    required DataType dataType,
  }) async {
    return await _tryCatchWrapper(
      () async {
        return await getSetMethod(sharedPrefsMethod: dataType)(key, value);
      },
    );
  }

  @override
  Future<dynamic> restoreData({
    required String key,
    required DataType dataType,
  }) async {
    return await _tryCatchWrapper(
      () async {
        return await getGetMethod(sharedPrefsMethod: dataType)(key);
      },
    );
  }

  @override
  Future<bool> clearAll() async {
    return await _tryCatchWrapper(
      () async {
        return await sharedPreferences.clear();
      },
    );
  }

  @override
  Future<bool> clearKey({required key}) async {
    return await _tryCatchWrapper(
      () async {
        return await sharedPreferences.remove(key);
      },
    );
  }

  @override
  getSetMethod({required DataType sharedPrefsMethod}) {
    switch (sharedPrefsMethod) {
      case DataType.string:
        return sharedPreferences.setString;
      case DataType.int:
        return sharedPreferences.setInt;
      case DataType.double:
        return sharedPreferences.setDouble;
      case DataType.bool:
        return sharedPreferences.setBool;
      case DataType.stringList:
        return sharedPreferences.setStringList;
    }
  }

  @override
  getGetMethod({required DataType sharedPrefsMethod}) {
    switch (sharedPrefsMethod) {
      case DataType.string:
        return sharedPreferences.getString;
      case DataType.int:
        return sharedPreferences.getInt;
      case DataType.double:
        return sharedPreferences.getDouble;
      case DataType.bool:
        return sharedPreferences.getBool;
      case DataType.stringList:
        return sharedPreferences.getStringList;
    }
  }

  Future<T> _tryCatchWrapper<T>(Function body) async {
    try {
      return await body.call();
    } on Exception catch (e) {
      throw e.localErrorToCacheException();
    }
  }
}
