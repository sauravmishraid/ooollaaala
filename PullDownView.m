//
//  PullDownView.m
//  pullDownView
//
//  Created by Saurav  Mishra on 10/09/16.
//  Copyright © 2016 Saurav  Mishra. All rights reserved.
//

#import "PullDownView.h"

@implementation PullDownView

static PullDownView *pullDownVieSingleton=nil;




+ (instancetype)pullDownViewSingleton {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pullDownVieSingleton = [[PullDownView alloc] init];
    });
    
    return pullDownVieSingleton;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pullDownView =[[[NSBundle mainBundle] loadNibNamed:@"PullDownNib" owner:self options:nil] objectAtIndex:0];
    }
    return self;
}

-(void)addSwipeDownGestureToController:(UIViewController *)controller
{
    self.parentController=controller;
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGensture:)];
    panRecognizer.delegate=self;
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [self.parentController.view addGestureRecognizer:panRecognizer];
    self.pullDownView.frame=CGRectMake(0.0f, 0.0f, self.parentController.view.frame.size.width, 64.0f);
}

-(void)handlePanGensture:(UIPanGestureRecognizer *)panGesture
{
    CGPoint velocity = [panGesture velocityInView:self.parentController.view];
    BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
    if (isVerticalGesture) {
        if (velocity.y > 0) {
            switch (panGesture.state) {
                case UIGestureRecognizerStateBegan:
                {
                    
                }
              break;
                    case UIGestureRecognizerStateChanged:
                {
                    CGFloat heightToSlide=0.0f;
                    CGPoint distanceMoved =[panGesture translationInView:self.parentController.view];
                    (distanceMoved.y>=64.0f)?(heightToSlide=64.0f):(heightToSlide=distanceMoved.y);
                     CGRect  newParentControllerView= CGRectMake(self.parentController.view.frame.origin.x,heightToSlide, self.parentController.view.frame.size.width, self.parentController.view.frame.size.height);
                    [self.parentController.view insertSubview:self.pullDownView aboveSubview:self.parentController.view];
                    self.parentController.view.frame=newParentControllerView;
                    distanceMoved=CGPointZero;
                }
                    break;
        case UIGestureRecognizerStateEnded:
            {
                self.isPullDownViewShown=!self.isPullDownViewShown;
                
            }
            break;
        default:
            break;
        }
        }
        else
        {
            switch (panGesture.state) {
                case UIGestureRecognizerStateBegan:
                {
                }
                    break;
                case UIGestureRecognizerStateChanged:
                {
                    if(self.isPullDownViewShown)
                    {
                        CGFloat heightToSlide=0.0f;
                        CGPoint distanceMoved =[panGesture translationInView:self.parentController.view];
                        (fabs(distanceMoved.y)>=64.0f)?(heightToSlide=-64.0f):(heightToSlide=distanceMoved.y);
                        heightToSlide=64.0f+heightToSlide;
                        CGRect  newParentControllerView= CGRectMake(self.parentController.view.frame.origin.x,heightToSlide,self.parentController.view.frame.size.width, self.parentController.view.frame.size.height);
                        self.parentController.view.frame=newParentControllerView;
                        distanceMoved=CGPointZero;
                        if(heightToSlide==0.0f){
                            panGesture.enabled=NO;
                            [self.pullDownView removeFromSuperview];
                            self.isPullDownViewShown=!self.isPullDownViewShown;

                        }
                    }
                }
                    break;
                case UIGestureRecognizerStateEnded:
                {
                }
                    break;
                default:
                    break;
            }

        }
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:self.parentController.view];
    CGPoint distanceMoved =[gestureRecognizer translationInView:self.parentController.view];
    BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
    if(isVerticalGesture)
    {
         if (velocity.y > 0)
         {
             if (distanceMoved.y>=64.0f)
             {
                 gestureRecognizer.enabled=NO;
             }
         }
         else{
             
             if (fabs(distanceMoved.y)<=64.0f)
             {
             }
         }
    }
    else
    {
       // return NO;
    }
    return YES;
}
@end
