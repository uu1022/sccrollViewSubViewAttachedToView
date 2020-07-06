//
//  ViewController.m
//  sccrollViewSubViewAttachedToView
//
//  Created by 李煜 on 2020/7/5.
//  Copyright © 2020 李煜. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIView *subView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = 0;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSUInteger count = 18;
    CGFloat height = 200;
    for (NSUInteger i=0; i<count; i++) {
        UIView *v1 =[[UIView alloc]initWithFrame:(CGRect){0,i*height,size.width,height}];
        UIColor *randomColor = [self RandomColor];
        v1.backgroundColor = randomColor;
        if (i==4) {
            UILabel*label = [[UILabel alloc]initWithFrame:v1.bounds];
            label.text = @"I love u";
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
            self.subView = [[UIView alloc]initWithFrame:v1.bounds];
            [self.subView addSubview:label];
            [v1 addSubview:self.subView];
        }
        [self.scrollView addSubview:v1];
    }
    self.scrollView.contentSize = CGSizeMake(size.width, count*height);
    
}

- (UIColor*)RandomColor {
    NSInteger aRedValue =arc4random() %255;
    NSInteger  aGreenValue =arc4random() %255;
    NSInteger aBlueValue =arc4random() %255;
    UIColor*randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
    return randColor;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    UIView *v1= [[scrollView subviews] objectAtIndex:4];
    CGPoint subViewPointInView = [v1 convertPoint:self.subView.frame.origin toView:self.view];

    
    CGFloat y = subViewPointInView.y;
    
    if (y<20) {
        if ([self.subView.superview isEqual:self.view]) {
            return;
        }
        self.subView.frame = CGRectMake(0, 20, CGRectGetWidth(scrollView.frame), 200);
        [self.view addSubview:self.subView];
    }else{
        if (![self.subView.superview isEqual:self.view]) {
            return;
        }
        self.subView.frame = CGRectMake(0, 0, CGRectGetWidth(scrollView.frame), 200);
        [v1 addSubview:self.subView];
    }
}
@end
