//
//  SUUpdateDriver.m
//  Sparkle
//
//  Created by Andy Matuschak on 5/7/08.
//  Copyright 2008 Andy Matuschak. All rights reserved.
//

#import "SUUpdateDriver.h"
#import "SUHost.h"

NSString * const SUUpdateDriverFinishedNotification = @"SUUpdateDriverFinished";

@implementation SUUpdateDriver
{
    NSURL *appcastURL;
}

@synthesize updater;
@synthesize host;
@synthesize interruptible = isInterruptible;
@synthesize finished;

- (instancetype) initWithUpdater:(SUUpdater *)anUpdater
{
	if ((self = [super init])) {
		updater = anUpdater;
	}
	return self;
}

- (NSString *)description { return [NSString stringWithFormat:@"%@ <%@, %@>", [self class], [host bundlePath], [host installationPath]]; }

- (void)checkForUpdatesAtURL:(NSURL *)URL host:(SUHost *)h
{
	appcastURL = [URL copy];
	host = h;
}

- (void)abortUpdate
{
	[self setValue:@YES forKey:@"finished"];
	[[NSNotificationCenter defaultCenter] postNotificationName:SUUpdateDriverFinishedNotification object:self];
}

- (void)setInterruptible:(BOOL)interruptible
{
    isInterruptible = interruptible;
}

@end
