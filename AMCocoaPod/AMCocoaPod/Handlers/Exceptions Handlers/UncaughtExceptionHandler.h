

#import <UIKit/UIKit.h>

@interface UncaughtExceptionHandler : NSObject {
	BOOL dismissed;
}

@end

void InstallUncaughtExceptionHandler();
