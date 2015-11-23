//
//  YYClient+Misc.h
//  Pods
//
//  Created by Tanner on 11/13/15.
//
//

#import "YYClient.h"


NS_ASSUME_NONNULL_BEGIN

@interface YYClient (Misc)

#pragma mark Misc
- (void)logEvent:(NSDictionary *)params completion:(nullable ErrorBlock)completion;
- (void)refreshLocate:(nullable ErrorBlock)completion;

@end

NS_ASSUME_NONNULL_END
