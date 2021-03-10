Najprostsza aplikacja na Androida. Aby ją skompilować, użyj skryptu `build-script.sh`. Przed jego odpaleniem zainstaluj odpowiednie pakiety android-sdk oraz wygeneruj klucz do podpisywania apk:
```
$ keytool -keystore ~/.android/debug.keystore -genkey -alias androiddebugkey
Enter keystore password:  
Re-enter new password: 
What is your first and last name?
  [Unknown]:  Android
What is the name of your organizational unit?
  [Unknown]:  Android
What is the name of your organization?
  [Unknown]:  Android
What is the name of your City or Locality?
  [Unknown]:  Mountain View
What is the name of your State or Province?
  [Unknown]:  California
What is the two-letter country code for this unit?
  [Unknown]:  US
Is CN=Android, OU=Android, O=Android, L=Mountain View, ST=California, C=US correct?
  [no]:  yes
```

Następnie połącz telefon z komputerem przez adb za pomocą kabla USB lub bezprzewodowo:
```
adb tcpip 5555
adb connect <adres IP telefonu>
```

Po odpaleniu skryptu aplikacja powinna się skompilować i zainstalować na telefonie
