# crud_app

CRUD App with image(colored)_ 4x4.

## Setup step for Firebase

1. First create the firebase
2. the package name of app should same as package name of android app.
3. import the google-services.json file into the project directory of android app(crud_app) i.e: place it into /android/app folder 
4. now setup the Cloud Firestore and create a "users" in collection.
5. Create 'age', 'id', and 'username'. the id is auto generated.

## Step to run project

1. Run command "flutter pub get" to get dependencies of the project.
2. Run "flutter pub upgrad" if any old dependency is used.
3. Run command "flutter run lib/main.dart" while attached the device into the PC/System.
4. Another method to build and run seperately is Click on Build Section of Android Studio then selection Flutter from dropdown menu then proceed to select Build APK.

Inside the App
## Created a username and age section 
## can rename the username and age  of users
## Hold on the username section a Delete button will appear to delete user data

## All the username and age data is stored in Cloud Firestore 