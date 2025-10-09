import "package:esim_open_source/presentation/views/home_flow_views/banners_view/banners_view_types.dart";
import "package:flutter_test/flutter_test.dart";

void main() {

  group("BannersViewTypes Tests", () {
    test("enum values are correct", () {
      expect(BannersViewTypes.values.length, equals(4));
      expect(BannersViewTypes.values, contains(BannersViewTypes.none));
      expect(BannersViewTypes.values, contains(BannersViewTypes.liveChat));
      expect(BannersViewTypes.values, contains(BannersViewTypes.referAndEarn));
      expect(BannersViewTypes.values, contains(BannersViewTypes.cashBackRewards));
    });

    test("button text is not null for all types", () {
      expect(BannersViewTypes.liveChat.buttonText, isA<String>());
      expect(BannersViewTypes.referAndEarn.buttonText, isA<String>());
      expect(BannersViewTypes.cashBackRewards.buttonText, isA<String>());
      expect(BannersViewTypes.none.buttonText, equals(""));
    });

    test("fromString returns correct types", () {
      expect(
        BannersViewTypes.fromString("CHAT"),
        equals(BannersViewTypes.liveChat),
      );
      expect(
        BannersViewTypes.fromString("REFER_NOW"),
        equals(BannersViewTypes.referAndEarn),
      );
      expect(
        BannersViewTypes.fromString("CASHBACK"),
        equals(BannersViewTypes.cashBackRewards),
      );
    });

    test("fromString returns none for unknown action", () {
      expect(
        BannersViewTypes.fromString("UNKNOWN_ACTION"),
        equals(BannersViewTypes.none),
      );
    });

    test("fromString returns none for empty action", () {
      expect(
        BannersViewTypes.fromString(""),
        equals(BannersViewTypes.none),
      );
    });


    test("fromString handles case insensitive input", () {
      expect(
        BannersViewTypes.fromString("chat"),
        equals(BannersViewTypes.liveChat),
      );
      expect(
        BannersViewTypes.fromString("refer_now"),
        equals(BannersViewTypes.referAndEarn),
      );
      expect(
        BannersViewTypes.fromString("cashback"),
        equals(BannersViewTypes.cashBackRewards),
      );
    });

    test("all enum values have valid button text", () {
      for (final BannersViewTypes type in BannersViewTypes.values) {
        expect(type.buttonText, isA<String>());
      }
    });

    test("enum values are properly indexed", () {
      expect(BannersViewTypes.liveChat.index, equals(0));
      expect(BannersViewTypes.referAndEarn.index, equals(1));
      expect(BannersViewTypes.cashBackRewards.index, equals(2));
      expect(BannersViewTypes.none.index, equals(3));
    });

    test("enum toString returns correct values", () {
      expect(BannersViewTypes.none.toString(), equals("BannersViewTypes.none"));
      expect(BannersViewTypes.liveChat.toString(), equals("BannersViewTypes.liveChat"));
      expect(BannersViewTypes.referAndEarn.toString(), equals("BannersViewTypes.referAndEarn"));
      expect(BannersViewTypes.cashBackRewards.toString(), equals("BannersViewTypes.cashBackRewards"));
    });
  });
}
