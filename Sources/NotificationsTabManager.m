#import "NotificationsTabManager.h"
#import "uYouPlus.h"
#import <YouTubeHeader/YTPivotBarRenderer.h>
#import <YouTubeHeader/YTIPivotBarItemRenderer.h>
#import <YouTubeHeader/YTIBrowseEndpoint.h>
#import <YouTubeHeader/YTICommand.h>
#import <YouTubeHeader/YTIIcon.h>
#import <YouTubeHeader/YTIFormattedString.h>

@implementation NotificationsTabManager

+ (instancetype)sharedManager {
    static NotificationsTabManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)rearrangeNotificationsTabInPivotBar:(NSMutableArray *)pivotBarItems {
    @try {
        YTIPivotBarItemRenderer *notificationsItem = [[YTIPivotBarItemRenderer alloc] init];
        [notificationsItem setPivotIdentifier:@"FEnotifications_inbox"];

        YTIBrowseEndpoint *endPoint = [[YTIBrowseEndpoint alloc] init];
        [endPoint setBrowseId:@"FEnotifications_inbox"];
        YTICommand *command = [[YTICommand alloc] init];
        [command setBrowseEndpoint:endPoint];
        [notificationsItem setNavigationEndpoint:command];

        YTIIcon *icon = [[YTIIcon alloc] init];
        [icon setIconType:NOTIFICATIONS];
        [notificationsItem setIcon:icon];

        YTIFormattedString *title = [YTIFormattedString formattedStringWithString:@"Notifications"];
        [notificationsItem setTitle:title];
        [pivotBarItems insertObject:notificationsItem atIndex:4];

    } @catch (NSException *exception) {
        NSLog(@"Error rearranging notifications tab: %@", exception.reason);
    }
}

@end
