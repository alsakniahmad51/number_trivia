import 'dart:io';

String fixtures(String name)=>File('test/Fixtures/$name').readAsStringSync();