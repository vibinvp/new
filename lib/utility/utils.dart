

import 'package:intl/intl.dart';

class Utils {
  static String convertToReadableDate(String date) {
    DateTime dateTime = DateTime.parse(date);

    String formatedDate = DateFormat('dd/MM/yyyy').format(dateTime);

    return formatedDate;
  }

  static String convertToISODate(String date) {
    DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);

    String dateFormatted = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(dateTime);
    return dateFormatted;
  }

  static setPngPath(String name) {
    return 'assets/images/$name.png';
  }
  static setGifPath(String name) {
    return 'assets/images/$name.gif';
  }


static String capitalize(String value) {
  var result = value[0].toUpperCase();
  bool cap = true;
  for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " " && cap == true) {
        result = result + value[i].toUpperCase();
      } else {
            result = result + value[i];
            cap = false;
      }
  }
  return result;
}

  
}