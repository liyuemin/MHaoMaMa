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
@property (nonatomic ,strong)NSArray *data;
@property (nonatomic ,strong)NSTimer *timer;
@property (nonatomic ,assign)NSInteger currentIndex;
@end

@implementation ViewController

- (void)viewDidLoad {
    _currentIndex = 0;
    [super viewDidLoad];
    
    
  [[DBQueueManager shareDBQueueManager] createTable:@"MHaoBaBa"];
    
    
    //NSString *where= [NSString stringWithFormat:@"rankingId='14720206251109254959'"];
    
    self.data = [[DBQueueManager shareDBQueueManager] queryFromTable:@"classTable" Where:nil Start:nil Limit:nil Desc:NO OrderBy:nil];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(zhuaquAriti:) userInfo:nil repeats:YES];
    
}
    
- (void)zhuaquAriti:(NSTimer *)timer {
    NSDictionary *dic = [self.data objectAtIndex:_currentIndex];
    
    
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:[dic valueForKey:@"url"]];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    
    //NSData  * data = [NSData dataWithContentsOfFile:htmlString];
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    TFHpple * doc= [[TFHpple alloc] initWithHTMLData:htmlData];
    //*[@id="v-ranking-content"]/div[1]/ul
    //  html/body/div[6]/div[2]/div[1]/div/div[2]
    //*[@id="v-ranking"]/script
    
    NSMutableDictionary *arDic = [[NSMutableDictionary alloc] init];
    [arDic setObject:[dic valueForKey:@"articleid"] forKey:@"articleid"];
    NSMutableString *contentSring = [[NSMutableString alloc] initWithCapacity:10];
    
    NSArray * elements  = [doc searchWithXPathQuery:@"//div"];
    for (TFHppleElement *htmldoc in elements){
        if ([[htmldoc objectForKey:@"class"] isEqualToString:@"detail-title J_floor"]){
            NSArray *titleArray = [htmldoc searchWithXPathQuery:@"//h1"];
            for (TFHppleElement *titleElement in titleArray){
                NSLog(@"titleElement %@",[titleElement text]);
                [arDic setObject:[titleElement text] forKey:@"title"];
            }
        }
        if ([[htmldoc objectForKey:@"class"] isEqualToString:@"detail-summary"]){
            NSArray *summary = [htmldoc searchWithXPathQuery:@"//b"];
            for (TFHppleElement *summaryElement in summary){
                NSLog(@"summaryElement %@",[summaryElement text]);
            }
            NSLog(@"summeryText %@",[htmldoc content]);
            [arDic setObject:@"quoted" forKey:@"quoted"];
        }
        if ([[htmldoc objectForKey:@"class"] isEqualToString:@"mod-title"]){
            NSArray *modTitls = [htmldoc searchWithXPathQuery:@"//a"];
            for (TFHppleElement *modElement in modTitls){
                NSLog(@"-----%@",[modElement text]);
                [contentSring appendString:[NSString stringWithFormat:@"<a>%@<a>",[modElement text]]];
            }
        }
        if ([[htmldoc objectForKey:@"class"] isEqualToString:@"mod-ctn"]){
            NSArray *pArrays = [htmldoc searchWithXPathQuery:@"//p"];
            for (TFHppleElement *pElement in pArrays){
                if (![[pElement text] isEqualToString:@"关注【妈妈网】微信可获取更多精彩母婴资讯及福利：打开微信→添加好友→查找【妈妈网】or【mama_cn】即可。"]){
                    NSLog(@"p  ---- %@",[pElement text]);
                    [contentSring appendString:[NSString stringWithFormat:@"<p>%@<p>",[pElement text]]];
                }
            }
        }
    }
    [arDic setObject:contentSring forKey:@"content"];
    [[DBQueueManager shareDBQueueManager] insertData:arDic toTable:@"ArticleTable"];
    _currentIndex ++;
    NSLog(@"----当前地几个 %ld",_currentIndex);
}


    
    //抓去mama 数据
- (IBAction)surePaData:(id)sender {
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:@"http://www.mama.cn/z/t665/"];
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
    
    [self.superClassField setText:@"3-6"];
    [self.classfField setText:@"0"];
    
     //*[@id="854"]/div[2]/div[2]
    
    //备孕   http://www.mama.cn/z/t674/
