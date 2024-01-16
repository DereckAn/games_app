import 'package:socket_io_client/socket_io_client.dart' as ioo;

class SocketClient {
  ioo.Socket? socket;
  static SocketClient? _instance;
  SocketClient._internal() {
    socket = ioo.io('http://192.168.1.191:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
