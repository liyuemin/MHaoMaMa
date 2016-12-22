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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    //NSArray *elements = [xpathParser searchWithXPathQuery:@"//div[@id='news']//div//div[2]//h3//a[1]"];
    
    for(TFHppleElement * element in elements){
        NSLog(@"%@",[element text]);
        NSLog(@"%@",[element tagName]);
        NSLog(@"%@",[element attributes]);
        NSLog(@"%@",[element children]);
        NSLog(@"%@",[element content]);
        
        NSLog(@"%@",[element attributes]);
        
        
        NSString *replacSring = [[element content] stringByReplacingOccurrencesOfString:@"var __globals = " withString:@""];
        
        NSString *jsonString = [NSString stringWithFormat:@"\"globals\":%@",replacSring];
        if (jsonString == nil) {
            
        }
        
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
            
        }
        NSLog(@" ------ %@",[dic description]);
        
        
        for (TFHppleElement *childrenElement in element.children){
            NSLog(@"%@",[childrenElement text]);
            NSLog(@"%@",[childrenElement tagName]);
            NSLog(@"%@",[childrenElement attributes]);
            NSLog(@"%@",[element content]);
            
        }
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
