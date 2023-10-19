import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:veli_flutter/constants/common.constanst.dart';

class SocketService {
  static SocketService? _instance; // Đối tượng duy nhất của SocketService
  io.Socket? _socket;
  String? authorizationToken;

  // Private constructor để tránh khởi tạo trực tiếp
  SocketService._({required this.authorizationToken}) {
    print('Connecting to socket');
    Map<String, dynamic> query = {
      'authorization': authorizationToken,
    };
    _socket = io.io(
      '${apiHost}/socket',
      io.OptionBuilder()
          .setTransports(['websocket', 'polling'])
          .disableAutoConnect()
          .setAuth({'authorization': authorizationToken})
          .setExtraHeaders({'authorization': authorizationToken})
          .build(),
    );
    _socket?.connect();
  }

  // Getter để lấy đối tượng duy nhất của SocketService
  static SocketService getInstance({String? authorizationToken}) {
    _instance ??= SocketService._(authorizationToken: authorizationToken ?? '');
    return _instance!;
  }

  // Các phương thức tương tác với socket

  void onEvent(String eventName, Function(dynamic data) callback) {
    _socket?.on(eventName, (data) {
      callback(data);
    });
  }

    void offEvent(String eventName, {Function(dynamic data)? callback}) {
    _socket?.off(eventName, (data) {
      callback!(data);
    });
  }

  void emitEvent(String eventName, dynamic data) {
    _socket?.emit(eventName, data);
  }

  void closeConnection() {
    _socket?.disconnect();
  }
}
