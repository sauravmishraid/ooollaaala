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


//Change #1

//Change
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
   NSLog(@"%@",[NSNumber numberWithBool:self.isPullDownViewShown]);
    CGPoint velocity = [panGesture velocityInView:self.parentController.view];
    CGPoint distanceMoved =[panGesture translationInView:self.parentController.view];
    
    if (distanceMoved.y<=0) {
        //NSLog(@"%f",distanceMoved.y);

    }
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
                    self.isPullDownViewShown=YES;
                        CGFloat heightToSlide=0.0f;
                        CGPoint distanceMoved =[panGesture translationInView:self.parentController.view];
                    if ((distanceMoved.y>=0.0f)&&(distanceMoved.y<=64.0)) {
                        heightToSlide=distanceMoved.y;
                    }
                    else if((distanceMoved.y>64.0f) || (distanceMoved.y<=0.0f)){
                    (heightToSlide=64.0f);
                    }
                    NSLog(@"Down : %f , distance : %f", heightToSlide,distanceMoved.y);
                    
                    if (heightToSlide>=0 && heightToSlide<=64.0f) {
                        [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                            CGRect  newParentControllerView= CGRectMake(self.parentController.view.frame.origin.x,heightToSlide, self.parentController.view.frame.size.width, self.parentController.view.frame.size.height);
                            [self.parentController.view insertSubview:self.pullDownView aboveSubview:self.parentController.view];
                            self.parentController.view.frame=newParentControllerView;

                        } completion:nil];
                    }
                    distanceMoved=CGPointZero;


                }
                    break;
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            {
                //self.isPullDownViewShown=NO;

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
                        NSLog(@"Up : %f , distance : %f", heightToSlide,distanceMoved.y);
                        if (heightToSlide>=0) {
                            [UIView animateWithDuration:0.25f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    CGRect  newParentControllerView= CGRectMake(self.parentController.view.frame.origin.x,heightToSlide,self.parentController.view.frame.size.width, self.parentController.view.frame.size.height);
                                    self.parentController.view.frame=newParentControllerView;
                                });

                            } completion:nil];
                                if(heightToSlide==0.0f){
                                    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                                        [self.pullDownView removeFromSuperview];
                                    } completion:nil];
                                
                                self.isPullDownViewShown=NO;
                                NSLog(@"Inside hidden view.");
                            }

                        }
                        distanceMoved=CGPointZero;

                    }
                }
                    break;
                case UIGestureRecognizerStateFailed:
                case UIGestureRecognizerStateCancelled:
                {
                    self.isPullDownViewShown=YES;
                    
                }
                    break;                    break;
                default:
                    break;
            }

        }
    }
}

/*-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
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
}*/
@end
