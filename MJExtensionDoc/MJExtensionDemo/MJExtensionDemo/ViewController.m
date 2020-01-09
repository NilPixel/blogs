//
//  ViewController.m
//  MJExtensionDemo
//
//  Created by Mime97 on 2016/12/7.
//  Copyright © 2016年 Mime. All rights reserved.
//

#import "ViewController.h"
#import "MJExtension.h"
#import "User.h"
#import "Bill.h"
#import "ADResults.h"
#import "Student.h"

typedef NS_ENUM(NSInteger, Sexs) {
    Sexs_Female,
    Sexs_Male,
    Sexs_Unknown
};

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    /**
     *The most simple JSON -> Model【最简单的字典转模型】
     */
    NSDictionary *dic = @{@"name":@"jack",
                          @"age":@20,
                          @"height":@185,
                          @"sex":@(Sexs_Male)};
    User *user = [User mj_objectWithKeyValues:dic];
    NSLog(@"【最简单的字典转模型】user.name = %@ user.age = %ld user.height = %ld user.sex = %ld",user.name,user.age,user.height,user.sex);
    
    /**
     *JSONString -> Model【JSON字符串转模型】
     */
    NSString *jsonStr = @"{\"name\":\"LUCY\", \"age\":25, \"height\":175, \"sex\":2}";
    user = [User mj_objectWithKeyValues:jsonStr];
    NSLog(@"【JSON字符串转模型】user.name = %@ user.age = %ld user.height = %ld user.sex = %ld",user.name,user.age,user.height,user.sex);
    
    /**
     *Model contains model【模型中嵌套模型】
     */
    NSDictionary *modelContainsModelDic = @{@"content":@"超市酒水类消费账单",
                          @"user":@{@"name":@"Tom",
                                    @"age":@23,
                                    @"height":@178,
                                    @"sex":@1},
                          @"bill":@{@"content":@"超市海鲜类消费账单",
                                    @"user":@{@"name":@"Jerry",
                                              @"age":@28,
                                              @"height":@175,
                                              @"sex":@1}}
                          };
    Bill *bill = [Bill mj_objectWithKeyValues:modelContainsModelDic];
    NSLog(@"【模型中嵌套模型】bill.content = %@, bill.user.name = %@, bill.bill.content = %@, bill.bill.user.name = %@",bill.content, bill.user.name,bill.bill.content, bill.bill.user.name);
    
    /**
     *Model contains model-array【模型中有个数组属性，数组里面又要装着其他模型】
     */
    [ADResults mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"bills":@"Bill",
                 @"adPics":@"ADPicture"};
    }];
    NSDictionary *ModelContainsModelArrayDic = @{
                                                 @"bills":@[
                                                         @{@"content":@"超市海鲜类消费账单1",
                                                           @"user":@{@"name":@"Jerry1",
                                                                     @"age":@28,
                                                                     @"height":@175,
                                                                     @"sex":@1}},
                                                         @{@"content":@"超市海鲜类消费账单2",
                                                           @"user":@{@"name":@"Jerry2",
                                                                     @"age":@28,
                                                                     @"height":@175,
                                                                     @"sex":@1}},
                                                         @{@"content":@"超市海鲜类消费账单3",
                                                           @"user":@{@"name":@"Jerry3",
                                                                     @"age":@28,
                                                                     @"height":@175,
                                                                     @"sex":@1}},
                                                         @{@"content":@"超市海鲜类消费账单4",
                                                           @"user":@{@"name":@"Jerry4",
                                                                     @"age":@28,
                                                                     @"height":@175,
                                                                     @"sex":@1}}
                                                         ],
                                                 @"adPics":@[
                                                         @{@"image":@"icon1.png",
                                                           @"url":@"www.1234.com"},
                                                         @{@"image":@"icon2.png",
                                                           @"url":@"www.1234.com"},
                                                         @{@"image":@"icon3.png",
                                                           @"url":@"www.1234.com"},
                                                         @{@"image":@"icon4.png",
                                                           @"url":@"www.1234.com"},
                                                         @{@"image":@"icon5.png",
                                                           @"url":@"www.1234.com"}
                                                         ],
                                                 @"totalNumber":@125
                                                 };
    ADResults *results = [ADResults mj_objectWithKeyValues:ModelContainsModelArrayDic];
    NSLog(@"【模型中有个数组属性，数组里面又要装着其他模型】results.bills[0].content = %@, results.adPics[0].url = %@, results.totalNumber = %@",[results.bills[0] content],[results.adPics[0] url],results.totalNumber);
    
    /**
     *Model name - JSON key mapping【模型中的属性名和字典中的key不相同(或者需要多级映射)】
     */
    [Student mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID":@"id",
                 @"desc":@"description",
                 @"oldName":@"name.oldName",
                 @"nowName":@"name.nowName",
                 @"phone":@"other.phone",
                 @"nameChangedTime":@"name.info[1].nameChangedTime"
                 };
    }];
    NSDictionary *ModelNameJSONKeyMappingDic = @{@"id":@"20",
                                                 @"description":@"khkjdahkaskda",
                                                 @"name":@{
                                                         @"nowName":@"tom",
                                                         @"oldName":@"jerry",
                                                         @"info":@[@"test",
                                                                   @{
                                                                      @"nameChangedTime":@"2015-09-09"
                                                                    }
                                                                   ]
                                                         },
                                                 @"other":@{
                                                         @"phone":@{
                                                                 @"name":@"iphone",
                                                                 @"price":@1234
                                                                 }
                                                         }
                                                 };
    Student *stu = [Student mj_objectWithKeyValues:ModelNameJSONKeyMappingDic];
    NSLog(@"【模型中的属性名和字典中的key不相同(或者需要多级映射)】stu.ID = %@, stu.desc = %@, stu.oldName = %@, stu.nowName = %@, stu.phone.name = %@,stu.nameChangedTime = %@",stu.ID,stu.desc,stu.oldName,stu.nowName,stu.phone.name ,stu.nameChangedTime);
    
    /**
     *JSON array -> model array【将一个字典数组转成模型数组】
     */
    NSArray *dicArray = @[
                          @{
                            @"name":@"iphone4",
                            @"price":@1234
                              },
                          @{
                              @"name":@"iphone4s",
                              @"price":@12345
                              },
                          @{
                              @"name":@"iphone5",
                              @"price":@12346
                              },
                          @{
                              @"name":@"iphone5s",
                              @"price":@12347
                              },
                          @{
                              @"name":@"iphone6",
                              @"price":@12348
                              }
                          ];
    NSArray *phoneArray = [Phone mj_objectArrayWithKeyValuesArray:dicArray];
    for (Phone *phone in phoneArray) {
        NSLog(@"【将一个字典数组转成模型数组】phone.name = %@, phone.price = %lf",phone.name,phone.price);
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
