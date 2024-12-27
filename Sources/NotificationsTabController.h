#import <UIKit/UIKit.h>

@interface NotificationsTabController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableView;
@end
