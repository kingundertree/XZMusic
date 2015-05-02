###先上效果图
![XZMusic](https://raw.githubusercontent.com/kingundertree/XZMusic/master/XZMusic.gif)

###github地址

https://github.com/kingundertree/XZMusic

###说明
1. 本md主要主要通过XZMusic分析下常见的iOS项目的搭建以及常见模块的设计和划分
2. 本项目的音乐信息取自本地SQL数据，通过FMDB获取
3. 音乐的统计信息采用CoreData实现
4. 歌曲资源和歌词取自网络
5. 播放器采用DOUAudio
6. 采用pod方式管理第三方库


###功能
1. 本地搜索歌曲
2. 歌曲播放和下载、显示歌词
3. 歌曲的基本统计，包括点赞、播放次数等
4. 微博登录
	
###主要模块
1. 网络请求模块XZNetWorking：集成AFNetworking，支持常见的get/post/restfulget/getfulget常见请求
2. 音乐下载模块MusicDownLoad：支持歌曲、歌词下载，包括本地存储处理，已经下载进度及常见信息回调
3. 微博登录libWeiboSDK：配合LoginManager使用
4. UI主结构XZMenu：实现左右结构，滑动显示菜单
5. UITabBar结构XZTabBar
	
###构架设计

	XZMusic
		Data..........................本地化数据处理，包括本地音乐信息及音乐统计停息
			XZMusicDataCenter.........coredata表信息输入输出接口
			LKDBCenter................SQL表信息输入输出接口
			Model.....................本地数据库数据模型
		Libs..........................不支持pod的库
			DOUAudio..................音乐播放，支持在线播放
			XZNetWorking..............网络请求库，集成AFNetworking库
			libWeiboSDK...............微博登录SDK
		Manager.......................APP业务操作管理类
			GlobalManager.............app全局性参数管理，比如当前播放musicId、列表信息，以及下载的实时信息
			MusicDownLoad.............下载功能模块，支持音乐和歌词下载，本地存储处理，已经下载进度及常见信息回调
			RequestManager............网络请求的请求
			LoginManager..............登录操作管理
		Model.........................app常见业务的model
		Resource......................常见资源，包括图片等
		Views.........................视图资源，也就是app最重要的模块
			component.................通用的view类，包括base VC、table、Category、手势控件等
			DownLoad..................下载VC
			Login.....................登录VC
			Loving....................最爱VC
			Search....................搜索VC
			Setting...................设置VC
			ViewController............子页面VC
			XZMenu....................app主view结构
			XZTabBar..................UITabbar自定义结构
		XZAppDelegate.h
		XZAppDelegate.m
		
	Pods..............................支持第三方的类库
	
		platform :ios, "6.0"
		pod 'AFNetworking', '~> 2.0'
		pod 'pop', '~> 1.0'
		pod 'FMDB'
		pod 'LKDBHelper', :head
		pod 'MBProgressHUD', '~> 0.8'
		pod 'MultiFunctionCell', :git => 'https://github.com/kingundertree/MultiFunctionCell'


####时间记录

1. 2014.8.22 周浦万达广场麦当劳，创建项目，实现pod管理和基本配置
2. 2014.8.28 公司，完成左右菜单结构，以及基本TabBar功能
3. 2014.8.29 公司，结构完善，引入手势控件
4. 2014.8.31 临港豪生，实现左侧菜单切换基本功能
5. 2014.9.22 实现微博登录和登录后信息
6. 2014.10.22 逐步实现asyncGetWithServiceID和的同步和异步方法，流程走通，待测试
7. 2014.10.29 调试url参数，service阶段
8. 2013.11.2 调试XZNetWork Get请求成功。api请求告一段落
9. add LKDBHelper，实现歌手列表搜索，需要设计搜索模块
10. add search singerList ViewController
11. add search singerSongs Request
12. 11.13 add DOUAudioPlayer 实现播放歌曲功能
13. 11.22 实现本地音乐、歌词下载，以及本地播放功能
14. 11.23 实现歌词播放，进度同步
15. 12.2 add 播放暂停控制，以及其他ui
16. 12.6 add 子view 下载功能
17. 12.14 add 歌曲播放数据库读写记录操作




### 需要fix 方法

LKDBHelper.m

```
- (instancetype)init
{
    return [self initWithDBName:@"FreeMusic"];
}

+(NSString*)getDBPathWithDBName:(NSString*)dbName
{
    NSString* fileName = nil;
    if([dbName hasSuffix:@".db"] == NO) {
        fileName = [NSString stringWithFormat:@"%@.db",dbName];
    }
    else {
        fileName = dbName;
    }
    
//    NSString* filePath = [LKDBUtils getPathForDocuments:fileName inDir:@"db"];
    NSString* filePath = [LKDBUtils getPathForDocuments:fileName inDir:nil];
    return filePath;
}

```
