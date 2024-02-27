///A file for Google sheets integration 
///It provides methods that performs all the required query operations on Google sheet
import 'package:gsheets/gsheets.dart';

///Google auth credentials - copy the details from https://drive.google.com/file/d/1KvhV0n7FhjkinvpF7wHcsA_HtrHFkk8a and paste below
///ToDo: Consider reading them from env file instead
const _credentials = r'''
{
	"type": "service_account",
	"project_id": "",
	"private_key_id": "",
	"private_key": "",
	"client_email": "",
	"client_id": "",
	"auth_uri": "https://accounts.google.com/o/oauth2/auth",
	"token_uri": "https://oauth2.googleapis.com/token",
	"auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
	"client_x509_cert_url": ""
}
''';

///Spreadsheet id
const _spreadsheetId = '1rQfQdRmfQDRsA10nTKWlMd24kIYu28fqK0vuxby6vgI';

//It fetches records from the Google sheets based on the defined configuration
fetchsheet() async {
	///init GSheets
	final gsheets = GSheets(_credentials);
	///fetch spreadsheet by its id
	final ss = await gsheets.spreadsheet(_spreadsheetId);
	///get worksheet by its title
	var sheet = ss.worksheetByTitle('term');
	///create worksheet if it does not exist yet
	sheet ??= await ss.addWorksheet('term');

	///Returns all rows from Google sheets
	List terms = await sheet.values.allRows();
	///Remove the first row from the list as it will be the header
	terms.removeAt(0);

	return terms;
}