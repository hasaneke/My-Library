import 'package:get/get.dart';
import 'package:my_library/screens/route_screens/tab_bar_screens/home_screen.dart';
import 'package:my_library/screens/route_screens/tab_bar_screens/all_items_screen.dart';
import 'package:my_library/screens/route_screens/tab_bar_screens/favorites_screen.dart';

class AppScreenRootController extends GetxController {
  /* BOTTOM NAVIGATION BAR SETTINGS */
  var selectedTabIndex = Rx<int>(0);
  var pages = RxList([
    HomeScreen(),
    const FavoritesScreen(),
    const AllItemsScreen(),
  ]);

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
