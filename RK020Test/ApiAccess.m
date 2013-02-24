//
//  ApiAccess.m
//  RKTest
//
//  Created by Ruben on 2/24/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import "ApiAccess.h"

static NSString * const kApiAccessBaseURL =  @"http://localhost:4567";

@interface ApiAccess() {

}
@property(nonatomic,assign)RKObjectManager *serviceClient;

@end


@implementation ApiAccess

static ApiAccess * myInstance=nil;

+(ApiAccess*)sharedClient {
    @synchronized(self) {
        if (myInstance==nil) {
            myInstance=[[ApiAccess alloc]init];
            [myInstance prepareMapping];
        }
    }
    return myInstance;
}

-(id)init {
    myInstance=[super init];
    if(myInstance) {
        myInstance.serviceClient = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:kApiAccessBaseURL]];
        [RKObjectManager setSharedManager:myInstance.serviceClient];
    }
    return myInstance;
}



-(void)prepareMapping {
    
    RKObjectMapping *colourMapping = [RKObjectMapping mappingForClass:[Colour class]];
    [colourMapping addAttributeMappingsFromDictionary:@{
     @"colourName"  :   @"name",
     @"hexValue"    :   @"hexValue"
     }];
    
    RKResponseDescriptor *descriptor = [RKResponseDescriptor responseDescriptorWithMapping:colourMapping
                                                          pathPattern:nil
                                                              keyPath:@"coloursArray"
                                                          statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [_serviceClient addResponseDescriptor:descriptor];
    
}

-(void)getColours:(SuccessBlock)successBlock onFail:(ErrorBlock)errorBlock {
    NSString *path = @"colours";
    
    NSLog(@"getting colours");

    
    [[RKObjectManager sharedManager] getObjectsAtPath:path parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"success: %@", mappingResult.array);
        successBlock(mappingResult.array);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"operation: %@\nerror: %@", operation.responseDescriptors,  error.localizedDescription);
        errorBlock(error);
    }];
    
}

//-(void)getColours:(RKObjectLoaderDidLoadObjectsBlock)successBlock onFail:(RKRequestDidFailLoadWithErrorBlock)failBlock {
//    NSString * resourcePath = @"/colours";
//      NSLog(@"Getting colours");
//    
//    [myInstance.serviceClient loadObjectsAtResourcePath:resourcePath usingBlock:^(RKObjectLoader *loader) {
//        loader.method=RKRequestMethodGET;
//        
//        loader.onDidLoadObjects = ^(NSArray * objects) {successBlock(objects);};
//        loader.onDidFailLoadWithError=^(NSError *error){failBlock(error);};
//    }];
//}


@end
