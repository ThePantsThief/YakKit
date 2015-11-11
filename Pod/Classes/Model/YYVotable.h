//
//  YYVotable.h
//  Pods
//
//  Created by Tanner on 11/10/15.
//
//

#import "YYThing.h"


typedef NS_ENUM(NSUInteger, YYVoteStatus)
{
    YYVoteStatusDownvoted = -1,
    YYVoteStatusNone = 0,
    YYVoteStatusUpvoted = 1
};


NS_ASSUME_NONNULL_BEGIN

@interface YYVotable : YYThing <MTLJSONSerializing>

@property (nonatomic, readonly) NSInteger    score;
@property (nonatomic, readonly) YYVoteStatus voteStatus;

@property (nonatomic, readonly) NSDate *created;
@property (nonatomic, readonly) NSDate *gmt;

@property (nonatomic, readonly) NSString *deliveryIdentifier;

@end

NS_ASSUME_NONNULL_END