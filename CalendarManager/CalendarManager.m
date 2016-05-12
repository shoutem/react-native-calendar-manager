//
//  CalendarManager.m
//  CalendarManager
//
//  Created by Vladimir Adamic on 12/05/16.
//  Copyright © 2016 ShoutEm. All rights reserved.
//

#import "CalendarManager.h"

#import <Foundation/Foundation.h>
#import "RCTLog.h"
#import "RCTConvert.h"
#import "AppDelegate.h"
@implementation CalendarManager

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(addEvent:(NSString *)name details:(NSDictionary *)details)
{
    if (!self.eventStore)
    {
        [self initEventStoreWithCalendarCapabilities:name details:details];
        return;
    }
    
    NSString *location = [RCTConvert NSString:details[@"location"]];
    NSDate *startTime = [RCTConvert NSDate:details[@"startTime"]];
    NSDate *endTime = [RCTConvert NSDate:details[@"endTime"]];
    BOOL useDeviceTimeZone = details[@"useDeviceTimeZone"];
    RCTLogInfo(@"Creating an event %@ at %@ from %@ to %@ with device time %d", name, location, startTime, endTime, useDeviceTimeZone);
    
    EKEvent *event = nil;
    
    event = [EKEvent eventWithEventStore:self.eventStore];
    event.startDate = startTime;
    event.endDate = endTime;
    event.title = name;
    event.location = location;
    
    EKEventEditViewController *editEventController = [[EKEventEditViewController alloc] init];
    editEventController.event = event;
    editEventController.eventStore = self.eventStore;
    editEventController.editViewDelegate = self;
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [delegate.window.rootViewController presentViewController:editEventController animated:YES completion:nil];
}

#pragma mark - EventView delegate

- (void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)initEventStoreWithCalendarCapabilities:(NSString *)name details:(NSDictionary *)details
{
    
    EKEventStore *localEventStore = [[EKEventStore alloc] init];
    [localEventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
     {
         if (granted)
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.eventStore = localEventStore;
                 [self addEvent:name details:details];
             });
         else
             NSLog(@"User denied calendar access");
     }];
}

@end

