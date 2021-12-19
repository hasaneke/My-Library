import 'package:get/get.dart';
import 'package:my_library/presentation/home/tab_bar_screens/home/home_screen.dart';
import 'package:my_library/presentation/home/tab_bar_screens/all_items/all_items_screen.dart';
import 'package:my_library/presentation/home/tab_bar_screens/marked/marked_screen.dart';

class AppScreenRootController extends GetxController {
  /* BOTTOM NAVIGATION BAR SETTINGS */
  var selectedTabIndex = Rx<int>(0);
  var pages = RxList([
    HomeScreen(),
    MarkedScreen(),
    const AllItemsScreen(),
  ]);

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
