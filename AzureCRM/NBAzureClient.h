//
//  NBAzureClient.h
//  AzureCRM
//
//  Created by Norm Barnard on 1/31/16.
//  Copyright © 2016 NormBarnard. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSUser;

@interface NBAzureClient : NSObject

@property (weak, nonatomic, readonly) MSUser *currentUser;

- (void)authenticateWithAccessToken:(NSString *)token completion:(void (^)(BOOL success, NSError *error))completion;
- (void)readAllFromTable:(NSString *)tableName completion:(void (^)(NSArray *results, NSError *error))completion;
- (void)saveContactInfo:(NSDictionary *)contactInfo withCompletion:(void (^)(NSDictionary *contact, NSError *error))completion ;
- (void)queryHistoryForContact:(NSDictionary *)contact completion:(void (^)(NSArray *results, NSError *error))completion;
- (void)saveMessage:(NSDictionary *)message forContact:(NSDictionary *)contact completion:(void (^)(NSDictionary *message, NSError *error))completion;

@end
