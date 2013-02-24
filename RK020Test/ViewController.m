//
//  ViewController.m
//  RK020Test
//
//  Created by Ruben on 2/24/13.
//  Copyright (c) 2013 Ruben. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    ApiAccess *api = [ApiAccess sharedClient];
    
    [api getColours:^(NSArray *objects){
        NSLog(@"%@", objects);
        [self drawcolours:(objects)];
    }
             onFail:^(NSError *error){
                 NSLog(@"%@", error.localizedDescription);
             }];
}


-(void)drawcolours:(NSArray*)array {
    float height = self.view.frame.size.height/array.count;
    
    for (int i=0; i<array.count; i++) {
        Colour *c = array[i];
        CGRect r = CGRectMake(0, i*height, self.view.frame.size.width, height);
        
        UILabel *l = [[UILabel alloc]initWithFrame:r];
        [l setText:c.name];
        
        [self.view addSubview:l];
        
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
