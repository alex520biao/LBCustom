

#import "c_custom_func.h"

#pragma mark Definition
//CANMARRY(gender,age) 根据性别gender和age年龄,判断此人是否满足结婚条件（男性大于22岁，女性大于20岁）
static void db_func_canmarry(sqlite3_context *context, int argc, sqlite3_value **argv){  
    int gender = sqlite3_value_int(argv[0]);  
    int age = sqlite3_value_int(argv[1]);  
    int canmarry = 0;  
    if (gender == 0 && age > 22) {  
        canmarry = 1;  
    }  
    else if (gender == 1 && age > 20){  
        canmarry = 1;  
    }  
    sqlite3_result_int(context, canmarry);  
}

static void db_func_distance(sqlite3_context *context, int argc, sqlite3_value **argv){      
    double lat1= sqlite3_value_double(argv[0]);  
    double lon1= sqlite3_value_double(argv[1]);  
    double lat2= sqlite3_value_double(argv[2]);  
    double lon2= sqlite3_value_double(argv[3]);  
    NSLog(@"lat1:%f,lon1:%f,lat2:%f,lon2:%f",lat1,lon1,lat2,lon2);

    //计算两点距离开
    double dist = get_distance(lat1, lon1, lat2, lon2);

    printf("dst = %0.3fkm\n", dist);  //dst = 9.281km
    sqlite3_result_double(context, dist);  
}


#pragma mark Register 
//自定义函数进行注册
static void custom_func_register(sqlite3* db){  
    //CANMARRY(gender,age)
    sqlite3_create_function(db, "CANMARRY", 2, SQLITE_UTF8, NULL, &db_func_canmarry, NULL, NULL);

    //DISTANCE(lat1,lng1,lat2,lng2)
    sqlite3_create_function(db, "DISTANCE",4, SQLITE_UTF8, NULL, &db_func_distance, NULL, NULL);
}

//NSString *sql =@"SELECT * FROM person WHERE CANMARRY(gender,age)" ;
//NSString *sql =@"SELECT * FROM person WHERE DISTANCE(39.90744,116.41615,39.90744,116.30746) " ;



