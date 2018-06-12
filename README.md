# Truckish Assignment

A list view iOS Application written in Objective C.


## Features

Firebase Authentication
Firebase Social Login
Firebase Database Connection
Open Weather API
Google Address Decoder
Google Maps
Google Directions
Google Distance Calculator


## Supported Devices

iPhone with iOS 10 or later


## Installing

Go to application folder from terminal
Run the comman 'pod install' (requires CocoaPods)
open truckish.xcworkspace


## Architecture

1. Tab Bar Controller

MainTabBarViewController --> adds all the view controllers and manages the tab bar icon used for each controller.

2. Navigation Controllers

InitialNavigationViewController --> used to manage stack of InitialListViewController, PopUpViewController and MapViewController


3. View Controllers

LoginViewController: Shows the login view where user can log in using firebase username password or social media. Unregistered user can also register by clicking the register button

RegisterViewController: Registers a user in the firebase database for authentication. User after successful registration can use the credentials to log in.

InitialListViewController: Shows the list of places from the firebase database

PopUpViewController: Shows the detailed view of a place with address, temperature. Presents modally

MapViewController: Show the place in google maps and the direction route from current location. Also shows the distance between.

ProfileViewController: Dummy profile view with log out button for log out functionality.

4. Models

PlaceModel: Creates and object of a place and hold its key and value. 


## Support Files

1. Json Manager

JsonAPICall --> Acts as a mediatior to pass network api call request to JSONManager and send back the response to perticular delegate.

JSONManager --> Makes network connection to the backend and fetches the response. Uses AFNetworking.

2. PCH Header

TruckishPrefixHeader: Used to access every file from any class.

3. Singleton --> make functions public which can be used by any class.

4. style.json --> is used for custom styling of google maps.
