//
//  BgMusic.h
//  PURE HILL
//
//  Created by Alex on 13-1-28.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BgMusic : NSObject
@property(nonatomic,strong)AVAudioPlayer *bgPlayer;
@property(nonatomic,strong)NSString *musicFileName;
+(BgMusic*)sharedBgMusic;
-(void)play;
-(void)pause;
-(void)stop;

#pragma mark 类方法封装
+(void)play;
+(void)pause;
+(void)stop;



@end
