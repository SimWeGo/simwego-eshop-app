import "package:esim_open_source/presentation/views/home_flow_views/data_plans_view/bundles_list/navigation/esim_arguments.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../../../helpers/view_helper.dart";

Future<void> main() async {
  await prepareTest();

  test("basic coverage", () {
    const EsimArguments(id: "1", name: "test", type: "region")
    ..copyWith()
    ..copyWith(code: "2")
    ..copyWith(name: "test2")
    ..copyWith(type: "country")
    ..copyWith(code: "3", name: "test3", type: "country");

    
    // Test different types
    const EsimArguments(id: "r1", name: "Region", type: EsimArgumentType.region);
    const EsimArguments(id: "c1", name: "Country", type: EsimArgumentType.country);

  });

  Future<void> tearDown() async {
    await tearDownTest();
  }
}
