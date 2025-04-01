# haritha_connect

# Login and Signup Pages Changes

## Changes in the project files

change minsdk in andriod/app/build.gradle to 23.
and
run "flutter pub get" and then run the application.

Make sure to change file paths.

## Firebase Changes

In Firebase Authentication sign-in method select the "Email/Password" option and in that enable Email/Password toggle only.

In Firebase Firestore create a collection "user".

## Working With The Project

In the signIn page first create a user with an nsbm mail and a custom password.

- **Mails are seperated to types as follows**

  - contains "@students" => student
  - contains "@club" => club
  - contains "@staff" => staff (lecturers)
  - else => alumni

- **To be able to navigate to the profile page instead of the edit_profile page**

  - Manually change the "initialLogin" field of the user to "false" in firestore for the relevant user

- **To be able to see/navigate to the add_course page**
  - Login with a staff account

# Add Courses Page Changes

## Files and their Changes

- **android\settings.gradle**
  - "com.android.application" version changed to "8.2.1"
- **android\app\src\main\AndroidManifest.xml**

  - Add below lines (To be able to request permission from user to modify files)

  "<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>"
  "<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>"
  "<uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>"

  as following

    <manifest xmlns:android="http://schemas.android.com/apk/res/android">

      <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
      <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
      <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE"/>

      <application

- **pubspec.yaml**
  - Add image_picker, path_provider, permission_handler dependencies and run flutter pub get
