//
//  NBLoginViewController.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "NBLoginViewController.h"

@interface NBLoginViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation NBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSString *)nibName {
    return @"NBLoginView";
}

- (IBAction)loginButtonTapped:(UIButton *)sender {
    
    FBSDKLoginManager *loginManger = [[FBSDKLoginManager alloc] init];
    
    NBLoginViewController * __weak weakSelf = self;
    [loginManger logInWithReadPermissions:@[@"public_profile"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        [weakSelf.delegate loginViewController:weakSelf didAuthenticateWithResults:result error:error];
    }];
    
}

@end
