//
//  ViewController.m
//  MHaoBaBa
//
//  Created by yuemin li on 2016/12/15.
//  Copyright © 2016年 yuemin li. All rights reserved.
//

#import "ViewController.h"
#import "OCGumbo+Query.h"
#import "OCGumbo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;
    NSURL *xcfURL = [NSURL URLWithString:@"http://www.guiderank.org/ranking/14606859879904513908"];
    NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
    OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:htmlString];
    NSLog(@"%@",document.Query(@"#v-ranking"));
    NSLog(@"%@",document.title);
    NSLog(@"%@",document.publicID);
    NSLog(@"%@",document.systemID);
    NSLog(@"%@",document.rootElement);
    NSLog(@"%@",document.head);
    NSLog(@"%@",document.body);
    NSLog(@"%@",document.nodeName);
    NSLog(@"%@",document.nodeValue);
    NSLog(@"%@",document.childNodes);
    NSLog(@"%@",document.parentNode);
          
    NSLog(@"%@",document.childNodes);
    OCQueryObject *element = document.Query(@"body").find(@".ranking-banner").find(@".container");
    NSLog(@"%@",element);
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
