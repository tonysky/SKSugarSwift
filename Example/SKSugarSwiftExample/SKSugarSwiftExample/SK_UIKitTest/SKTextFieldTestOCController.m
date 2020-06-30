//
//  SKTextFieldTestOCController.m
//  SKSugarSwiftExample
//
//  Created by Sky on 2020/6/30.
//  Copyright © 2020 Sky. All rights reserved.
//

#import "SKTextFieldTestOCController.h"
#import "SKSugarSwiftExample-Swift.h"

@interface SKTextFieldTestOCController ()

@property (nonatomic, strong) SKTextField *txtF;

@end

@implementation SKTextFieldTestOCController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.txtF = [[SKTextField alloc] initWithSk_text:@"测试" fontSize:15 textColor:UIColor.redColor isBold:false placeholder:@"pl" placeholderFontSize:15 placeholderColor:UIColor.grayColor isPlaceholderBold:false textAlignment:NSTextAlignmentLeft isAutoHeight:false];
    [self.view addSubview:self.txtF];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.txtF.frame = CGRectMake(20, 150, 200, 65);
}


@end
