import 'package:flutter_test/flutter_test.dart';

import 'package:conectant_ribera/main.dart';

void main() {
  testWidgets('shows Supabase configuration error without credentials',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(
      find.text('No se han podido cargar los datos de Supabase.'),
      findsOneWidget,
    );
    expect(find.textContaining('SUPABASE_URL'), findsOneWidget);
  });
}
