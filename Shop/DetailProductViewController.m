#import "DetailProductViewController.h"
#import <Social/Social.h>

@interface DetailProductViewController ()
{
    SLComposeViewController *slComposeSheet;
}
@end

@implementation DetailProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)toInfoProduct:(id)sender {
    
    [self performSegueWithIdentifier:@"toInfo" sender:self];
    
}

#pragma mark Share Part

- (IBAction)toShare:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
    [actionSheet setDelegate:self];
    [actionSheet addButtonWithTitle:@"Twitter"];
    [actionSheet addButtonWithTitle:@"Facebook"];
    [actionSheet addButtonWithTitle:@"Cancel"];
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons - 1;
    
    [actionSheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        // Twitter
        
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            slComposeSheet = [[SLComposeViewController alloc]init];
            slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [slComposeSheet setInitialText:@"I like ShopApp very much!"];
            [self presentViewController:slComposeSheet animated:YES completion:nil];
            
            [slComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 switch (result)
                 {
                     case SLComposeViewControllerResultCancelled:
                         NSLog(@"Post cancelled");
                         break;
                         
                     case SLComposeViewControllerResultDone:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"Posted successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alertView show];
                     }
                         break;
                 }
                 
             }];

        }
        else
        {

            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Twitter" message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
    if (buttonIndex == 1)
    {
        // Facebook
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        {
            slComposeSheet = [[SLComposeViewController alloc]init];
            slComposeSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [slComposeSheet setInitialText:@"I like ShopApp very much!"];
            [self presentViewController:slComposeSheet animated:YES completion:nil];
            
            [slComposeSheet setCompletionHandler:^(SLComposeViewControllerResult result)
             {
                 switch (result)
                 {
                     case SLComposeViewControllerResultCancelled:
                         NSLog(@"Post cancelled");
                         break;
                         
                     case SLComposeViewControllerResultDone:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"Posted successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                         [alertView show];
                     }
                         break;
                 }

                 
             }];
        }
        else
        {
        
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Facebook" message:@"You can't post on your Facebook's wall right now, make sure your device has an internet connection and you have at least one Facebook account setup" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
            [alertView show];
        }
    }

}
@end
