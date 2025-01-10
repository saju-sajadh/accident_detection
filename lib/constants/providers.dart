import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'appwrite.dart';

final appwriteClientProvider = Provider((ref) {
  Client client = Client();
  return client
        .setEndpoint(AppWrite.endPoint)
        .setProject(AppWrite.projectId)
        .setSelfSigned(status: true);
});

final appwriteAccountProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabseProvider = Provider((ref) {
  final client = ref.watch(appwriteClientProvider);
  return Databases(client);
});