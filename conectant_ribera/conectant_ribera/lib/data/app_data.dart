import '../models/association.dart';
import '../models/centro.dart';

class AppData {
  final List<Centro> centros;
  final List<Association> associations;

  const AppData({
    required this.centros,
    required this.associations,
  });

  Association? associationForCentro(Centro centro) {
    for (final association in associations) {
      if (association.id == centro.associationId) {
        return association;
      }
    }
    return null;
  }

  List<Centro> centrosForAssociation(Association association) {
    return centros
        .where((centro) => centro.associationId == association.id)
        .toList();
  }
}
