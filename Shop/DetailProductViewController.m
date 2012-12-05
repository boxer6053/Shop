#import "DetailProductViewController.h"
#import <Social/Social.h>
#import <CoreFoundation/CoreFoundation.h>
@interface DetailProductViewController ()
{
    SLComposeViewController *slComposeSheet;
    
    UIButton *loginVK;
    UIButton *postVK;
    UIView *vkView;
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
    [actionSheet addButtonWithTitle:@"Vkontakte"];
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
    }
    
    if (buttonIndex == 2)
    {
        //Vkontakte
        _vkontakte = [Vkontakte sharedInstance];
        _vkontakte.delegate = self;
        
        vkView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 280)];
        [vkView setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:vkView];
        
        loginVK = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [loginVK addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
        loginVK.frame = CGRectMake(vkView.frame.size.width/2 - 50, 120, 100, 40);
        loginVK.hidden = NO;
        [vkView addSubview:loginVK];
        [self refreshButtonState];
        
        postVK = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [postVK addTarget:self action:@selector(postImageWithTextAndLink) forControlEvents:UIControlEventTouchUpInside];
        postVK.frame = CGRectMake (vkView.frame.size.width/2 - 50, 180, 100, 40);
        postVK.hidden = YES;
        [postVK setTitle:@"Post" forState:UIControlStateNormal];
        [vkView addSubview:postVK];
    }
}

- (void)refreshButtonState
{
    if (![_vkontakte isAuthorized])
    {
        [loginVK setTitle:@"Login"
                 forState:UIControlStateNormal];
        postVK.hidden = YES;
    }
    else
    {
        [loginVK setTitle:@"Logout"
                 forState:UIControlStateNormal];
        
        postVK.hidden = NO;
    }
}

-(void) loginPressed
{
    if (![_vkontakte isAuthorized])
    {
        [_vkontakte authenticate];
    }
    else
    {
        [_vkontakte logout];
    }
}

- (void)postImageWithTextAndLink
{
    [_vkontakte postImageToWall:[UIImage imageNamed:@"test.jpg"]
                           text:@"Vkontakte iOS SDK Trololo"
                           link:[NSURL URLWithString:@"https://www.ex.ua"]];
}

#pragma mark - VkontakteDelegate

- (void)vkontakteDidFailedWithError:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showVkontakteAuthController:(UIViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        controller.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)vkontakteAuthControllerDidCancelled
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self refreshButtonState];
}

- (void)vkontakteDidFinishLogOut:(Vkontakte *)vkontakte
{
    [self refreshButtonState];
}


- (void)vkontakteDidFinishPostingToWall:(NSDictionary *)responce
{
    NSLog(@"%@", responce);
    UIAlertView *alertVK = [[UIAlertView alloc] initWithTitle:nil message:@"Posted successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertVK show];
    [vkView removeFromSuperview];
}

@end
