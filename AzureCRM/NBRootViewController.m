//
//  NBRootViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#import "NBAzureClient.h"
#import "NBContactsTableViewController.h"
#import "NBLoginViewController.h"
#import "NBRootViewController.h"

@interface NBRootViewController () <NBLoginViewControllerDelegate>

@property (strong, nonatomic) NBAzureClient *azureClient;
@property (weak, nonatomic) UIViewController *currentViewController;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


@end

@implementation NBRootViewController

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    _azureClient = [[NBAzureClient alloc] init];
    return self;
}

- (NSString *)nibName {
    return @"NBRootView";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (![FBSDKAccessToken currentAccessToken]) {
        [self _presentLoginViewControllerAnimated:NO];
    } else {
        NSString *token = [FBSDKAccessToken currentAccessToken].tokenString;
        [self _authenticateAzureClientWithFacebookToken:token];
    }
}

- (void)viewDidLayoutSubviews {
    self.currentViewController.view.frame = self.view.bounds;
}

- (void)_presentLoginViewControllerAnimated:(BOOL)animated {
    NBLoginViewController *loginViewController = [[NBLoginViewController alloc] init];
    loginViewController.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:navController animated:animated completion:nil];
}

- (void)_presentContactViewControllerWithAzureClient:(NBAzureClient *)azureClient;  {
    NBContactsTableViewController *viewController = [[NBContactsTableViewController alloc] initWithAzureClient:self.azureClient];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navController animated:YES completion:nil];
    self.currentViewController = navController;
}

- (void)loginViewController:(NBLoginViewController *)viewController didAuthenticateWithResults:(FBSDKLoginManagerLoginResult *)results error:(NSError *)error {
    [self _authenticateAzureClientWithFacebookToken:results.token.tokenString];
}

- (void)_authenticateAzureClientWithFacebookToken:(NSString *)facebookToken {
    [self.activityIndicator startAnimating];
    NBRootViewController * __weak weakSelf = self;
    [self.azureClient authenticateWithAccessToken:facebookToken completion:^(BOOL success, NSError *error) {
        [self.activityIndicator stopAnimating];
        if (success) {
            [weakSelf _presentContactViewControllerWithAzureClient:weakSelf.azureClient];
        }
    }];
}

@end
