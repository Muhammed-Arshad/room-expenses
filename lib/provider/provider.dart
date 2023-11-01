import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'calender_provider/calender_provider.dart';
import 'home_provider/home_provider.dart';

List<SingleChildWidget> providers() {
  return [
  ChangeNotifierProvider.value(value: HomeProvider()),
  ChangeNotifierProvider.value(value: CalenderProvider()),
];}