//    NSArray *dataArray = @[@{@"id":@"200303",@"count":@"13"},@{@"id":@"200302",@"count":@"21"},@{@"id":@"767",@"count":@"13"},@{@"id":@"200305",@"count":@"6"},@{@"id":@"200304",@"count":@"19"},@{@"id":@"800",@"count":@"7"},@{@"id":@"826",@"count":@"15"},@{@"id":@"1359",@"count":@"2"},@{@"id":@"1357",@"count":@"5"},@{@"id":@"842",@"count":@"10"},@{@"id":@"1418",@"count":@"3"}];
    
    //怀孕   http://www.mama.cn/z/t675/
//    NSArray *dataArray = @[@{@"id":@"854",@"count":@"2"},@{@"id":@"3043",@"count":@"2"},@{@"id":@"3044",@"count":@"2"},@{@"id":@"3045",@"count":@"3"},@{@"id":@"856",@"count":@"6"},@{@"id":@"200307",@"count":@"4"},@{@"id":@"860",@"count":@"15"},@{@"id":@"855",@"count":@"35"},@{@"id":@"200308",@"count":@"14"},@{@"id":@"1179",@"count":@"6"},@{@"id":@"859",@"count":@"1"},@{@"id":@"861",@"count":@"18"},@{@"id":@"857",@"count":@"14"},@{@"id":@"200310",@"count":@"6"},@{@"id":@"200310",@"count":@"6"},@{@"id":@"200306",@"count":@"6"}];
    
    //分娩  http://www.mama.cn/z/t1181/
//    NSArray *dataArray = @[@{@"id":@"3046",@"count":@"2"},@{@"id":@"1190",@"count":@"6"},@{@"id":@"1189",@"count":@"1"},@{@"id":@"1269",@"count":@"6"},@{@"id":@"1268",@"count":@"2"},@{@"id":@"200312",@"count":@"2"}];
    //产后  http://www.mama.cn/z/t1182/
//    NSArray *dataArray = @[@{@"id":@"1194",@"count":@"4"},@{@"id":@"200326",@"count":@"3"},@{@"id":@"1193",@"count":@"6"},@{@"id":@"1204",@"count":@"5"},@{@"id":@"1214",@"count":@"4"},@{@"id":@"3048",@"count":@"3"},@{@"id":@"200325",@"count":@"8"}];
    
    //新生儿 http://www.mama.cn/z/t1183/
//    NSArray *dataArray = @[@{@"id":@"200327",@"count":@"2"},@{@"id":@"1228",@"count":@"15"},@{@"id":@"200328",@"count":@"20"},@{@"id":@"1220",@"count":@"3"},@{@"id":@"1458",@"count":@"3"},@{@"id":@"3051",@"count":@"15"},@{@"id":@"3049",@"count":@"2"}];
    
    //0-1岁  http://www.mama.cn/z/t666/
//    NSArray *dataArray = @[@{@"id":@"667",@"count":@"8"},@{@"id":@"200329",@"count":@"9"},@{@"id":@"824",@"count":@"11"},@{@"id":@"1016",@"count":@"8"},@{@"id":@"1096",@"count":@"18"},@{@"id":@"200330",@"count":@"2"},@{@"id":@"943",@"count":@"5"},@{@"id":@"3052",@"count":@"2"}];
    
    //1-3岁  http://www.mama.cn/z/t1184/
