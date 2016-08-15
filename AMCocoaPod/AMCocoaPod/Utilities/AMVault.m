//
//  AMSecureVault.m
//  Tag
//
//  Created by Raúl Pérez on 18/12/15.
//  Copyright © 2015 Adapt Mobile ApS. All rights reserved.
//

#import "AMVault.h"

#define kDefaultVaultName @"vault.dat"
#define kDefaultVaultDirectory @"Vaults"

static NSObject *LOCK;

@interface AMVault ()

@property (nonatomic) NSString *vaultPath;
@property (nonatomic) NSString *vaultDirectoryPath;
@property (nonatomic) NSString *vaultName;

@end

@implementation AMVault

- (instancetype)init {
    return [self initWithVaultName:nil];
}

- (instancetype)initWithVaultName:(NSString*)vaultName {
    if (self = [super init]) {
        LOCK = [NSObject new];

        self.vaultName = vaultName;
        
        if (!self.vaultName) {
            self.vaultName = kDefaultVaultName;
        }
        
        [self buildVaultPaths];
        [self createVault];
    }
    
    return self;
}

- (void)buildVaultPaths {
    if (!self.vaultName) {
        self.vaultName = kDefaultVaultName;
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    self.vaultDirectoryPath = [libraryDirectory stringByAppendingPathComponent:kDefaultVaultDirectory];
    self.vaultPath = [self.vaultDirectoryPath stringByAppendingPathComponent:self.vaultName];
}

- (void)createVault {
    NSFileManager* fileManager = [NSFileManager defaultManager];

    NSMutableDictionary *emptyDictionary = [NSMutableDictionary new];

    BOOL isDir;
    
    BOOL exists = [fileManager fileExistsAtPath:self.vaultDirectoryPath isDirectory:&isDir];
    
    if (!exists) {
        if ([fileManager createDirectoryAtPath:self.vaultDirectoryPath withIntermediateDirectories:YES attributes:nil error: NULL] == NO){
            // Failed to create directory
            NSLog(@"Failed to create directory: %@", self.vaultDirectoryPath);
        }
    }
    
    BOOL vaultExists = [fileManager fileExistsAtPath:self.vaultPath];

    if (!vaultExists) {
        [self writeVault:emptyDictionary];
    }
}
 

- (void)writeVault:(NSDictionary*)dictionary {
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:dictionary];
    NSData *encodedArchivedDataBase64 = [archivedData base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [encodedArchivedDataBase64 writeToFile:self.vaultPath atomically:YES];
}

- (NSMutableDictionary*)readVault {
    NSData *loadedDataEncodedArchivedDataBase64 = [NSData dataWithContentsOfFile:self.vaultPath];
    
    NSData *decodedArchivedData = [[NSData alloc] initWithBase64EncodedData:loadedDataEncodedArchivedDataBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSMutableDictionary *readDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:decodedArchivedData];
    
    return readDictionary;
}

- (void)setObject:(id)object forKey:(NSString*)key {
    @synchronized(LOCK) {
        NSMutableDictionary *vault = [self readVault];
        [vault setObject:object forKey:key];
        [self writeVault:vault];
    }
}

- (id)objectForKey:(NSString*)key {
    @synchronized(LOCK) {
        NSMutableDictionary *vault = [self readVault];
        return [vault objectForKey:key];
    }
}

- (void)removeObjectForKey:(NSString*)key {
    @synchronized(LOCK) {
        NSMutableDictionary *vault = [self readVault];
        [vault removeObjectForKey:key];
        [self writeVault:vault];
    }
}

- (void)removeAllObjects {
    @synchronized(LOCK) {
        NSMutableDictionary *vault = [NSMutableDictionary new];
        [self writeVault:vault];
    }
}

@end
