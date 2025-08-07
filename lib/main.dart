import 'dart:async';

import 'package:device_frame/device_frame.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tap_invest/core/injection/injection_container.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/domain/repositories/abstract_home_repository.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';
import 'package:tap_invest/features/home/presentation/pages/home_page.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initDependencies();
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: kIsWeb
            ? HydratedStorageDirectory.web
            : HydratedStorageDirectory((await getTemporaryDirectory()).path),
      );
      runApp(const MyApp());
    },
    (e, st) {
      debugPrint('Uncaught App Error: $e');
      debugPrintStack(stackTrace: st);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) =>
              HomeBloc(homeRepository: sl.get<AbstractHomeRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Tap Invest',
        theme: AppTheme.lightTheme,
        home: kIsWeb ? WrappedDeviceFrame(child: HomePage()) : const HomePage(),
      ),
    );
  }
}

class WrappedDeviceFrame extends StatelessWidget {
  final Widget? child;
  const WrappedDeviceFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      isFrameVisible: true,
      device: Devices.ios.iPhone13ProMax,
      screen: child ?? const SizedBox(),
    );
  }
}
