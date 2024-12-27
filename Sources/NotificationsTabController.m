#import "NotificationsTabController.h"
#import <YouTubeHeader/YTIPivotBarRenderer.h>
#import <YouTubeHeader/YTIPivotBarSupportedRenderers.h>

@implementation NotificationsTabController

+ (instancetype)sharedManager {
    static NotificationsTabController *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)rearrangeNotificationsTabInPivotBar:(NSMutableArray *)pivotBarItems {
    NSUInteger notificationsIndex = [pivotBarItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        YTIPivotBarItemRenderer *item = (YTIPivotBarItemRenderer *)[obj pivotBarItemRenderer];
        return [item.pivotIdentifier isEqualToString:@"FEnotifications_inbox"];
    }];

    if (notificationsIndex != NSNotFound) {
        id notificationsItem = pivotBarItems[notificationsIndex];
        [pivotBarItems removeObjectAtIndex:notificationsIndex];
        NSUInteger libraryIndex = [pivotBarItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            YTIPivotBarItemRenderer *item = (YTIPivotBarItemRenderer *)[obj pivotBarItemRenderer];
            return [item.pivotIdentifier isEqualToString:@"FElibrary"];
        }];

        if (libraryIndex != NSNotFound) {
            [pivotBarItems insertObject:notificationsItem atIndex:libraryIndex];
        } else {
            [pivotBarItems addObject:notificationsItem];
        }
    }
}

@end
