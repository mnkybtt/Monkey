#import <UIKit/UIKit.h>

@interface NotificationsTabManager : NSObject

+ (instancetype)sharedManager;
- (void)rearrangeNotificationsTab;
  
@end
