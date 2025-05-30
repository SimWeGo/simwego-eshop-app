import "package:esim_open_source/data/remote/responses/bundles/regions_response_model.dart";
import "package:objectbox/objectbox.dart";

@Entity()
class RegionEntity {
  RegionEntity({
    required this.icon,
    required this.zoneName,
    required this.regionCode,
    required this.regionName,
  });

  factory RegionEntity.fromModel(RegionsResponseModel model) {
    return RegionEntity(
      icon: model.icon,
      zoneName: model.zoneName,
      regionCode: model.regionCode,
      regionName: model.regionName,
    );
  }
  @Id()
  int id = 0;

  final String? icon;
  final String? zoneName;
  final String? regionCode;
  final String? regionName;

  RegionsResponseModel toModel() {
    return RegionsResponseModel(
      icon: icon,
      zoneName: zoneName,
      regionCode: regionCode,
      regionName: regionName,
    );
  }
}
