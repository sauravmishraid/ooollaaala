//
//  swipeDownView.h
//  pullDownView
//
//  Created by Saurav  Mishra on 11/09/16.
//  Copyright © 2016 Saurav  Mishra. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface swipeDownView : NSObject<UIGestureRecognizerDelegate>
typedef NS_ENUM(NSInteger, panDirections)
{
    PanDirectionDown = 1,
    PanDirectionUp,
    panDirectionLeft,
    panDirectionRight,
};

+ (instancetype)pullDownViewSingleton;
-(void)addSwipeDownGestureToController:(UIViewController *)controller;

@property (nonatomic,strong) UIView *pullDownView;
@property (nonatomic,strong) UIViewController *parentController;
@property (nonatomic) BOOL isPullDownViewShown;
@end
