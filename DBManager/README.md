

1.添加libsqlite3.dylib框架

2.#import "DBManagerAdd.h"

3.//从数据库获取数据
NSArray *list= [[DBManager sharedDBManager] queryFeatureList];



