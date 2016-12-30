//
//  ViewController.m
//  MHaoBaBa
//
//  Created by yuemin li on 2016/12/15.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "ViewController.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "DBQueueManager.h"

@interface ViewController ()

@property (nonatomic ,weak)IBOutlet UITextField *field;
@property (nonatomic ,weak)IBOutlet UITextField *classfField;
@property (nonatomic ,weak)IBOutlet UITextField *superClassField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  [[DBQueueManager shareDBQueueManager] createTable:@"MHaoBaBa"];
    
    
//    NSString *where= [NSString stringWithFormat:@"rankingId='14720206251109254959'"];
//    NSMutableArray *brands = [[DBQueueManager shareDBQueueManager] queryFromTable:@"BrandTable" Where:nil Start:nil Limit:nil Desc:NO OrderBy:nil];
//
//    
//    NSMutableArray *tags = [[DBQueueManager shareDBQueueManager] queryFromTable:@"rankingTagsTabel" Where:nil Start:nil Limit:nil Desc:NO OrderBy:nil];
//    
//    NSMutableArray *skuid = [[DBQueueManager shareDBQueueManager] queryFromTable:@"SKUTable" Where:nil Start:nil Limit:nil Desc:NO OrderBy:nil];
//    
//    
//    
//    NSLog(@" %@",tags);
//    NSLog(@" %@" ,brands);
//    NSLog(@" %@" ,skuid);
    
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:@"http://www.guiderank.org/ranking/14606859879904513908"];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    
    //NSData  * data = [NSData dataWithContentsOfFile:htmlString];
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple * doc= [[TFHpple alloc] initWithHTMLData:htmlData];
    
    //*[@id="v-ranking-content"]/div[1]/ul
    
    //*[@id="v-ranking"]/script
    //NSArray * elements  = [doc searchWithXPathQuery:@"//div[@id='v-ranking-content']//div[1]//ul"];
    
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@id='v-ranking']//script"];
//
//    //NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@id='news']//div//div[2]//h3//a[1]"];
//    
//    for(TFHppleElement * element in elements){
////        NSLog(@"%@",[element text]);
////        NSLog(@"%@",[element tagName]);
////        NSLog(@"%@",[element attributes]);
////        NSLog(@"%@",[element children]);
////        NSLog(@"%@",[element content]);
////        
////        NSLog(@"%@",[element attributes]);
////        
//        
//        NSString *replacSring = [[element content] stringByReplacingOccurrencesOfString:@"var __globals = " withString:@""];
//        
//       // NSString *jsonString = [NSString stringWithFormat:@"\"globals\":%@",replacSring];
//        if (replacSring == nil) {
//            
//        }
//        
//        NSData *jsonData = [replacSring dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *err;
//        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                            options:NSJSONReadingMutableContainers
//                                                              error:&err];
//        
//        
//         NSDictionary *oneDic = [array objectAtIndex:0];
//        
//        NSMutableArray *tagsArray = [[NSMutableArray alloc] init];
//        NSMutableArray *brandArray = [[NSMutableArray alloc] init];
//        
//        NSArray *rankingTags = [oneDic valueForKey:@"rankingTags"];
//        
//        for (NSDictionary *onebrandTags in rankingTags){
//            NSMutableDictionary *branTagsDic = [[NSMutableDictionary alloc] init];
//            [branTagsDic setObject:[oneDic valueForKey:@"rankingId"] forKey:@"rankingId"];
//            [branTagsDic setObject:[onebrandTags valueForKey:@"desc"] forKey:@"desc"];
//            [branTagsDic setObject:[onebrandTags valueForKey:@"name"] forKey:@"name"];
//            [branTagsDic setObject:[onebrandTags valueForKey:@"seq"] forKey:@"seq"];
//            [branTagsDic setObject:[onebrandTags valueForKey:@"tagScore"] forKey:@"tagScore"];
//            [tagsArray addObject:branTagsDic];
//        }
//        [[DBQueueManager shareDBQueueManager] insertData:tagsArray toTable:@"rankingTagsTabel"];
//        
//        for (NSDictionary *dic in array){
//            NSDictionary *brand = [dic valueForKey:@"brand"];
//           NSMutableDictionary *brandDic = [[NSMutableDictionary alloc] init];
//            [brandDic setValue:[dic valueForKey:@"rankingId"] forKey:@"rankingId"];
//            [brandDic setValue:[brand valueForKey:@"brandId"] forKey:@"brandId"];
//            [brandDic setValue:[brand valueForKey:@"country"] forKey:@"country"];
//            [brandDic setValue:[brand valueForKey:@"createTime"] forKey:@"createTime"];
//            [brandDic setValue:[brand valueForKey:@"enLetter"] forKey:@"enLetter"];
//            [brandDic setValue:[brand valueForKey:@"followedCount"] forKey:@"followedCount"];
//            [brandDic setValue:[brand valueForKey:@"hot"] forKey:@"hot"];
//            [brandDic setValue:[brand valueForKey:@"logo"] forKey:@"logo"];
//            [brandDic setValue:[brand valueForKey:@"logoGray"] forKey:@"logoGray"];
//            [brandDic setValue:[brand valueForKey:@"logoPure"] forKey:@"logoPure"];
//            [brandDic setValue:[brand valueForKey:@"name"] forKey:@"name"];
//            [brandDic setValue:[brand valueForKey:@"photoUrl"] forKey:@"photoUrl"];
//            [brandDic setValue:[brand valueForKey:@"province"] forKey:@"province"];
//            [brandDic setValue:[brand valueForKey:@"pyLetter"] forKey:@"pyLetter"];
//            [brandDic setValue:[brand valueForKey:@"rankingCount"] forKey:@"rankingCount"];
//            [brandDic setValue:[brand valueForKey:@"summary"] forKey:@"summary"];
//            [brandDic setValue:[brand valueForKey:@"top"] forKey:@"top"];
//            [brandDic setValue:[brand valueForKey:@"updateTime"] forKey:@"updateTime"];
//            [brandDic setValue:[dic valueForKey:@"comment"] forKey:@"comment"];
//            [brandArray addObject:brandDic];
//            
//        }
//        [[DBQueueManager shareDBQueueManager] insertData:brandArray toTable:@"BrandTable"];
//        if(err)
//        {
//            NSLog(@"json解析失败：%@",err);
//            
//        }
//        
//        
//        
////        for (TFHppleElement *childrenElement in element.children){
////            NSLog(@"%@",[childrenElement text]);
////            NSLog(@"%@",[childrenElement tagName]);
////            NSLog(@"%@",[childrenElement attributes]);
////            NSLog(@"%@",[element content]);
////            
////        }
//        //        [element text];                       // The text inside the HTML element (the content of the first text node)
//        //        [element tagName];                    // "a"
//        //        [element attributes];                 // NSDictionary of href, class, id, etc.
//        //        [element objectForKey:@"href"];       // Easy access to single attribute
//        //        [element firstChildWithTagName:@"b"];
//    } // The first "b" child node
    
}


    
    //抓去guide 数据
