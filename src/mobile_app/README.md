# mobile_app

Positive Affirmations mobile app.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI/CD

### Environment variables required

- PLAY_STORE_CONFIG_JSON: Actual content of the Play Store API access service account json key. This content will be written onto a json file in local file system before its path is passed as an environment variable to steps that need it.
- FIREBASE_APP_DIST_APP: app id of the firebase app connected to the mobile app.
- FIREBASE_APP_DIST_APP: Base64 encoded jks file for the mobile app
- KEYSTORE_KEY_ALIAS: jks alias
- KEYSTORE_STORE_PASSWORD: jks store password
- KEYSTORE_KEY_PASSWORD: jks key password