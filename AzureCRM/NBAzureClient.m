//
//  NBAzureClient.m
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <MicrosoftAzureMobile/MicrosoftAzureMobile.h>

#import "NBAzureClient.h"


@interface NBAzureClient()

@property (strong, nonatomic) MSClient *client;
@property (weak, nonatomic, readwrite) MSUser *currentUser;

@end

@implementation NBAzureClient

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    NSString *appAddress = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"AzureAppURL"];
    _client = [MSClient clientWithApplicationURLString:appAddress];
    return self;
}

- (void)authenticateWithAccessToken:(NSString *)token completion:(void (^)(BOOL success, NSError *error))completion; {
    
    NBAzureClient * __weak weakSelf = self;
    [self.client loginWithProvider:@"facebook" token:@{@"access_token": token} completion:^(MSUser * _Nullable user, NSError * _Nullable error) {
        if (error) {
            completion(NO, error);
        } else {
            weakSelf.currentUser = user;
            completion(YES, nil);
        }
    }];
    
}

- (void)readAllFromTable:(NSString *)tableName completion:(void (^)(NSArray *results, NSError *error))completion; {
    MSTable *table = [self.client tableWithName:tableName];
    
    [table readWithCompletion:^(MSQueryResult * _Nullable result, NSError * _Nullable error) {
        if (!error) {
            completion(result.items, nil);
        } else {
            completion(nil, error);
        }
    }];
}

- (void)saveContactInfo:(NSDictionary *)contactInfo withCompletion:(void (^)(NSDictionary *contact, NSError *error))completion ;{
    MSTable *contactTable = [self.client tableWithName:@"contact"];
    [contactTable insert:contactInfo completion:^(NSDictionary * _Nullable item, NSError * _Nullable error) {
        completion(item, error);
    }];
}

@end
