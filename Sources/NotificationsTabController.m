#import "NotificationsTabController.h"
#import <YouTubeHeader/YTIPivotBarRenderer.h>
#import <YouTubeHeader/YTIPivotBarSupportedRenderers.h>

@implementation NotificationsTabController

+ (instancetype)sharedManager {
    static NotificationsTabManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)rearrangeNotificationsTabInPivotBar:(NSMutableArray *)pivotBarItems {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:showNotificationsTab_enabled]) {
        return;
    }

    NSUInteger notificationsIndex = [pivotBarItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        YTIPivotBarItemRenderer *item = (YTIPivotBarItemRenderer *)[obj pivotBarItemRenderer];
        return [item.pivotIdentifier isEqualToString:@"FEnotifications_inbox"];
    }];

    if (notificationsIndex != NSNotFound) {
        id notificationsItem = pivotBarItems[notificationsIndex];
        [pivotBarItems removeObjectAtIndex:notificationsIndex];
        // Insert the Notifications tab between Subscriptions and Library
        NSUInteger libraryIndex = [pivotBarItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            YTIPivotBarItemRenderer *item = (YTIPivotBarItemRenderer *)[obj pivotBarItemRenderer];
            return [item.pivotIdentifier isEqualToString:@"FElibrary"];
        }];

        if (libraryIndex != NSNotFound) {
            [pivotBarItems insertObject:notificationsItem atIndex:libraryIndex];
        } else {
            [pivotBarItems addObject:notificationsItem]; // Fallback
        }
    }
}

@end