- (IBAction)surePaData:(id)sender {
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:@"http://www.mama.cn/z/t675/"];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    
    //NSData  * data = [NSData dataWithContentsOfFile:htmlString];
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple * doc= [[TFHpple alloc] initWithHTMLData:htmlData];
    
    //*[@id="v-ranking-content"]/div[1]/ul
    
    //*[@id="v-ranking"]/script
    
    //NSArray * elements  = [doc searchWithXPathQuery:@"//div[@id='v-ranking-content']//div[1]//ul"];
   //*[@id="854"]  //*[@id="854"]/div[1]/h4
    
    //*[@id="854"]/div[2]/div[1]/ul
    
    
    NSMutableArray *liArray = [[NSMutableArray alloc] init];
    
    
    NSArray *h4Elements = [doc searchWithXPathQuery:@"//div[@id='854']//div[1]//h4"];
    for (TFHppleElement *h4element in h4Elements){
        NSLog(@"%@",[h4element text]);
    }
    //*[@id="854"]/div[2]/div[1]/h5
    NSArray *h5Elements = [doc searchWithXPathQuery:@"//div[@id='854']//div[2]//div[1]//h5"];
    NSString *h5Id = nil;
    for (TFHppleElement *h5element in h5Elements){
         NSArray *AElements = [h5element searchWithXPathQuery:@"//a"];
        for (TFHppleElement *h5e in AElements){
            NSLog(@"%@",[h5e text]);
            NSLog(@"%@",[h5e objectForKey:@"href"]);
            h5Id = [[[h5e objectForKey:@"href"] componentsSeparatedByString:@"/"] lastObject];
            
         [liArray addObject:@{@"title":[h5e text],@"url":[h5e objectForKey:@"href"],@"baikeid":h5Id,@"superid":h5Id}];
        }
    }
    
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@id='854']//div[2]//div[1]//ul"];
    for (TFHppleElement *lielement in elements){
        NSArray *lielements = [lielement searchWithXPathQuery:@"//a"];
        for(TFHppleElement *li in lielements){
            NSLog(@"%@",[li text]);
            NSLog(@"%@",[li objectForKey:@"href"]);
            NSString *baikeid = [[[li objectForKey:@"href"] componentsSeparatedByString:@"/"] lastObject];
            [liArray addObject:@{@"title":[li text],@"url":[li objectForKey:@"href"],@"baikeid":baikeid,@"superid":h5Id}];
        }
    }
    

    
    
}
    
    
//抓去guide 数据
    
