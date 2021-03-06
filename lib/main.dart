import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rise_set/features/rise_set/presentation/pages/home/home_page.dart';
import 'package:rise_set/features/rise_set/presentation/providers/rise_set_provider.dart';
import 'dependency_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<RiseSetProvider>(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RISE SET',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
