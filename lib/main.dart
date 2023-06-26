import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'dart:async';

import 'src/app.dart';
import 'src/services/services_initializer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer container = ProviderContainer();
  await container.read(servicesInitializerProvider).init();

  await SentryFlutter.init(
        (options) {
          options.dsn = 'https://f349d25ceb6d4417aaeaef1b88ac4e56@o4505425760092160.ingest.sentry.io/4505425765597184';
          options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(UncontrolledProviderScope(container: container, child: const App()))
  );
}
