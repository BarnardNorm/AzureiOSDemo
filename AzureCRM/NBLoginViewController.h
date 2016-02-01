//
//  NBLoginViewController.h
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FBSDKLoginManagerLoginResult;

@protocol NBLoginViewControllerDelegate;

@interface NBLoginViewController : UIViewController

@property (weak, nonatomic) id<NBLoginViewControllerDelegate> delegate;

@end


@protocol NBLoginViewControllerDelegate <NSObject>

- (void)loginViewController:(NBLoginViewController *)viewController didAuthenticateWithResults:(FBSDKLoginManagerLoginResult *)results error:(NSError *)error;

@end