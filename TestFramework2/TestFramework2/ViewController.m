//
//  ViewController.m
//  TestFramework2
//
//  Created by heartjhl on 2019/11/14.
//  Copyright © 2019 heartjhl. All rights reserved.
//

#import "ViewController.h"
#import <DyldFramework/DyldFramework_ios.h>
//#import <DyldFramework/DyldStudent+Category.h>

@interface ViewController ()
//-all_load
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    DyldStudent *stu = [[DyldStudent alloc]init];
//    [stu eat]; 
    [stu run];
    NSLog(@"🔥：%f",DyldFrameworkVersionNumber);
     
    NSLog(@"🍎：%s",DyldFrameworkVersionString);
}
@end
