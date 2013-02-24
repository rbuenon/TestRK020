//
//  ApiAccess.h
//  RKTest
//
//  Created by Ruben on 2/24/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


#import "Colour.h"

typedef void(^ErrorBlock)(NSError *error);
typedef void(^SuccessBlock)(NSArray *objects);

@interface ApiAccess : NSObject

+(ApiAccess*)sharedClient;

-(void)getColours:(SuccessBlock)successBlock onFail:(ErrorBlock)errorBlock;

@end
