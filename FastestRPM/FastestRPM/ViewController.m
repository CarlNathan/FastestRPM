//
//  ViewController.m
//  FastestRPM
//
//  Created by Carl Udren on 1/21/16.
//  Copyright © 2016 Carl Udren. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *needle;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) UIPanGestureRecognizer *rotationRecognizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rotationRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(meterResponse)];
    self.rotationRecognizer.maximumNumberOfTouches = 1;
    [self.topView addGestureRecognizer:self.rotationRecognizer];
    self.needle.center = self.topView.center;
    self.needle.transform = CGAffineTransformMakeRotation(-3.8);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)meterResponse{
    
    CGPoint velocityComponents = [self.rotationRecognizer velocityInView:self.topView];
    float velocity = sqrt((velocityComponents.x * velocityComponents.x) + (velocityComponents.y * velocityComponents.y));
    NSLog(@"%f",velocity);
    self.needle.center = self.topView.center;
    float rotationAngle = fabs(-3.8 + (velocity/2000.0));
    [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.needle.transform = CGAffineTransformMakeRotation(rotationAngle);
    } completion:nil];
    if (self.rotationRecognizer.state == UIGestureRecognizerStateEnded){
        [UIView animateWithDuration:1.0 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.needle.transform = CGAffineTransformMakeRotation(-3.8);
        } completion:nil];
    }
}

@end
