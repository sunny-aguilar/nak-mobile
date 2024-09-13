# NAK App

This is the official app by Nu Alpha Kappa Fraternity, Inc. Learn more about Nu Alpha Kappa Fraternity, Inc. This app is currently in the exploration phase and we would like to receive your feedback and suggestions. The app is being worked on for both iOS and Android.

![NAK Logo](https://naknet.org/main/wp-content/uploads/2012/04/Header_Stacked_1line.png)
# The unOfficial NAK App

## Contributors
![Badge](https://img.shields.io/badge/Contributor-Sunny-blue)

## Features Wishlist
- Biometric authentication
- GPS to find nearby brothers
- Digital NAK ID
- Calenar with upcoming chapter events
- User profiles
- NEB admins & super admins
- User roles
- Role dependent features

## Flutter Dependencies
These commands will remove and re-install flutter dependencies.
- flutter clean
- flutter pub get

## Flutter Dart Fix
These commands will identify errors/warnings/deprecated code in Flutter.
- dart fix --dry-run
- dart fix --apply

## Firebase CLI
Generally, you want to use the most up-to-date Firebase CLI version
- curl -sL https://firebase.tools | upgrade=true bash

## User Registration
- Only users with a nakinc.org email are able to register.
- Undergrads who are active will be able to use the app free of charge.
- Alumni and or inactive brothers will pay full price.

## User Permissions
The app distinguishes users based on their permissions. When a user registers, they are assigned basic rights.
Types of permissions:
- admin
- super admin
- NEB member
- Developer

Permission rights:
- admin: create blogs
- super admin: create/edit/delete blogs
- NEB member:
- Developer: create/edit/delete blogs, add NEB members

Other rights being considered:
- Chat rights
- Undergard blog rights
- log users off

This area is under developement. The right balance of user rights is being determined and is subject to change quickly.

## Firebase Notes
The backend chosen for the app is Google's Firebase. The Firebase CLI is downloaded locally and you must log in using the terminal. You should try to use the latest Firebase version. It can be updated using the commands below. The following are some helpful commands:
- firebase login (login)
- firebase projects:list (view projects)
- curl -sL https://firebase.tools | upgrade=true bash (update Firebase CLI)

### Getting Data Out
- data is in an object
- you must first get an instance to Firestore, then get a reference to the collection, tnen a specific doc or group of docs
- in the UI, you can access the data usually from the snapshot of a FutureBuilder/StreamBuilder
- snapshot.data.doc.toList() <--- will give you a list of the objects
- for (var user in Users) <--- iterate through the objects to pull the date out of each one Map style user['firstName]
- Get data into object
```
Map<String, dynamic> obj = doc.data;
```
- Or if you have a list of objects:
```
    snapshot.docs.forEach(doc => {
        Map<String, dynamic> obj = doc.data;
    });
```

## iOS Build System Notes
### Info.plist
- Update the purpose strings for both the camera and photo album to describe what the app is using them for and why.
- Encryption rules: on Info.Plist, add an entry under 'App Uses Non-Exemp Entryption' wiht a value of NO.

## Android Build System Notes
### Version Number
- GooglePlay requires any subsequent app releases (updates) to have a new "versionName" and "versionCode".
- In the "android" folder, find the local.properties where the edits can be made.
- Only need to increment the "versionCode" by 1 for each new release.

## Releasing on GooglePlay
## App Bundle
- You generate the app "bundle" on Android Studio (only open the android folder).
- Click on the "Build" menu and select "Generate Signed App Bundle/APK
- Just click through and make note of where the file was saved. This file is then uploaded to GooglePlay.
