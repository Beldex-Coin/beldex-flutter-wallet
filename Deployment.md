# Deployment
How to deploy the Beldex Wallet.

1. Get Dependencies from pub
   ```
   flutter pub get
   ```

2. Run the build_runner
   ```
    flutter pub run build_runner build
   ```

3. Add the Beldex static libs
   ```
   ./tool/download-android-deps.sh https://oxen.rocks/oxen-io/oxen-core/oxen-stable-android-deps-LATEST.tar.xz
   ./tool/download-ios-deps.sh https://oxen.rocks/oxen-io/oxen-core/oxen-stable-ios-deps-LATEST.tar.xz
   ```

4. Generate Launcher Icons
    ```
     flutter pub run flutter_launcher_icons:main
    ```

5. Create Encryption Keys
   Create an empty file named `tool/.secrets-prod.json` and run the following command.
    ```
     dart tool/create_secret.dart
    ```
    Make sure to backup ".secrets-prod.json" in a secure location and share with nobody. The Secrets are used to encrypt the database. Users wont be able to access their local database and wallet if those change.

6. Add Key to the application
    ```
     dart tool/secrets.dart
    ```
    This generates the file `lib/.secrets.g.dart` this contains the secrets from `tool/.secrets-prod.json` and should not be shared with anyone.
    
7. Build the App
   For that I recommend you follow Google's Guides
   * [Android](https://flutter.dev/docs/deployment/android)
   * [iOS](https://flutter.dev/docs/deployment/ios)