- (void)zhuaquguid{
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.guiderank.org/ranking/%@",self.field.text]];
    
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple * doc= [[TFHpple alloc] initWithHTMLData:htmlData];
    // /html/head/title
    
    
    NSArray *elements = [doc searchWithXPathQuery:@"//div[@id='v-ranking']//script"];
    
    
    
    
    for(TFHppleElement * element in elements){
        //        NSLog(@"%@",[element text]);
        //        NSLog(@"%@",[element tagName]);
        //        NSLog(@"%@",[element attributes]);
        //        NSLog(@"%@",[element children]);
        //        NSLog(@"%@",[element content]);
        //
        //        NSLog(@"%@",[element attributes]);
        //
        
        NSString *replacSring = [[element content] stringByReplacingOccurrencesOfString:@"var __globals = " withString:@""];
        
        // NSString *jsonString = [NSString stringWithFormat:@"\"globals\":%@",replacSring];
        if (replacSring == nil) {
            
        }
        
        NSData *jsonData = [replacSring dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&err];
        
        
        NSDictionary *oneDic = [array objectAtIndex:0];
        
        NSMutableArray *tagsArray = [[NSMutableArray alloc] init];
        NSMutableArray *brandArray = [[NSMutableArray alloc] init];
        
        NSArray *rankingTags = [oneDic valueForKey:@"rankingTags"];
        
        
        
        
        NSArray *titleElements =  [doc searchWithXPathQuery:@"//title"];
        NSString *title = [[titleElements objectAtIndex:0] text];
        NSLog(@"title == %@",title);
        
        [[DBQueueManager shareDBQueueManager] insertData:@{@"skuid":self.field.text,@"rankingId":[oneDic valueForKey:@"rankingId"],@"title":title,@"image":@"",@"onclassful":self.classfField.text,@"twoclassful":self.superClassField.text} toTable:@"SKUTable"];
        
        
        
        
        for (NSDictionary *onebrandTags in rankingTags){
            NSMutableDictionary *branTagsDic = [[NSMutableDictionary alloc] init];
            [branTagsDic setObject:[oneDic valueForKey:@"rankingId"] forKey:@"rankingId"];
            [branTagsDic setObject:[onebrandTags valueForKey:@"desc"] forKey:@"desc"];
            [branTagsDic setObject:[onebrandTags valueForKey:@"name"] forKey:@"name"];
            [branTagsDic setObject:[onebrandTags valueForKey:@"seq"] forKey:@"seq"];
            [branTagsDic setObject:[onebrandTags valueForKey:@"tagScore"] forKey:@"tagScore"];
            [tagsArray addObject:branTagsDic];
        }
        [[DBQueueManager shareDBQueueManager] insertData:tagsArray toTable:@"rankingTagsTabel"];
        
        for (NSDictionary *dic in array){
            NSDictionary *brand = [dic valueForKey:@"brand"];
            NSMutableDictionary *brandDic = [[NSMutableDictionary alloc] init];
            [brandDic setValue:[dic valueForKey:@"rankingId"] forKey:@"rankingId"];
            [brandDic setValue:[brand valueForKey:@"brandId"] forKey:@"brandId"];
            [brandDic setValue:[brand valueForKey:@"country"] forKey:@"country"];
            [brandDic setValue:[brand valueForKey:@"createTime"] forKey:@"createTime"];
            [brandDic setValue:[brand valueForKey:@"enLetter"] forKey:@"enLetter"];
            [brandDic setValue:[brand valueForKey:@"followedCount"] forKey:@"followedCount"];
            [brandDic setValue:[brand valueForKey:@"hot"] forKey:@"hot"];
            [brandDic setValue:[brand valueForKey:@"logo"] forKey:@"logo"];
            [brandDic setValue:[brand valueForKey:@"logoGray"] forKey:@"logoGray"];
            [brandDic setValue:[brand valueForKey:@"logoPure"] forKey:@"logoPure"];
            [brandDic setValue:[brand valueForKey:@"name"] forKey:@"name"];
            [brandDic setValue:[brand valueForKey:@"photoUrl"] forKey:@"photoUrl"];
            [brandDic setValue:[brand valueForKey:@"province"] forKey:@"province"];
            [brandDic setValue:[brand valueForKey:@"pyLetter"] forKey:@"pyLetter"];
            [brandDic setValue:[brand valueForKey:@"rankingCount"] forKey:@"rankingCount"];
            [brandDic setValue:[brand valueForKey:@"summary"] forKey:@"summary"];
            [brandDic setValue:[brand valueForKey:@"top"] forKey:@"top"];
            [brandDic setValue:[brand valueForKey:@"updateTime"] forKey:@"updateTime"];
            [brandDic setValue:[dic valueForKey:@"comment"] forKey:@"comment"];
            [brandArray addObject:brandDic];
            
        }
        [[DBQueueManager shareDBQueueManager] insertData:brandArray toTable:@"BrandTable"];
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
            
        }
        
        
        
        //        for (TFHppleElement *childrenElement in element.children){
        //            NSLog(@"%@",[childrenElement text]);
        //            NSLog(@"%@",[childrenElement tagName]);
        //            NSLog(@"%@",[childrenElement attributes]);
        //            NSLog(@"%@",[element content]);
        //
        //        }
        //        [element text];                       // The text inside the HTML element (the content of the first text node)
        //        [element tagName];                    // "a"
        //        [element attributes];                 // NSDictionary of href, class, id, etc.
        //        [element objectForKey:@"href"];       // Easy access to single attribute
        //        [element firstChildWithTagName:@"b"];
    } // The first "b" child node
    
    
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
