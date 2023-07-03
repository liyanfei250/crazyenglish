import 'dart:io';

import 'package:path_provider/path_provider.dart';

class CacheUtil {
  static Future<Null> delCache() async {
    //getExternalStorageDirectory();  // 在iOS上，抛出异常,Android上是sd卡的根目录
    // getTemporaryDirectory();  //临时目录的返回值
    // getApplicationDocumentsDirectory();  //文档目录的地址
    Directory tempDir = await getTemporaryDirectory();
    //传入根目录，用递归的方法计算出文件的大小
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    print('临时目录大小: ' + value.toString());

    //清除缓存,传入根目录，通过递归的方式，删除所有的文件。
    delDir(tempDir);
  }

  static Future<String> getCacheSize() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    print('临时目录大小: ' + value.toString());
    if (null == value) {
      return "0.00B";
    }
    List<String> unitArr = <String>[]..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return "" + size + unitArr[index];
  }

  static Future _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children as Iterable<FileSystemEntity>)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = <String>[]..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

//递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }
}
