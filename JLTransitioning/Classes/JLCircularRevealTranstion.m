//
//  JLCircularRevealTranstion.m
//  Pods
//
//  Created by Julian.Song on 16/7/24.
//
//

#import "JLCircularRevealTranstion.h"

#import <QuartzCore/QuartzCore.h>
@interface JLCircularRevealTranstion()
@end

@implementation JLCircularRevealTranstion

- (instancetype) init
{
    self = [super init];
    if (self) {
        CGPoint center = [[[UIApplication sharedApplication] keyWindow] center];
        _startFrame = CGRectMake(center.x - 20,center.y -20,40,40);
    }
    return self;
}

- (CGFloat )radiusOfRect:(CGRect)rect
{
    CGFloat x = rect.size.width;
    CGFloat y = rect.size.height;
    return sqrtf(x*x + y*y);
}

- (CGRect)squareAroundCircleWithRect:(CGRect )rect andCenter:(CGPoint)center;
{
    CGFloat radius = [self radiusOfRect:rect];
    return CGRectInset(CGRectMake(center.y,center.y,0,0), -radius, -radius);
}

- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3f;
}

- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView  *containerView   = [transitionContext containerView];
    UIViewController *presentedController;
    
    CGPathRef fromPath,toPath;
    if(!self.isReverse){
        presentedController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        presentedController.view.frame = containerView.bounds;
        [containerView addSubview:presentedController.view];
        fromPath =  CGPathCreateWithEllipseInRect(self.startFrame, NULL);
        toPath = CGPathCreateWithEllipseInRect([self squareAroundCircleWithRect:presentedController.view.frame andCenter:presentedController.view.center], NULL);
    }
    else{
        presentedController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        
        presentedController.view.frame = containerView.bounds;
        [containerView addSubview:presentedController.view];
        fromPath =  CGPathCreateWithEllipseInRect([self squareAroundCircleWithRect:presentedController.view.frame andCenter:presentedController.view.center], NULL);;
        toPath = CGPathCreateWithEllipseInRect(self.startFrame, NULL);;
    }
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(fromPath);
    animation.toValue = (__bridge id _Nullable)(toPath);
    animation.duration = [self transitionDuration:transitionContext];
    animation.delegate = self;
    [animation setValue:transitionContext forKey:@"transitionContext"];
    [animation setValue:presentedController.view.layer forKey:@"presentedController.view.layer"];
    
    CAShapeLayer *mask = [CAShapeLayer layer];
    mask.path = toPath;
    mask.fillRule = kCAFillRuleEvenOdd;
    presentedController.view.layer.mask = mask;
    
    [mask addAnimation:animation forKey:@"CircularReveal"];
    CGPathRelease(fromPath);
    CGPathRelease(toPath);
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
        [transitionContext completeTransition:YES];
        CALayer *layer = [anim valueForKey:@"presentedController.view.layer"];
        layer.mask = nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.reverse = false;
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.reverse =  true;
    return self;
}
@end
