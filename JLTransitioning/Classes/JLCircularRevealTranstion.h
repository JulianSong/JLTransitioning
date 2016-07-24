//
//  JLCircularRevealTranstion.h
//  Pods
//
//  Created by Julian.Song on 16/7/24.
//
//

#import <Foundation/Foundation.h>
@interface JLCircularRevealTranstion : NSObject <UIViewControllerAnimatedTransitioning,UIViewControllerAnimatedTransitioning>
@property(nonatomic,assign)CGRect startFrame;
@property (getter=isReverse) BOOL reverse;
@end
