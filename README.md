### XZMusic 记录

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




### 需要fix 方法

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
