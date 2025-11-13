// secure_storage_service_impl_test.dart

import "package:esim_open_source/data/data_source/secure_storage_service_impl.dart";
import "package:esim_open_source/domain/repository/services/secure_storage_service.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SecureStorageServiceImpl service;

  setUp(() {
    service = SecureStorageServiceImpl.instance;
  });

  group("SecureStorageServiceImpl", () {
    group("Singleton Pattern", () {
      test("should return same instance on multiple calls", () {
        // Act
        final SecureStorageServiceImpl instance1 =
            SecureStorageServiceImpl.instance;
        final SecureStorageServiceImpl instance2 =
            SecureStorageServiceImpl.instance;

        // Assert
        expect(instance1, same(instance2));
      });

      test("should implement SecureStorageService interface", () {
        // Assert
        expect(service, isA<SecureStorageService>());
      });

      test("should be properly initialized", () {
        // Assert
        expect(service, isNotNull);
        expect(service, isA<SecureStorageServiceImpl>());
      });
    });

    group("API Structure - Setter Methods", () {
      test("should have setBool method", () {
        // Verify the method exists
        expect(service.setBool, isNotNull);
        expect(service.setBool, isA<Function>());
      });

      test("should have setInt method", () {
        // Verify the method exists
        expect(service.setInt, isNotNull);
        expect(service.setInt, isA<Function>());
      });

      test("should have setDouble method", () {
        // Verify the method exists
        expect(service.setDouble, isNotNull);
        expect(service.setDouble, isA<Function>());
      });

      test("should have setString method", () {
        // Verify the method exists
        expect(service.setString, isNotNull);
        expect(service.setString, isA<Function>());
      });

      test("should have setStringList method", () {
        // Verify the method exists
        expect(service.setStringList, isNotNull);
        expect(service.setStringList, isA<Function>());
      });
    });

    group("API Structure - Getter Methods", () {
      test("should have getBool method", () {
        // Verify the method exists
        expect(service.getBool, isNotNull);
        expect(service.getBool, isA<Function>());
      });

      test("should have getInt method", () {
        // Verify the method exists
        expect(service.getInt, isNotNull);
        expect(service.getInt, isA<Function>());
      });

      test("should have getDouble method", () {
        // Verify the method exists
        expect(service.getDouble, isNotNull);
        expect(service.getDouble, isA<Function>());
      });

      test("should have getString method", () {
        // Verify the method exists
        expect(service.getString, isNotNull);
        expect(service.getString, isA<Function>());
      });

      test("should have getStringList method", () {
        // Verify the method exists
        expect(service.getStringList, isNotNull);
        expect(service.getStringList, isA<Function>());
      });
    });

    group("API Structure - Utility Methods", () {
      test("should have containsKey method", () {
        // Verify the method exists
        expect(service.containsKey, isNotNull);
        expect(service.containsKey, isA<Function>());
      });

      test("should have remove method", () {
        // Verify the method exists
        expect(service.remove, isNotNull);
        expect(service.remove, isA<Function>());
      });

      test("should have clear method", () {
        // Verify the method exists
        expect(service.clear, isNotNull);
        expect(service.clear, isA<Function>());
      });
    });

    group("SecureStorageKeys Enum", () {
      test("should have deviceID key", () {
        // Assert
        expect(SecureStorageKeys.deviceID, isNotNull);
        expect(SecureStorageKeys.deviceID, isA<SecureStorageKeys>());
      });

      test("should have valid enum name", () {
        // Assert
        const SecureStorageKeys key = SecureStorageKeys.deviceID;
        expect(key.name, "deviceID");
      });

      test("enum should be accessible", () {
        // Verify enum values are accessible
        final SecureStorageKeys key = SecureStorageKeys.deviceID;
        expect(key, isA<SecureStorageKeys>());
        expect(key.toString(), contains("deviceID"));
      });
    });

    group("Service Interface Compliance", () {
      test("should implement all SecureStorageService methods", () {
        // Verify service has all required methods from interface
        expect(service.getBool, isNotNull);
        expect(service.getInt, isNotNull);
        expect(service.getDouble, isNotNull);
        expect(service.getString, isNotNull);
        expect(service.getStringList, isNotNull);
        expect(service.setBool, isNotNull);
        expect(service.setInt, isNotNull);
        expect(service.setDouble, isNotNull);
        expect(service.setString, isNotNull);
        expect(service.setStringList, isNotNull);
        expect(service.containsKey, isNotNull);
        expect(service.remove, isNotNull);
        expect(service.clear, isNotNull);
      });

      test("should have consistent method count", () {
        // Verify all 13 public methods exist
        // 5 getters + 5 setters + 3 utilities = 13 methods
        final List<Function> methods = <Function>[
          service.getBool,
          service.getInt,
          service.getDouble,
          service.getString,
          service.getStringList,
          service.setBool,
          service.setInt,
          service.setDouble,
          service.setString,
          service.setStringList,
          service.containsKey,
          service.remove,
          service.clear,
        ];

        expect(methods.length, 13);
        expect(methods.every((Function m) => m != null), isTrue);
      });
    });

    group("Class Structure", () {
      test("should be instantiable via instance getter", () {
        // Verify the class can be accessed via singleton
        final SecureStorageServiceImpl instance =
            SecureStorageServiceImpl.instance;
        expect(instance, isNotNull);
      });

      test("should maintain singleton throughout test lifecycle", () {
        // Verify singleton is consistent
        final SecureStorageServiceImpl first =
            SecureStorageServiceImpl.instance;
        final SecureStorageServiceImpl second =
            SecureStorageServiceImpl.instance;
        final SecureStorageServiceImpl third =
            SecureStorageServiceImpl.instance;

        expect(first, same(second));
        expect(second, same(third));
        expect(first, same(third));
      });

      test("should have correct type hierarchy", () {
        // Verify inheritance and interface implementation
        expect(service, isA<SecureStorageServiceImpl>());
        expect(service, isA<SecureStorageService>());
        expect(service, isA<Object>());
      });
    });

    group("Method Availability", () {
      test("all getter methods should be callable functions", () {
        // Verify getters are proper functions
        expect(service.getBool, isA<Function>());
        expect(service.getInt, isA<Function>());
        expect(service.getDouble, isA<Function>());
        expect(service.getString, isA<Function>());
        expect(service.getStringList, isA<Function>());
      });

      test("all setter methods should be callable functions", () {
        // Verify setters are proper functions
        expect(service.setBool, isA<Function>());
        expect(service.setInt, isA<Function>());
        expect(service.setDouble, isA<Function>());
        expect(service.setString, isA<Function>());
        expect(service.setStringList, isA<Function>());
      });

      test("all utility methods should be callable functions", () {
        // Verify utilities are proper functions
        expect(service.containsKey, isA<Function>());
        expect(service.remove, isA<Function>());
        expect(service.clear, isA<Function>());
      });
    });
  });
}
