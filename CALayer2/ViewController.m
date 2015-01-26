//
//  ViewController.m
//  CALayer2
//
//  Created by Lin Dong on 1/25/15.
//  Copyright (c) 2015 Lin Dong. All rights reserved.
//

#import "ViewController.h"
#define SCALE_FACTOR 5.0f

@interface ViewController ()
@property (nonatomic, strong) CALayer *imageLayer;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) UIImage *imageContents;
@property (nonatomic, strong) UIImage *maskContents;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
//  [self calayerTransform];
  [self calayerMask];
}

-(void) calayerMask{
//  self.view.backgroundColor = [UIColor blackColor];
  self.view.backgroundColor = [UIColor grayColor];

  self.imageContents = [UIImage imageNamed:@"a.jpg"];
  self.maskContents = [UIImage imageNamed:@"mask"];

  self.imageLayer = [CALayer layer];
  self.imageLayer.frame = CGRectMake(0, 0,
                                     self.imageContents.size.width/SCALE_FACTOR,
                                     self.imageContents.size.height/SCALE_FACTOR);
  self.imageLayer.contents = (__bridge id)self.imageContents.CGImage;
  [self.view.layer addSublayer:self.imageLayer];

  self.maskLayer = [CALayer layer];
  self.maskLayer.frame = self.imageLayer.bounds; // mask is based on imageLayer
//  [self.view.layer addSublayer:self.maskLayer]; // no need for add layer to the whole view
  self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
//  self.maskLayer.contents = (__bridge id)self.maskContents.CGImage;

  self.imageLayer.mask = self.maskLayer;

  [self performSelector:@selector(maskLayerAnimation) withObject:nil afterDelay:1.f];
}

-(void) maskLayerAnimation{
//  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
  self.maskLayer.frame = CGRectMake(35, 15, 200, 200);
  self.imageLayer.mask.cornerRadius = 100;
}

-(void) calayerTransform{
  //  UIImage *image = [UIImage imageNamed:@"a.jpg"];
  //  UIImage *image2 = [UIImage imageWithCGImage:[image CGImage]
  //                      scale: 0.3f//image.size.height // [[UIScreen mainScreen] bounds].size.height
  //                orientation:image.imageOrientation];
  //  self.view.layer.contents = (__bridge id)(image2.CGImage);
  //  [self.view addSubview:image];

  UIImage *imageA = [UIImage imageNamed:@"a.jpg"];
  self.imageLayer = [CALayer layer];
  self.imageLayer.frame = CGRectMake(0, 0, 1680/SCALE_FACTOR, 1057/SCALE_FACTOR);
  [self.view.layer addSublayer:self.imageLayer];
  self.imageLayer.contents = (__bridge id) imageA.CGImage;

    [self performSelector:@selector(layerAnimation) withObject:nil afterDelay:1.f];
  //  [self performSelector:@selector(customizedLayerAnimation) withObject:nil afterDelay:1.f];
//  [self performSelector:@selector(customizedLayerAnimationGroup) withObject:nil afterDelay:1.f];
}

-(void) layerAnimation{
  UIImage *imageB = [UIImage imageNamed:@"b.jpg"];
  self.imageLayer.frame = CGRectMake(0, 0, imageB.size.width/SCALE_FACTOR, imageB.size.height/SCALE_FACTOR);
  self.imageLayer.contents =  (__bridge id) imageB.CGImage;
}

-(void) customizedLayerAnimation {
  UIImage *imageB = [UIImage imageNamed:@"b.jpg"];
  self.imageLayer.frame = CGRectMake(0, 0, imageB.size.width/SCALE_FACTOR, imageB.size.height/SCALE_FACTOR);
  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
  contentsAnimation.fromValue = self.imageLayer.contents;
  contentsAnimation.toValue =  (__bridge id) imageB.CGImage;
  contentsAnimation.duration = 1.f;

  self.imageLayer.contents =  (__bridge id) imageB.CGImage;
  [self.imageLayer addAnimation:contentsAnimation forKey:@"nil"];
}

-(void) customizedLayerAnimationGroup{
  UIImage *imageB = [UIImage imageNamed:@"b.jpg"];
  self.imageLayer.frame = CGRectMake(0, 0, imageB.size.width/SCALE_FACTOR, imageB.size.height/SCALE_FACTOR);
  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
//  CABasicAnimation *contentsAnimation = [CABasicAnimation animationWithKeyPath:@"contents"];
  contentsAnimation.fromValue = self.imageLayer.contents;
  contentsAnimation.toValue =  (__bridge id) imageB.CGImage;
  contentsAnimation.duration = 1.f;

  CABasicAnimation *boundsAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
  // convert bounds to an object
  boundsAnimation.fromValue = [NSValue valueWithCGRect:self.imageLayer.bounds];
  boundsAnimation.toValue =  [NSValue valueWithCGRect:
                              CGRectMake(0, 0, imageB.size.width/2.f/SCALE_FACTOR,
                                         imageB.size.height/2.f/SCALE_FACTOR)];
  boundsAnimation.duration = 1.f;

  CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
  groupAnimation.animations = @[contentsAnimation, boundsAnimation];
  groupAnimation.duration = 1.f;

  self.imageLayer.contents =  (__bridge id) imageB.CGImage;
  self.imageLayer.bounds =  CGRectMake(0, 0, imageB.size.width/2.f/SCALE_FACTOR,
                                       imageB.size.height/2.f/SCALE_FACTOR);

  [self.imageLayer addAnimation:groupAnimation forKey:nil];

}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
