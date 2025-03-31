# haritha_connect

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
