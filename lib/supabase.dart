import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url:
          'https://euhmwqyeoqxvdildhvfw.supabase.co', // Replace with your Supabase URL
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV1aG13cXllb3F4dmRpbGRodmZ3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk4ODg2MjcsImV4cCI6MjA0NTQ2NDYyN30.hLBmSmCh2uryeM4_G7DXrr_kBSOwlMANMlZEiyEEi8c', // Replace with your Supabase anon key
    );
  }
}
