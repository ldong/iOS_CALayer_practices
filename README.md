# CALayer Notes

Topic: [iOS中CALayer的使用](http://www.jikexueyuan.com/course/397.html)

Author: Lin Dong

Date: Sun Jan 25 20:42:33 PST 2015

## CALayer 1

CALayer is the actual 'view' of the UIView
Change layer's frame and color will change UIView's frame and color
Layer uses [UIColor greenColor].CGColor;

UIView layer can have multiple sublayers

隱式動畫, UIKit takes care of the animation underlying.


## CALayer 2

顯式動畫, You have to handle the animation, with the flexibility of time

UIImageView CALayer Bounds
UIImageView CALayer contents
CAAnimationGroup group bounds animation and contents animation
encapsulate into UIView

```objc
UIImage *image = [UIImage imageNamed:@"a.jpg"];
UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
[self.view addSubview:imageView];
```
Or
```objc
UIImage *image = [UIImage imageNamed:@"a.jpg"];
self.view.layer.contents = (__bridge id)(image.CGImage);
```
Core Animation, only works on layer, not change the contents. And it will
rollback to what the contents was after animation finished.

## CALayer 3

Mask

```objc
self.imageLayer = [CALayer layer];
self.imageLayer.frame = CGRectMake(0, 0,
                                   self.imageContents.size.width/SCALE_FACTOR,
                                   self.imageContents.size.height/SCALE_FACTOR);
self.imageLayer.contents = (__bridge id)self.imageContents.CGImage;
[self.view.layer addSublayer:self.imageLayer];
self.maskLayer.frame = self.imageLayer.bounds; // mask is based on imageLayer
self.maskLayer.backgroundColor = [UIColor blackColor].CGColor;
...
// Look into source code
```


Side Notes:
```objc
@property (nonatomic, assign) CGFloat curr;
[self performSelector:@selector(method：) withObject:nil afterDelay:time];
[NSObject cancelPreviousPerformRequestsWithTarget:self]
[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(method:) object:nil]
```


