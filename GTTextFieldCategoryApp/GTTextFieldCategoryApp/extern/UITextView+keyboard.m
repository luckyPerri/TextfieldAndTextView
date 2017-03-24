//
//  UITextView+keyboard.m
//  GTTextFieldCategoryApp
//
//  Created by zhaoke.hzk on 17/3/24.
//  Copyright © 2017年 zhaoke.hzk. All rights reserved.
//

#import "UITextView+keyboard.h"
#import <objc/runtime.h>
const char textviewKeyboardKey;
@implementation UITextView (keyboard)

-(void)setIsAutoAdjust:(BOOL)isAutoAdjust{
    
    objc_setAssociatedObject(self, &textviewKeyboardKey,@(isAutoAdjust), OBJC_ASSOCIATION_ASSIGN);
    if (isAutoAdjust) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

-(BOOL)isAutoAdjust{
    return  objc_getAssociatedObject(self, &textviewKeyboardKey);
}

-(void)keyboardWillShow:(NSNotification* )notify{
    
    CGPoint convertedPoint = [self convertPoint:CGPointZero toView:[UIApplication sharedApplication].keyWindow];
    CGRect startKeyboardRect = [notify.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect keyboardRect = [notify.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (startKeyboardRect.size.height>0 &&startKeyboardRect.origin.y - keyboardRect.origin.y>0) {
        CGFloat animationDuration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat offsetHeight = convertedPoint.y + self.frame.size.height + 5 +keyboardRect.size.height - screenHeight;
        if (offsetHeight > 0) {
            CGRect keywindowframe = [UIScreen mainScreen].bounds;
            keywindowframe.origin.y-=offsetHeight;
            [UIView animateWithDuration:animationDuration animations:^{
                [UIApplication sharedApplication].keyWindow.frame = keywindowframe;
            }];
        }else{
            
        }
        
    }
    
}

-(void)keyboardWillHide:(NSNotification* )notify{
    if (self.isFirstResponder) {
        CGFloat animationDuration = [notify.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect frame = [UIScreen mainScreen].bounds;
        [UIView animateWithDuration:animationDuration animations:^{
            [UIApplication sharedApplication].keyWindow.frame = frame;
        }];
    }else{
        
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
