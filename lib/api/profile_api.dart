import 'package:flutter_calory_calculator/models/profile.dart';
import 'package:flutter_calory_calculator/utills/supabase.dart';

class ProfileApi {
  static const tableName = 'profile';

  Future<Profile?> getProfile(String email) async {
    final profiles = await supabase.from(tableName).select<List<Map<String, dynamic>>>().eq('email', email);

    if (profiles.isNotEmpty) {
      return Profile.fromMap(profiles.first);
    }

    return null;
  }

  Future<void> addProfile(Profile profile) async {
    final profileMap = profile.toMap();
    profileMap.remove('id');
    await supabase.from(tableName).insert(profileMap);
  }

  Future<List<Profile>> getProfiles() async {
    final profiles = await supabase.from(tableName).select<List<Map<String, dynamic>>>();
    return profiles.map((profile) => Profile.fromMap(profile)).toList();
  }
}
