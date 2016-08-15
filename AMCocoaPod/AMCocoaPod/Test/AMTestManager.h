//
//  AMTestManager.h
//  AMCocoaPod
//
//  Created by Raúl Pérez on 10/09/14.
//  Copyright (c) 2014 Adapt Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface AMTestManager : NSObject

+ (AMTestManager *)sharedManager;
+ (id)populatedInstanceWithClass:(Class)klass;

@end
