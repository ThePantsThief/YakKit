//
//  YYClient+Yaks.m
//  Pods
//
//  Created by Tanner on 11/13/15.
//
//

#import "YYClient+Yaks.h"
#import "YYYak.h"
#import "YYComment.h"
#import "YYPeekLocation.h"
#import "YYNotification.h"
#import "NSDictionary+Networking.h"


@implementation YYClient (Yaks)

#pragma mark Getting yak feeds

- (void)getLocalYaks:(ArrayBlock)completion {
    [self get:^(TBURLRequestBuilder *make) {
        make.baseURL(kBaseFeedURL).endpoint(kepGetYaksAndLocations);
        make.queries([self generalQuery:@{@"loc": @"false"}]);
    } callback:^(TBResponseParser *parser) {
        [self completeWithClass:[YYYak class] jsonArray:parser.JSON[@"messages"] error:parser.error completion:completion];
    }];
}

- (void)getLocalHotYaks:(ArrayBlock)completion {
    [self get:^(TBURLRequestBuilder *make) {
        make.endpoint(kepGetHotYaks);
    } callback:^(TBResponseParser *parser) {
        [self completeWithClass:[YYYak class] jsonArray:parser.JSON[@"messages"] error:parser.error completion:completion];
    }];
}

- (void)getLocalTopYaks:(ArrayBlock)completion {
    [self get:^(TBURLRequestBuilder *make) {
        make.endpoint(kepGetAreaTopYaks);
    } callback:^(TBResponseParser *parser) {
        [self completeWithClass:[YYYak class] jsonArray:parser.JSON[@"messages"] error:parser.error completion:completion];
    }];
}

- (void)getYaksInPeek:(YYPeekLocation *)location hot:(BOOL)hot completion:(ArrayBlock)completion {
    NSDictionary *query = [self generalQuery:@{@"herdID": location.identifier, @"peekID": location.identifier}];
    if (hot) {
        query = [query dictionaryByReplacingValuesForKeys:@{@"hot": @"true"}];
    }
    
    [self get:^(TBURLRequestBuilder *make) {
        make.endpoint(kepGetPeekYaks).queries(query);
    } callback:^(TBResponseParser *parser) {
        [self completeWithClass:[YYYak class] jsonArray:parser.JSON[@"messages"] error:parser.error completion:completion];
    }];
}

#pragma mark Getting info about a yak

- (void)getYak:(YYNotification *)notification completion:(ResponseBlock)completion {
    NSDictionary *query = [self generalQuery:@{@"messageID": notification.thingIdentifier,
                                               @"notificationType": YYStringFromNotificationReason(notification.reason)}];
    
    [self get:^(TBURLRequestBuilder *make) {
        make.endpoint(kepGetYakInfo).queries(query);
    } callback:^(TBResponseParser *parser) {
        completion(parser.error ? nil : [[YYYak alloc] initWithDictionary:[parser.JSON[@"messages"] firstObject]], parser.error);
    }];
}

- (void)getCommentsForYak:(YYYak *)yak completion:(ArrayBlock)completion {
    [self get:^(TBURLRequestBuilder *make) {
        make.endpoint(kepGetComments).queries([self generalQuery:@{@"messageID": yak.identifier}]);
    } callback:^(TBResponseParser *parser) {
        [self completeWithClass:[YYComment class] jsonArray:parser.JSON[@"comments"] error:parser.error completion:completion];
    }];
}

@end
