//
//  BgMusic.m
//  PURE HILL
//
//  Created by Alex on 13-1-28.
//
//

#import "BgMusic.h"

@implementation BgMusic
@synthesize bgPlayer;
@synthesize musicFileName=_musicFileName;
+(BgMusic*)sharedBgMusic{
	static BgMusic* sharedBgMusic;
	@synchronized(sharedBgMusic) //sharedSQL只能单多线程访问
	{
		if (!sharedBgMusic) 
		{
			sharedBgMusic=[[BgMusic alloc] init];
		}
	}
	return sharedBgMusic;
}

- (id)init{
    self=[super init];
    if (self) {
        self.musicFileName=@"bg.mp3";//设置默认背景音乐
    }
    return self;
}

-(void)setMusicFileName:(NSString *)musicFileName{
    _musicFileName=musicFileName;
    [self createPlayer];//初始化播放器
}

//根据musicFileName初始化新的bgPlayer
-(void)createPlayer{
    if ([bgPlayer isPlaying]) {
        [bgPlayer stop];
        self.bgPlayer=nil;
    }
    
    NSString *musicFilePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:_musicFileName];//背景音乐在设备上的路径
    //NSString *musicFilePath = [[NSBundle mainBundle] pathForResource:@"bg" ofType:@"mp3"];       //创建音乐文件路径
    NSURL *musicURL = [[NSURL alloc] initFileURLWithPath:musicFilePath];
    AVAudioPlayer *thePlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    self.bgPlayer = thePlayer;    //赋值给自己定义的类变量
    //[musicURL release];
    //[thePlayer release];
    [bgPlayer prepareToPlay];
    [bgPlayer setVolume:1];   //设置音量大小
    bgPlayer.numberOfLoops = -1;//设置音乐播放次数  -1为一直循环
}


#pragma mark custom
-(void)play{
    [bgPlayer play];
}

-(void)pause{
    [bgPlayer pause]; 
}

-(void)stop{
    [bgPlayer stop];
}

#pragma mark 类方法
+(void)play{
    [[BgMusic sharedBgMusic] play];
}

+(void)pause{
    [[BgMusic sharedBgMusic] pause];
}

+(void)stop{
    [[BgMusic sharedBgMusic] stop];
}


@end
