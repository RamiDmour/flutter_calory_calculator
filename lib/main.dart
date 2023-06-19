import 'package:flutter/material.dart';
import 'package:flutter_calory_calculator/app/app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ru', null);
  await Supabase.initialize(
    url: "https://aeynagutzwliymxwnkeu.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFleW5hZ3V0endsaXlteHdua2V1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjkyNzkyMDMsImV4cCI6MTk4NDg1NTIwM30.JxmHPFA_bUBlFABDOaq7fV63tZn2v_LLpzmAuw9uj84",
  );
  runApp(const App());
}
