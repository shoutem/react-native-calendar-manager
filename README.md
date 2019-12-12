# react-native-calendar-manager

A calendar manager for React Native.
Exposes `addEvent` method which can save an event to an Android or iOS device's native calendar app.

## Supported React Native platforms

- Android
- iOS

## Plugin installation

Run `npm install --save git+ssh://git@bitbucket.org:fiveminutes/react-native-calendar-manager.git`

### Linking

Run:

`$ react-native link react-native-calendar-manager`

Which will link all native dependencies from the plugin, as well as add a directory containing your app's AppDelegate to CalendarManager projects build path which is necessary for building the iOS dependencies.

### Manual plugin linking

#### iOS

1. Open your project in XCode, right click on `Libraries` and click `Add
   Files to "Your Project Name"` Look under `node_modules/react-native-calendar-manager` and add `CalendarManager.xcodeproj`.  
2. Add `libCalendarManager.a` to `Build Phases -> Link Binary With Libraries`
3. Click on `CalendarManager.xcodeproj` in `Libraries` and go the `Build
   Settings` tab. Double click the text to the right of `Header Search
   Paths` and verify that it has the lines `$(SRCROOT)/../../node_modules/react-native/React/**` and `$(SRCROOT)/node_modules/react-native/React/**` - if it
   doesn't, then add them. This is so XCode is able to find the headers that
   the `CalendarManager` source files are referring to by pointing to the
   header files installed within the `react-native` `node_modules`
   directory.
4. Add the line `$(SRCROOT)/../../ios/<YOUR PROJECT'S NAME>` as well, so that CalendarManager can find yor AppDelegate header file.

#### Android

1. in `android/settings.gradle`   
```
#!groovy
   ...
   include ':react-native-calendar-manager'
   project(':react-native-calendar-manager').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-calendar-manager/android')

```

2. in `android/app/build.gradle` add:
```
#!groovy
   dependencies {
       ...
       implementation project(':react-native-calendar-manager')
   }
```

3. and finally, in `android/src/main/java/com/{YOUR_APP_NAME}/MainApplication.java` add:

```
#!java
   //... MainApplication.java
   import com.shoutem.calendar.CalendarManagerPackage; // <--- add this!
   //...

   @Override
   protected List<ReactPackage> getPackages() {
     return Arrays.<ReactPackage>asList(
       ...
       packages.add(new CalendarManagerPackage()); // <---- add this!
     );
   }

```


## Example
```javascript
import CalendarManager from 'react-native-calendar-manager';

const inTenMinutes = Date.now() + 1000 * 60 * 10;
const inTwentyMinutes = Date.now() + 1000 * 60 * 10 * 2;
CalendarManager.addEvent({
  name: 'Coffee',
  location: 'Heinzelova 33',
  startTime: inTenMinutes,
  endTime: inTwentyMinutes,
})


```
