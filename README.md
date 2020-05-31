# ButterflyDemo
This is a Core data demo app. Demoing the CoreData database that initially populates its content from the data that comes from the server. After the initial set up, you should be able to add local data in the database. The data must persist across sessions and it must not be overridden by the data in server unless the last updated time in the server is greater than the last updated time on the local device.
The added entities must be visible immediately and must persist across sessions, i.e. if I close the app and open, I should be able to see these entries.

### User is able 
- Add a plus button on the Home Page that will display a screen to add a purchase order. You can use a very minimal UI for this. UI beauty is not a requirement for this.
- Add a plus button on the Detail Page that will display a screen to add a new item to the current purchase order. You can use a very minimal UI for this. UI beauty is not a requirement for this.


## Screenshots 

### Adding new purchase order
Add new purchase order      |  Fill form                |  New purchase order was added
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1751.PNG)  |  ![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1752.PNG)|  ![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1753.PNG)


### Adding a new item to the purchase order 

Add New Item to PO         |  Fill form                |  New Item was added
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1754.PNG)  |  ![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1755.PNG)|  ![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1756.PNG)

### Developed on

```
Xcode 11.5
Apple Swift version 5.2.4
iOS >13
```

### Installing

```
1- Clone the repo
2- Run pod install
3- Use .xcworkspace
4- Change 'Team' in 'Signing & Capabilities' for the target, to your team if required 
4- Run the project
```
## CoreData
Grap of CoreData entities and thier relationships | 
:-------------------------:| 
![](https://github.com/turk-jk/ButterflyDemo/blob/master/images/IMG_1757.PNG)


## Pods in use
- Eureka [https://github.com/xmartlabs/Eureka]

## Unit tests & UI tests 

```
Unit tests & UI tests are not provided in the project
```
## Errors

```
App was not developed to handle all Errors in good UX manner. App was developed with the assumption the user will have internet connection prior launching the app. 
```
### Commits
Duo slowness and a technical problem with the project in the machine that the the project was initially developed with, I had to transfer the files to another machine to continue the work. That's way you you would see one gaint commit at the beging. 

