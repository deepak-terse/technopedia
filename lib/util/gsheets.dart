///A file for Google sheets integration 
///It provides methods that performs all the required query operations on Google sheet
import 'package:gsheets/gsheets.dart';

///Google auth credentials
const _credentials = r'''
{
	"type": "service_account",
	"project_id": "technopedia-279321",
	"private_key_id": "2c445383268ed848ad329b220c2ef87c6eae7cbb",
	"private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYIr9luUwIUEDW\nKeX0RTyrTY/8lcV3tBfSg2NRfmoj28sOGnqf2hlitytRpJ4qU1ml60Ex9nvrNSOu\nzJHdt/JszpZfVDNfXVZeJTnfZv7SisycnT9CTGyuSRfNFLkcpRh71SMkcH0OZKdP\njF37mBdondDo+E7XHn33qZWZlxU4G6GazKcRxaGn4Xz7uf24UYZJO++EBITKNO8G\nHsGmFLBq+Ef7KcJdBjCIJrUMdOc7LuHGo3hyCMZNP6N448CbxnbvGF7ri+ErEaA2\ndv+6PEaFw6x2/I4gpfHBLMFkzcNy4bpRA5Yifqki2YhYlZBkjXUTHt5xSDw2Okls\nXGGUlaErAgMBAAECggEALbHuJBsqW6rjNpBiGeL77IYA9AB2TdSBfUDqgW1Dax7W\n2Bca8s1653wV3lFgEl1zpVLKg7vBj62n2JZoT5yzC3xnjR2IyqGJ0gBDaDcS3eFD\nwNy4Re0Xjae1pusNCK4L8xHbGtRQs5SG7m0+Q1X03f7c40TFxXZKpqtAnF/VR0MK\nze/G7SaZ9S5Pt1dBu5s+s+rMoaGAIAOCVEN/Mk0Y/G1+qUl8jVoiSrf3zevumY/6\neq1aLEzFYCXRihBAIy36pfFUmBJQahqruU3E+DlWnjZXfuuTeja/oU0P1uXOU/+4\n3TbiuEmuXGpYRsgngeAp3vDIl0V+k0h7In+sIyT2NQKBgQDJFQ0GI17XPXq08yei\nDoJvKQqrnhB0q3xqi1sWlK115ErsKgQbdMDHMYg38R82ER75MTCSuTXGbuPMZ7RA\nX0XYNsxC6TIPhupA8ZF14H3aonVorhSmAqN8Srp1OXDqVt29znQLEKIPUqOpQ2av\nilvnJ48E4cUshRpiBY+1XWsIHQKBgQDBr4h2aW4QzxIm03p/x8k/O0aRKa0O2GZv\n/9eDvjZBA+xwYzFseixu5mTry4uG0CZk1utBabBF//zQxIXb6sbI+YS4ar6TmD1u\nXlJhrykzy8eooT7n8cNcHxnx91VrUOGBRiKw4UhBbdSLejpCtY/0oi9P6c4/AERL\nHMN+7Wtb5wKBgFQRwQg38Yb75TmSD5fpiQ8Akb1+sFKW/8VrzgF616rab5idWGpC\nPfcJ9nGtFed88P4uWqh9VsZHxmXHVc00B/eFsZCn/o4PUhEk7jPiT7wBACVr4qYl\npERq2dn40gSnnL2me03E/nx5iINT8rKhnhrepyTbX5xlacphmNuy2vThAoGBAIEi\ndnp0erTsSq7mSwNNAemNrNP2FHMUZt//lQI6XNPmOMsJ55bqshtSszDfKey9dQvA\nm2Omgqd5MGdEz/a7RsQSUKHgUaX4V+TxMD3+2hq1oC3XLCja8STHe7Xu8N23NFLL\nny+NVG6DOrWvzY5SnWM+iwrd2Ov6Uo495D4JL447AoGAeVvHs0J4EasXAfE5JEk9\nCLG+qlNpFZxHWGIIjVf4HHYoIAo3WOvGPHkYaIb5x8ddkfuW14Z5CL1ZWYK2jnuM\nS5N1HHs0qW8Jns7ollyrbQ2gDdSZ8wVEfYw7RHWgqhcEg2pfsBwHpEyQ0vSP7gti\nq96A84xi96X4S6B8qDR/z4I=\n-----END PRIVATE KEY-----\n",
	"client_email": "technopedia@technopedia-279321.iam.gserviceaccount.com",
	"client_id": "117882119236388002374",
	"auth_uri": "https://accounts.google.com/o/oauth2/auth",
	"token_uri": "https://oauth2.googleapis.com/token",
	"auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
	"client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/technopedia%40technopedia-279321.iam.gserviceaccount.com"
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