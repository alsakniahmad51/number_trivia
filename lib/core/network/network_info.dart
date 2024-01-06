import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

abstract class NetworkInfo {
  Future<bool> get isconnected;
}

class NetworkInfoImpl implements NetworkInfo {
 final DataConnectionChecker? dataConnectionChecker;

  NetworkInfoImpl(this.dataConnectionChecker);
  @override
  Future<bool> get isconnected {
    dataConnectionChecker!.hasConnection;
    return Future(() => Future.value(true));
  }
}
