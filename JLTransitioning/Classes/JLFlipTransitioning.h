//
//  JLFlipTransitioning.h
//  Pods
//
//  Created by Julian.Song on 16/7/21.
//
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,JLFlipTransitioningDirection){
    JLFlipTransitioningDirectionLeft,
    JLFlipTransitioningDirectionRight,
    JLFlipTransitioningDirectionBottom,
};
@interface JLFlipTransitioning : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property(nonatomic,assign,getter=isReverse)BOOL reverse;
@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,weak)UIViewController *presentedController;
@property(nonatomic,weak)UIView *containerView;
@property(nonatomic,assign)JLFlipTransitioningDirection direction;
@property(nonatomic,assign)CGSize presentSize;
@end
