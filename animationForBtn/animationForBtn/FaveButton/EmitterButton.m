//
//  EmitterButton.m
//  animationForBtn
//
//  Created by ss-iOS-LLY on 16/9/14.
//  Copyright © 2016年 lilianyou. All rights reserved.
//

#import "EmitterButton.h"
#import <QuartzCore/QuartzCore.h>


@interface EmitterButton ()
@property (nonatomic, strong) CAEmitterLayer *chargeLayer;
@property (nonatomic, strong) CAEmitterLayer *explosionLayer;


@end



@implementation EmitterButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name           = @"explosion";
    explosionCell.alphaRange     = 0.10; //一个粒子的颜色alpha能改变的范围
    explosionCell.alphaSpeed     = -1.0; //粒子透明度在生命周期内的改变速度
    explosionCell.lifetime       = 0.7;  //生命周期
    explosionCell.lifetimeRange  = 0.3;  //生命周期范围 lifetime= lifetime(+/-) lifetimeRange
    explosionCell.birthRate      = 0;  //每秒发射的粒子数量
    explosionCell.velocity       = 40.00; //粒子速度
    explosionCell.velocityRange  = 10.00; //速度范围
    explosionCell.scale          = 0.03; //缩放比例
    explosionCell.scaleRange     = 0.02; //缩放比例范围
    explosionCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _explosionLayer              = [CAEmitterLayer layer]; // 粒子发射系统
    _explosionLayer.name         = @"emitterLayer";        // 名称
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;  // 发射源的形状
    _explosionLayer.emitterMode  = kCAEmitterLayerOutline; // 发射模式
    _explosionLayer.emitterSize  = CGSizeMake(10, 0);      // 发射源的大小
    _explosionLayer.emitterCells = @[explosionCell];       //装着CAEmitterCell对象的数组，被用于把粒子投放到layer上
    _explosionLayer.renderMode = kCAEmitterLayerOldestFirst; //渲染模式
    _explosionLayer.masksToBounds = NO;
    _explosionLayer.position      = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    _explosionLayer.zPosition     = -1;	//发射源的z坐标位置
    [self.layer addSublayer:_explosionLayer];
    
    CAEmitterCell *chargeCell = [CAEmitterCell emitterCell];
    chargeCell.name           = @"charge";
    chargeCell.alphaRange     = 0.10;
    chargeCell.alphaSpeed     = -1.0;
    chargeCell.lifetime       = 0.3;
    chargeCell.lifetimeRange  = 0.1;
    chargeCell.birthRate      = 0;
    chargeCell.velocity       = 40.0;
    chargeCell.velocityRange  = 0.00;
    chargeCell.scale          = 0.03;
    chargeCell.scaleRange     = 0.02;
    chargeCell.contents       = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    
    _chargeLayer               = [CAEmitterLayer layer];
    _chargeLayer.name          = @"emitterLayer";
    _chargeLayer.emitterShape  = kCAEmitterLayerCircle;
    _chargeLayer.emitterMode   = kCAEmitterLayerOutline;
    _chargeLayer.emitterSize   = CGSizeMake(20, 0);
    _chargeLayer.emitterCells  = @[chargeCell];
    _chargeLayer.renderMode    = kCAEmitterLayerOldestFirst;
    _chargeLayer.masksToBounds = NO;
    _chargeLayer.position      = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    _chargeLayer.zPosition     = -1;
    [self.layer addSublayer:_chargeLayer];
  
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self animation];
}

/**
 *  开始动画
 */
- (void)animation
{
    // 帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (self.selected) {
        animation.values = @[@1.5,@0.8,@1.0,@1.2,@1.0];
        animation.duration = 0.5;
        // 添加粒子效果
        [self startAnimate];
    } else {
        animation.values = @[@0.8,@1.0];
        animation.duration = 0.4;
    }
    animation.calculationMode = kCAAnimationCubic;//关键帧为座标点的关键帧进行圆滑曲线相连后插值计算，这里的主要目的是使得运行的轨迹变得圆滑
    [self.layer addAnimation:animation forKey:@"transform.scale"];
}


// 粒子效果开始喷射
- (void)startAnimate
{   // chargeLayer开始时间
    self.chargeLayer.beginTime = CACurrentMediaTime();
//    // chargeLayer 每秒喷射80个
    [self.chargeLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
    // 进入下一个动作
    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
}

/**
 *  大量喷射
 */
- (void)explode
{
 //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKey:@"emitterCells.charge.birthRate"];
    //explosionLayer开始时间
    self.explosionLayer.beginTime = CACurrentMediaTime();
    //explosionLayer每秒喷射的2500个
    [self.explosionLayer setValue:@2500 forKeyPath:@"emitterCells.explosion.birthRate"];
   // 停止喷射
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];
}

/**
 *  停止喷射
 */
- (void)stop {
    //让chareLayer每秒喷射的个数为0个
    [self.chargeLayer setValue:@0 forKeyPath:@"emitterCells.charge.birthRate"];
    //explosionLayer每秒喷射的0个
    [self.explosionLayer setValue:@0 forKeyPath:@"emitterCells.explosion.birthRate"];
}

































@end
