import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_connectivity_notifier.g.dart';

/// This notifier is used for check the network status of the application
enum NetworkStatus {
  connected,
  disconnected,
}

@Riverpod(keepAlive: true)
class ConnectivityNotifier extends _$ConnectivityNotifier {
  late final Connectivity _connectivity;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  NetworkStatus build() {
    _connectivity = Connectivity();
    _init();

    ref.onDispose(() {
      _subscription?.cancel();
    });

    return NetworkStatus.connected;
  }

  void _init() async {
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);

    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      _updateStatus(results);
    });
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final isConnected = !results.contains(ConnectivityResult.none);
    state = isConnected ? NetworkStatus.connected : NetworkStatus.disconnected;
  }
}
