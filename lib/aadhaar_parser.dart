import 'dart:typed_data';
import 'package:archive/archive.dart';

class AadhaarData {
  final String name;
  final String dob;
  final String gender;

  AadhaarData({required this.name, required this.dob, required this.gender});

  @override
  String toString() {
    return 'Name: $name\nDOB: $dob\nGender: $gender';
  }
}

AadhaarData? parseAadhaarData(String qrData) {
  try {
    final Uint8List qrBytes = Uint8List.fromList(qrData.codeUnits);
    final BZip2Decoder bzip2 = BZip2Decoder();
    final decompressed = bzip2.decodeBytes(qrBytes);
    final decompressedString = String.fromCharCodes(decompressed);

    final nameMatch = RegExp(r'name="([^"]+)"').firstMatch(decompressedString);
    final dobMatch = RegExp(r'dob="([^"]+)"').firstMatch(decompressedString);
    final genderMatch = RegExp(r'gender="([^"]+)"').firstMatch(decompressedString);

    if (nameMatch != null && dobMatch != null && genderMatch != null) {
      return AadhaarData(
        name: nameMatch.group(1)!,
        dob: dobMatch.group(1)!,
        gender: genderMatch.group(1)!,
      );
    }
  } catch (e) {
    // Parsing failed
  }
  return null;
}