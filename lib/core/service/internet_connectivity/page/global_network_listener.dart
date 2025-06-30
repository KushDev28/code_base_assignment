import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifier/internet_connectivity_notifier.dart';


///Global Screen which is displaying flag of internet connected or not
class GlobalNetworkListener extends ConsumerStatefulWidget {
  final Widget child;

  const GlobalNetworkListener({super.key, required this.child});

  @override
  ConsumerState<GlobalNetworkListener> createState() => _GlobalNetworkListenerState();
}

class _GlobalNetworkListenerState extends ConsumerState<GlobalNetworkListener> {
  bool _attached = false;

  @override
  Widget build(BuildContext context) {
    if (!_attached) {
      _attached = true;

      ref.listen<NetworkStatus>(
        connectivityNotifierProvider,
            (prev, next) {
          if (prev != null && prev != next) {
            final isOffline = next == NetworkStatus.disconnected;

            final snackBar = SnackBar(
              content: Text(isOffline ? 'You are offline' : 'Back online'),
              backgroundColor: isOffline ? Colors.red : Colors.green,
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              duration: const Duration(seconds: 10),
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          }
        },
      );
    }

    return widget.child;
  }
}
