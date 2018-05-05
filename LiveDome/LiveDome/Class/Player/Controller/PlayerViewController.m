//
//  PlayerViewController.m
//  LiveDome
//
//  Created by zbwx on 2018/5/3.
//  Copyright © 2018年 zbwx. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()
@property (atomic,retain) id<IJKMediaPlayback> player;
@property (nonatomic,weak) UIView * playerView;
@property (atomic,strong) NSURL * url;
@property (nonatomic,assign) NSNumber * number;
@property (nonatomic,assign) CGFloat heartSize;
@property (nonatomic,strong) UIImageView * dimIamge;
@end

@implementation PlayerViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if (![self.player isPlaying]) {
        //准备播放
        [self.player prepareToPlay];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置加载视图
    [self setupLoadingView];
    
    //播放视频
    [self goPlaying];
    
    // 开启通知
    [self installMovieNotificationObservers];
    
    
    //创建按钮
    [self setupBtn];
    
}

#pragma mark ----- <设置加载视图> -----
- (void)setupLoadingView{
    self.dimIamge = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [_dimIamge sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:YBNameImage(@"default_room")];

    
    UIVisualEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView * visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = _dimIamge.bounds;
    [_dimIamge addSubview:visualEffectView];
    [self.view addSubview:_dimIamge];
}

#pragma mark ----- <创建按钮> -----
- (void)setupBtn{
    __weak typeof(self) tempSelf = self;
    //返回
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(10, 64/2-8, 33, 33)];
    [backBtn setNormalImage:YBNameImage(@"goback")];
    [backBtn handlerTouchUpInsideEvent:^(id sender) {
        [tempSelf backAction:sender];
    }];
    [backBtn.layer setShadowColor:[UIColor blackColor].CGColor];
    [backBtn.layer setShadowOffset:CGSizeMake(0, 0)];
    [backBtn.layer setShadowOpacity:0.5];
    [backBtn.layer setShadowRadius:1];
    [self.view addSubview:backBtn];
    
    //暂停
    UIButton * playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setFrame:CGRectMake(SCREEN_WIDTH - 33 - 10, 64 / 2 - 8, 33, 33)];
    [playBtn setNormalImage:YBNameImage(@"suspended")];
    [playBtn setSelectedImage:YBNameImage(@"begin")];
    [playBtn handlerTouchUpInsideEvent:^(id sender) {
        [tempSelf play_btn:sender];
    }];
    [playBtn.layer setShadowColor:[UIColor blackColor].CGColor];
    [playBtn.layer setShadowOffset:CGSizeMake(0, 0)];
    [playBtn.layer setShadowOpacity:0.5];
    [playBtn.layer setShadowRadius:1];
    [self.view addSubview:playBtn];
    
}

/**
 重写父类返回方法

 @param touchButton <#touchButton description#>
 */
- (void)backAction:(UIButton *)touchButton{
    [super backAction:touchButton];
    // 停播
    [self.player shutdown];
    
    [self.navigationController popViewControllerAnimated:true];
}

/**
 暂停开始

 @param sender <#sender description#>
 */
- (void)play_btn:(UIButton *)sender{

    [sender setSelected:!sender.selected];
    if (![self.player isPlaying]) {
        // 播放
        [self.player play];
    }else{
        // 暂停
        [self.player pause];
    }
}

/**
 播放视频
 */
- (void)goPlaying {
    self.url = [NSURL URLWithString:_liveUrl];
    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    
    UIView * playerView = [self.player view];
    UIView * displayView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    self.playerView = displayView;
    [self.view addSubview:self.playerView];
    
    //自动调整宽度和高度
    [playerView setFrame:self.playerView.bounds];
    [playerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    
    [self.playerView insertSubview:playerView atIndex:1];
    
    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
}

#pragma Install Notifiacation
- (void)installMovieNotificationObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:_player];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackFinish:)
                                                 name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(mediaIsPreparedToPlayDidChange:)
                                                 name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                               object:_player];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                               object:_player];
}

- (void)removeMovieNotificationObservers {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                  object:_player];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:_player];
    
}
#pragma Selector func

- (void)loadStateDidChange:(NSNotification*)notification {
    IJKMPMovieLoadState loadState = _player.loadState;
    
    if ((loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        NSLog(@"LoadStateDidChange: IJKMovieLoadStatePlayThroughOK: %d\n",(int)loadState);
    }else if ((loadState & IJKMPMovieLoadStateStalled) != 0) {
        NSLog(@"loadStateDidChange: IJKMPMovieLoadStateStalled: %d\n", (int)loadState);
    } else {
        NSLog(@"loadStateDidChange: ???: %d\n", (int)loadState);
    }
}

- (void)moviePlayBackFinish:(NSNotification*)notification {
    int reason =[[[notification userInfo] valueForKey:IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
    switch (reason) {
        case IJKMPMovieFinishReasonPlaybackEnded:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackEnded: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonUserExited:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonUserExited: %d\n", reason);
            break;
            
        case IJKMPMovieFinishReasonPlaybackError:
            NSLog(@"playbackStateDidChange: IJKMPMovieFinishReasonPlaybackError: %d\n", reason);
            break;
            
        default:
            NSLog(@"playbackPlayBackDidFinish: ???: %d\n", reason);
            break;
    }
}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification {
    NSLog(@"mediaIsPrepareToPlayDidChange\n");
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification {
    
    _dimIamge.hidden = YES;
    
    switch (_player.playbackState) {
            
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: stoped", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: playing", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: paused", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: interrupted", (int)_player.playbackState);
            break;
            
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: seeking", (int)_player.playbackState);
            break;
        }
            
        default: {
            NSLog(@"IJKMPMoviePlayBackStateDidChange %d: unknown", (int)_player.playbackState);
            break;
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self.player shutdown];
    NSLog(@"dealloc %s",__FUNCTION__);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
