//
//  LoadAppViewController.m
//  Shop
//
//  Created by Matrix Soft on 28.11.12.
//  Copyright (c) 2012 Matrix Soft. All rights reserved.
//

#import "LoadAppViewController.h"
#import "checkConnection.h"
#import "SSToolkit/SSToolkit.h"
#import "JSONParserForDataEntenties.h"
#import "AccessDatabaseContent.h"

@interface LoadAppViewController ()

@property (nonatomic, strong) SSLoadingView *loadingView;

@end

@implementation LoadAppViewController

@synthesize loadingView = _loadingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.loadingView = [[SSLoadingView alloc] initWithFrame:self.view.frame];
    [self.loadingView setBackgroundColor:[UIColor clearColor]];
    [self.loadingView.activityIndicatorView setColor:[UIColor blackColor]];
    [self.loadingView.textLabel setTextColor:[UIColor blackColor]];
    [self.loadingView.textLabel setText:@""];
    
    [self.view addSubview:self.loadingView];
    
    [self getDBData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
//    [self performSegueWithIdentifier:@"toMain" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"Succeeded! Received %d bytes of data",[responseData
                                                   length]);
    NSString *txt = [[NSString alloc] initWithData:responseData encoding: NSUTF8StringEncoding];
    NSLog(@"strinng is - %@",txt);
        
    NSDictionary *entitiesDictionary = [JSONParserForDataEntenties parseJSONDataWithData:responseData];
    
    AccessDatabaseContent *dataContent = [[AccessDatabaseContent alloc] init];
    [dataContent setDataToEntity:@"qwert" withDictionaryAttribute:entitiesDictionary];
    
    [self performSegueWithIdentifier:@"toMain" sender:self];

}

//запит до БД для завантаження даних
- (void)getDBData
{
    //перевірка наявності інету
    if (checkConnection.hasConnectivity) {
        
        //якщо інет є
        NSString *dbLink = @"http://matrix-soft.org/clients/update_store.php?";
        [[NSUserDefaults standardUserDefaults] setValue:dbLink forKey:@"dbLink"];
        
        //http request
        NSLog(@"Fetching request...");
        
        NSMutableString *requestString = [NSMutableString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] objectForKey:@"dbLink"]];
        
        //формат запиту потрібних талиць: table[]=tablename;maxid;version
        [requestString appendFormat:@"table[]=%@;%@;%@", @"Cities", @"0", @"1"];
        [requestString appendFormat:@"&table[]=%@;%@;%@", @"Cities_translation", @"0", @"1"];
        [requestString appendFormat:@"&table[]=%@;%@;%@", @"Currencies", @"0", @"1"];
        
        NSURL *url = [NSURL URLWithString:requestString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        connection = [NSURLConnection connectionWithRequest:request delegate:self];
        
        //перевірка наявності з'єднання з сервером
        if (connection) {
            //якщо з'єднання є
            responseData = [[NSMutableData alloc] init];
        }
        else
        {
            //якщо з'єднання нема
            // Inform the user that the connection failed.
            UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"URL Connection"
                                                                         message:@"Not success URL connection"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Ok"
                                                               otherButtonTitles:nil];
            [connectFailMessage show];

        }
        
    }
    else
    {
        //якщо інету нема
        UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"Internet Connection"
                                                                     message:@"Not success Internet connection"
                                                                    delegate:self
                                                           cancelButtonTitle:@"Ok"
                                                           otherButtonTitles:nil];
        [connectFailMessage show];

    }
}

@end
