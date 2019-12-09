#!/usr/bin/env node

'use strict';
var fs = require('fs');
var xcode = require('xcode');
var rnpm = require('rnpm/src/config');

var modulePath = './node_modules/react-native-calendar-manager/CalendarManager.xcodeproj/project.pbxproj';
var moduleProject = xcode.project(modulePath);

var config = rnpm.getProjectConfig();

if (config.ios && config.ios.projectName) {
  var projectNameParts = config.ios.projectName.split('.');
  var projectName;

  if (projectNameParts && projectNameParts.length) {
    projectName = projectNameParts[0];

    moduleProject.parse((data) => {
      moduleProject.addToHeaderSearchPaths(`"$(SRCROOT)/../../ios/${projectName}"`);
      fs.writeFileSync(modulePath, moduleProject.writeSync());
      console.log(`iOS: Added ${projectName} to ${modulePath} header search path`);
    });
  }
}
