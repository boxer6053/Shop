#import <UIKit/UIKit.h>
#import "Vkontakte.h"

@interface DetailProductViewController : UIViewController <UIActionSheetDelegate, VkontakteDelegate, UIAlertViewDelegate>
{
    Vkontakte *_vkontakte;
}

- (IBAction)toInfoProduct:(id)sender;
- (IBAction)toShare:(id)sender;
@end
