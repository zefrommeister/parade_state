import 'package:gsheets/gsheets.dart';
import 'package:parade_state/services/parade_state.dart';
import 'package:parade_state/pages/listFile.dart';
import 'package:flutter/material.dart';
import 'package:parade_state/main.dart';

class UserSheetsAPI extends StatefulWidget {
  const UserSheetsAPI({Key? key}) : super(key: key);

  @override
  _UserSheetsAPIState createState() => _UserSheetsAPIState();
}

class _UserSheetsAPIState extends State<UserSheetsAPI> {

  Map data = {};
  int finalIndex = 1;

  @override
  Widget build(BuildContext context) {

    //data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    //finalIndex = data['selectedUnit'];

    return Scaffold(
        backgroundColor: Colors.grey[800],
        appBar: AppBar(
          title: Text('Parade State sent successfully'),
          centerTitle: true,
          backgroundColor: Colors.grey[500],
          elevation: 0,
      ),
        body: ListView(

      ),
    );
  }

  @override
  void initState() async {
    // TODO: implement initState
    super.initState();


    }
  }





class UserSheetsApi {
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "pstatetest",
  "private_key_id": "3bb6694f833e774292ee94b8a0c5efb943d8abf7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQD0tSKbAPrhEM7W\n7JNGHnAGCXjA46n6HEXycI4iWIyzbIHhSzh/Psz1ojOcaZPqEEItJTZ9s++10n8t\nGkAgXWPgCMvAFNfHDgN+7wzWrZFYr4GjdxOxzggmEmTqDdw8dgmv/TRXNjI/KD6Y\nYNl6qoY9fjpOyUq1kKWcohHM8K0tMUzyW16El8ikukwCtgKbu9lAzd6G/DiMGpRJ\nqpxKwVbEpgDqjfWLJ+ENf9ItTAWQiDCEAClgLnv0GsKfagivc3SAYk0xAAmxCxDP\n2y5sJPQ8TJWd4D1Fcc5cZz/bAECmSQ4UI3DzpJsTE5fzOmu7sP8ezByiBfX423Iu\nTlHyGO+VAgMBAAECggEAGDkLIGUHI7Rz7RJE/JnMHmTdbaaVL4HEXY/NTTjbtwt3\nvdMiC0J7RZm7pyRL6BozTfm5iTuz1kxsZ1mj9snLAz6LpxgvfDyp+7lZDLHosDeY\nF+DHjWaAjjHS7tii/N8oU7uD01nOvOUhPeWUXl0D5cSZeMdAwtrhi33L6kmTf7E7\nxW2o8UNScCigCjR4mGNSGtsdIQ9/+dE7/1p/VoORMYKY+S+7Cqu4AyzM+exJUeMm\nf41WKUlI0fCwTKfjdnWM7oLeoZXkGBpn8Eq928tRlEZvB43XssPxsO1Q1OHT1FeA\nRqYNytX+HnU/Esw2jSaZch02oEY2DsCPa+aVWVGsLwKBgQD/u4XTdiljqLkUubLs\nEmx8vm7459pYvr6zVzOS3YdDKMla0tE25cPQcsOM+yfEEMR7AFnMRd20xeMwsjxB\n9dxBP0ZTcwxpT1Fw2FfC/NQmYK/tLmMN0dI66TCtmHJ5WKWqrkfkA1vkOwLpmGv7\nRTjSyt1v+FC2TcSVT57jQGwb+wKBgQD09qkIEffpHmespquJyzfkzZWAL6/1aijd\nryK3IfwpLva1wHOmDrIvFr9Pjr1xziH3xjpxeNcgDiRp6x6QI77+Z56y3tqd0CGO\nt9zFVcjpLnAI0jwzoV2eD/yFVRg0sT8NXYy8aVVdDgTCKapOZJhfwf4fRKQhAw+E\nGzEV+uU9rwKBgQC40MoXl8azumT/wHC5QVtcD7hddBoNltR1AalJE4ZEl/5lAASp\nGwYX6EjA42XKwZ9tkURUZ42hrn3RXI5F0Sw7j0IA3x1yIhumZQOP7G5Zyfh6fdKi\nUygO4SYH3yuj3NflcQyNkYvgdnFVZo1rS4yUcn30BM434h4XFjKq44z97wKBgDY6\nVHkA4Uyt+m1yCA9c+WahTDMwW1eMxLcuihTYZSYIy3y4ueFM540dEATgqHeFFmfv\nbgioo5bpCo6YChAGmcVf0vXt959v773UXf8hWnSkXxDU2ZbkZgETsOcjS1R+2GJx\nDzK2brtG2y7QYm8wPbsVCtiJLXxRXSH1kww2moDpAoGBAMOMuPM0jLgSUpEiQim7\nSzj357ftwZ9NWVDroMpMpnLztmjYdXteethHD+Cta/Q8pdOsOBlIh8gfZwayHRzu\nBPvsDR2j1MghIZRgSdOeqMk2iRTRi7Ip8AoPVdP5VV9PgunGlmbcPi05ZbFFZqLM\n054+r5JdRHZDih4r9bTY8y5v\n-----END PRIVATE KEY-----\n",
  "client_email": "pstatetest@pstatetest.iam.gserviceaccount.com",
  "client_id": "115913476215122419173",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pstatetest%40pstatetest.iam.gserviceaccount.com"
}
  ''';
  static final _spreadSheetID = '13gk6BjULm1f-3bBKSvi2x7mceUGfdyIOl1FjjO1Rvsg';
  static final _gSheets = GSheets(_credentials);
  static Worksheet? _userSheet;


  static Future init() async {
    try {
      List<String> psUnit = ['Alpha', 'Bravo', 'Charlie', 'Delta', 'Echo', 'Foxtrot',
        'Golf', 'Hotel', 'India', 'Juliett', 'Kilo', 'Lima', 'Mike', 'November', 'Oscar', 'Papa', 'Quebec', 'Romeo', 'Sierra', 'Tango'];

      final spreadsheet = await _gSheets.spreadsheet(_spreadSheetID);
      _userSheet = await _getWorkSheet(spreadsheet, title: psUnit[isSelectedUnit]);

      final firstRow = ParadeStateFields.getPS();
      _userSheet!.values.insertRow(1, firstRow);

    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
      required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }

  }

   static insert(List<Map<String, dynamic>> rowList)
  {
      if (_userSheet == null) return false;

      _userSheet!.values.map.appendRows(rowList);

  }

  static buffer(Map<String, dynamic> mapRow)
  {
    if (_userSheet == null) return false;

    _userSheet!.values.map.appendRow(mapRow);
  }


}