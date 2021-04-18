String getFormattedDate(currDT) {
	final List<String> months = [
		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
	];

	final String currentDay = currDT.day.toString();
	final String currentMonth = months[currDT.month - 1];
	final String currentYear = currDT.year.toString();

	return "$currentDay $currentMonth $currentYear";
}

String getTodaysFormattedDate() {
	final DateTime currDT = new DateTime.now();
	return getFormattedDate(currDT);
}

int getRawDate() {
	final DateTime currDT = new DateTime.now();

	final String currentDay = currDT.day.toString();
	final String currentMonth = currDT.month.toString();
	final String currentYear = currDT.year.toString();

	return int.parse(currentDay + currentMonth + currentYear);
}