//    NSArray *dataArray = @[@{@"id":@"200331",@"count":@"3"},@{@"id":@"3058",@"count":@"13"},@{@"id":@"3057",@"count":@"4"},@{@"id":@"3063",@"count":@"12"},@{@"id":@"3059",@"count":@"2"},@{@"id":@"1463",@"count":@"1"},@{@"id":@"3062",@"count":@"2"}];
    
    //3-6岁  http://www.mama.cn/z/t665/
    NSArray *dataArray = @[@{@"id":@"200333",@"count":@"5"},@{@"id":@"3066",@"count":@"5"},@{@"id":@"3065",@"count":@"5"},@{@"id":@"3069",@"count":@"17"},@{@"id":@"200332",@"count":@"6"},@{@"id":@"3067",@"count":@"14"},@{@"id":@"1141",@"count":@"2"},@{@"id":@"1075",@"count":@"2"},@{@"id":@"1158",@"count":@"1"}];
    
    for (NSDictionary *dic in dataArray){
     NSString *h4TitleSring = nil;
    NSString *devId = [dic valueForKey:@"id"];
    
    NSArray *h4Elements = [doc searchWithXPathQuery:[NSString stringWithFormat:@"//div[@id='%@']//div[1]//h4",devId]];
    for (TFHppleElement *h4element in h4Elements){
        NSLog(@"%@",[h4element text]);
        h4TitleSring = [h4element text];
    }
    //*[@id="854"]/div[2]/div[1]/h5
        int count = [[dic valueForKey:@"count"] intValue];
    
    for (int i = 0 ; i < count ;i++){
        NSString *xpath = [NSString stringWithFormat:@"//div[@id='%@']//div[2]//div[%d]//h5",devId,i+1];
    
        NSArray *h5Elements = [doc searchWithXPathQuery:xpath];
        for (TFHppleElement *h5element in h5Elements){
            NSArray *AElements = [h5element searchWithXPathQuery:@"//a"];
            for (TFHppleElement *h5e in AElements){
                
                NSLog(@"%@",[h5e text]);
                NSLog(@"%@",[h5e objectForKey:@"href"]);
                NSArray *h5eidsArray = [[h5e objectForKey:@"href"] componentsSeparatedByString:@"/"];
                NSString *h5Id = [h5eidsArray objectAtIndex:h5eidsArray.count - 2];
                
                
                NSMutableDictionary *arDic = [[NSMutableDictionary alloc] init];
                [arDic setObject:h5Id forKey:@"articleid"];
                [arDic setObject:[h5e text] forKey:@"title"];
                [arDic setObject:h4TitleSring forKey:@"firstClass"];
                [arDic setObject:[h5e text] forKey:@"secondClass"];
                [arDic setObject:self.superClassField.text forKey:@"age"];
                [arDic setObject:self.classfField.text forKey:@"month"];
                [arDic setObject:h4TitleSring forKey:@"attribute"];
                [arDic setObject:[h5e objectForKey:@"href"] forKey:@"url"];
                [arDic setObject:@"" forKey:@"des"];
                
                [liArray addObject:arDic];
                
                
                NSArray *elements = [doc searchWithXPathQuery:[NSString stringWithFormat:@"//div[@id='%@']//div[2]//div[%d]//ul",devId,i+1]];
                for (TFHppleElement *lielement in elements){
                    NSArray *lielements = [lielement searchWithXPathQuery:@"//a"];
                    for(TFHppleElement *li in lielements){
                        NSLog(@"%@",[li text]);
                        NSLog(@"%@",[li objectForKey:@"href"]);
                        NSArray *baikeidArray = [[li objectForKey:@"href"] componentsSeparatedByString:@"/"];
                        NSString *baikeid = [baikeidArray objectAtIndex:baikeidArray.count - 2];
                        
                        NSMutableDictionary *arDic = [[NSMutableDictionary alloc] init];
                        [arDic setObject:baikeid forKey:@"articleid"];
                        [arDic setObject:[li text] forKey:@"title"];
                        [arDic setObject:h4TitleSring forKey:@"firstClass"];
                        [arDic setObject:[h5e text] forKey:@"secondClass"];
                        [arDic setObject:self.superClassField.text forKey:@"age"];
                        [arDic setObject:self.classfField.text forKey:@"month"];
                        [arDic setObject:h4TitleSring forKey:@"attribute"];
                        [arDic setObject:[li objectForKey:@"href"] forKey:@"url"];
                        [arDic setObject:@"" forKey:@"des"];
                        
                        [liArray addObject:arDic];
                        
                        
                    }
                }
            }
        }

    }
    }
    NSLog(@"%@",[liArray description]);
    [[DBQueueManager shareDBQueueManager] insertData:liArray toTable:@"classTable"];
    
    
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
