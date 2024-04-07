# NAK App

This is the official app by Nu Alpha Kappa Fraternity, Inc. Learn more about Nu Alpha Kappa Fraternity, Inc. This app is currently in the exploration phase and we would like to receive your feedback and suggestions. The app is being worked on for both iOS and Android.

## Contributors
![Badge](https://img.shields.io/badge/Contributor-Sunny-blue)

## Features Wishlist
- GPS to find nearby brothers
- Digital NAK ID
- Calenar with upcoming chapter events
- User profiles
- NEB admins & super admins
- User roles
- Role dependent features

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

## iOS Build System Notes
### Info.plist
- Update the purpose strings for both the camera and photo album to describe what the app is using them for and why
- Encryption rules

## Android Build System Notes

