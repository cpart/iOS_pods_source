//
//  AMSecureVault.h
//  Tag
//
//  Created by Raúl Pérez on 18/12/15.
//  Copyright © 2015 Adapt Mobile ApS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMVault : NSObject

- (instancetype)init;
- (instancetype)initWithVaultName:(NSString*)vaultName;

- (void)setObject:(id)object forKey:(NSString*)key;
- (id)objectForKey:(NSString*)key;
- (void)removeObjectForKey:(NSString*)key;
- (void)removeAllObjects;

@end
