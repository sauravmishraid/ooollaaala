//
//  PullDownView.h
//  pullDownView
//
//  Created by Saurav  Mishra on 10/09/16.
//  Copyright © 2016 Saurav  Mishra. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, panDirections)
{
    PanDirectionDown = 1,
    PanDirectionUp,
    panDirectionLeft,
    panDirectionRight,
};
@interface PullDownView : NSObject<UIGestureRecognizerDelegate>

+ (instancetype)pullDownViewSingleton;
-(void)addSwipeDownGestureToController:(UIViewController *)controller;

@property (nonatomic,strong) UIView *pullDownView;
@property (nonatomic,strong) UIViewController *parentController;
@property (nonatomic) BOOL isPullDownViewShown;
@end
