import 'bullsheet_app_wrapper.dart';
import 'flavors.dart';

void main() async {
  F.appFlavor = Flavor.dev;
  BullsheetAppWrapper.init();
}
