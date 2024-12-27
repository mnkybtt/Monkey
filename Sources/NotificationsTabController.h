#import <UIKit/UIKit.h>

@interface NotificationsTabController : NSObject

+ (instancetype)sharedManager;
- (void)rearrangeNotificationsTabInPivotBar:(NSMutableArray *)pivotBarItems;

@end
