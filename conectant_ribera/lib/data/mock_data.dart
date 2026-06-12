import '../models/association.dart';
import '../models/centro.dart';

// CENTROS - Lista de centros individuales. Cada centro pertenece a una asociación.
final List<Centro> centros = [
  Centro(
    id: '1',
    name: 'Centro de Rehabilitación Ribera',
    address: 'Calle Mayor, 12',
    lat: 40.4168,
    lng: -3.7038,
    associationId: 'a1',
    description:
        'Centro especializado en rehabilitación física y terapia ocupacional. Ofrecemos programas personalizados para recuperación tras lesiones y seguimiento continuo.',
  ),
  Centro(
    id: '2',
    name: 'Unidad de Terapia Avanzada',
    address: 'Avenida del Sol, 45',
    lat: 40.4180,
    lng: -3.7045,
    associationId: 'a1',
    description:
        'Unidad con programas de terapia intensiva, equipos de última generación y equipos multidisciplinares orientados a la rehabilitación neurológica.',
  ),
  Centro(
    id: '3',
    name: 'Clínica Salud Ribera',
    address: 'Plaza del Lago, 3',
    lat: 40.4195,
    lng: -3.7020,
    associationId: 'a2',
    description:
        'Clínica con atención primaria y especialidades médicas. Ideal para consultas rápidas y seguimiento.',
  ),
];

// ASOCIACIONES - Una asociación puede tener muchos centros.
final List<Association> associations = [
  Association(
    id: 'a1',
    name: 'Asociación de Fisioterapeutas de Ribera',
    type: 'Organización',
    description:
        'Asociación profesional dedicada a promover la excelencia en fisioterapia y rehabilitación.',
    contact: 'info@fisioterapeutas-ribera.org',
    website: 'www.fisioterapeutas-ribera.org',
  ),
  Association(
    id: 'a2',
    name: 'Fundación Rehabilitación Plus',
    type: 'Organización',
    description:
        'Fundación dedicada a apoyar programas innovadores de rehabilitación y bienestar.',
    contact: 'info@rehabilitacion-plus.org',
    website: 'www.rehabilitacion-plus.org',
  ),
  Association(
    id: 'a3',
    name: 'Colegio Profesional de Terapeutas',
    type: 'Colegio',
    description:
        'Colegio oficial que agrupa y regula la actividad de profesionales de terapia.',
    contact: 'colegiados@colegio-terapeutas.es',
    website: 'www.colegio-terapeutas.es',
  ),
];

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
