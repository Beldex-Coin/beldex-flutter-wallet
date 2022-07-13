import 'package:basic_utils/basic_utils.dart';

class OpenaliasRecord {

  OpenaliasRecord({this.address, this.name});

  final String name;
  final String address;

  static String formatDomainName(String name) {
    var formattedName = name;

    if (name.contains('@')) {
      formattedName = name.replaceAll('@', '.');
    }

    return formattedName;
  }

  static Future<OpenaliasRecord> fetchAddressAndName(String formattedName) async {
    var address = formattedName;
    var name = formattedName;

    if (formattedName.contains('.')) {
      try {
        final txtRecord = await DnsUtils.lookupRecord(formattedName, RRecordType.TXT, dnssec: true);

        if (txtRecord != null) {

          for (var element in txtRecord) {
            var record = element.data;

            if (record.contains('oa1:beldex') && record.contains('recipient_address')) {
              record = record.replaceAll('"', '');

              final dataList = record.split(';');

              address = dataList.where((item) => (item.contains('recipient_address')))
                  .toString().replaceAll('oa1:beldex recipient_address=', '')
                  .replaceAll('(', '').replaceAll(')', '').trim();

              final recipientName = dataList.where((item) => (item.contains('recipient_name'))).toString()
                  .replaceAll('(', '').replaceAll(')', '').trim();

              if (recipientName.isNotEmpty) {
                name = recipientName.replaceAll('recipient_name=', '');
              }

              break;
            }
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }

    return OpenaliasRecord(address: address, name: name);
  }

}

