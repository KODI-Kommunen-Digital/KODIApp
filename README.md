# Gera App

A Flutter application for the city of Gera.

## Package names

- Android: `de.gera.mobileapp`
- iOS: `de.gera.app` *(may be updated in future)*

---

## Getting Started

### 1. Environment files (required before running)

The app reads API URLs from env files that are **not committed to git**. You must create them locally before running.

Create the following two files and fill in the correct values (get them from the team password manager):

**`assets/env/staging/.envGera`**
```
DEFAULT_API_URL=<staging api base url>
IMAGE_URL=<staging image storage url>
DEFAULT_PROFILE_IMAGE_URL=<staging default profile image url>
```

**`assets/env/production/.envGera`**
```
DEFAULT_API_URL=<production api base url>
IMAGE_URL=<production image storage url>
DEFAULT_PROFILE_IMAGE_URL=<production default profile image url>
```

Variable reference:

| Variable | Used for |
|---|---|
| `DEFAULT_API_URL` | Main API base URL (`Application.domain`) |
| `IMAGE_URL` | Cloud image/media storage base URL (`Application.picturesURL`) |
| `DEFAULT_PROFILE_IMAGE_URL` | Fallback profile picture URL (`Application.defaultPicturesURL`) |

### 2. Firebase configuration (required before running)

The following Firebase config files are **not committed to git**. Obtain them from the Firebase console or a team member:

| File | How to get |
|---|---|
| `lib/src/staging/firebase_options.dart` | Run `flutterfire configure` for the staging project |
| `lib/src/production/firebase_options.dart` | Run `flutterfire configure` for the production project |
| `android/app/src/staging/google-services.json` | Firebase console → Gera Staging Android app |
| `android/app/src/production/google-services.json` | Firebase console → Gera Production Android app |
| `ios/Runner/config/staging/GoogleService-Info.plist` | Firebase console → Gera Staging iOS app |
| `ios/Runner/config/production/GoogleService-Info.plist` | Firebase console → Gera Production iOS app |

### 3. Android signing (release builds only)

Release builds require the keystore and key properties:

| File | How to get |
|---|---|
| `android/app/upload-keystore-app.jks` | Obtain from the team password manager |
| `android/key.properties` | Create locally with the keystore credentials |

`android/key.properties` format:
```
storePassword=<password>
keyPassword=<password>
keyAlias=upload
storeFile=../app/upload-keystore-app.jks
```

### 4. Code generation

After adding or modifying anything in the database schema, regenerate code:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## Run configurations

| Entry point | Environment |
|---|---|
| `lib/main_staging.dart` | Staging |
| `lib/main_prod.dart` | Production |

---

## Sensitive files summary

These files are gitignored and must be obtained separately:

```
assets/env/staging/.envGera               # Staging API URLs
assets/env/production/.envGera            # Production API URLs
lib/src/staging/firebase_options.dart     # Firebase (staging)
lib/src/production/firebase_options.dart  # Firebase (production)
android/app/src/staging/google-services.json
android/app/src/production/google-services.json
ios/Runner/config/staging/GoogleService-Info.plist
ios/Runner/config/production/GoogleService-Info.plist
android/app/upload-keystore-app.jks       # Android signing keystore
android/key.properties                    # Android signing credentials
```
