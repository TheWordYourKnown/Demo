//
//  CentralViewController.m
//  BlueTooth
//
//  Created by Kangqj on 15/11/2.
//  Copyright (c) 2015年 Kangqj. All rights reserved.
//

#import "CentralViewController.h"
#import "BumpViewController.h"


@interface CentralViewController ()
{
    UIButton *peripheralBtn;
}

@property (strong, nonatomic) UITableView *myTableView;

@end

@implementation CentralViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"搜索周边信号";
    
    [self setupUI];
    
    //搜索周边信号
    [[CentralOperateManager sharedManager] scanPeripheralSignal:^(CBPeripheral *peripheral) {
        
        [self findAnimationPeripheral:peripheral];
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[CentralOperateManager sharedManager] stopScanSign];
}

- (void)setupUI
{
    peripheralBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    peripheralBtn.frame = CGRectMake(0, 0, 100, 100);
    peripheralBtn.center = self.view.center;
    [peripheralBtn addTarget:self action:@selector(goToBumpView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:peripheralBtn];
    UIImage *image = [UIImage imageWithColor:[UIColor randomColor] size:CGSizeMake(100, 100)];
    [peripheralBtn setBackgroundImage:[UIImage imageWithCornerRadius:50 image:image] forState:UIControlStateNormal];
    peripheralBtn.layer.cornerRadius = 50;
    peripheralBtn.layer.shadowColor = [UIColor grayColor].CGColor;
    peripheralBtn.layer.shadowOffset = CGSizeMake(5, 5);
    peripheralBtn.layer.shadowOpacity = 0.6;
    peripheralBtn.hidden = YES;
}

- (void)goToBumpView
{
    BumpViewController *bumpViewController = [[BumpViewController alloc] init];
    [self.navigationController pushViewController:bumpViewController animated:YES];
}

- (void)findAnimationPeripheral:(CBPeripheral *)peripheral
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    
    NSMutableArray *values = [NSMutableArray array];
    
    peripheralBtn.hidden = NO;
    [peripheralBtn setTitle:peripheral.name forState:UIControlStateNormal];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    animation.values = values;
    [peripheralBtn.layer addAnimation:animation forKey:nil];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
