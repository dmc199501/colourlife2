//
//  MCScanViewController.m
//  EmployeesEnd
//
//  Created by 邓梦超 on 16/11/10.
//  Copyright © 2016年 邓梦超. All rights reserved.
//

#import "MCScanViewController.h"

@implementation MCScanViewController

-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = rect.origin.y / readerViewBounds.size.height;
    y = 1 - (rect.origin.x + rect.size.width) / readerViewBounds.size.width;
    width = rect.size.height / readerViewBounds.size.height;
    height = rect.size.width / readerViewBounds.size.width;
    
    return CGRectMake(x, y, width, height);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"扫一扫";
    
    //    ZZNavigationItem *rightBarButtonItem = [[ZZNavigationItem alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    //    //    [rightBarButtonItem setImage:[UIImage imageNamed:@"geren_"] forState:UIControlStateNormal];
    //    //    [rightBarButtonItem setImage:[UIImage imageNamed:@"geren_"] forState:UIControlStateHighlighted];
    //    [rightBarButtonItem setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [rightBarButtonItem setTitle:@"开闪光" forState:UIControlStateNormal];
    //    [self.navigationBar_ZZ setRightBarButtonItem:rightBarButtonItem];
    //    [rightBarButtonItem addTarget:self action:@selector(openLight) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    //    readerView = [[ZBarReaderView alloc]initWithImageScanner:nil];
    readerView = [[ZBarReaderView alloc]init];
    [readerView setBackgroundColor:[UIColor blackColor]];
    
    [readerView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    readerView.readerDelegate = self;
    //关闭闪光灯
    readerView.torchMode = 0;
    //    //扫描区域
    //    CGRect scanMaskRect = CGRectMake(readerX, readerY, readerW, readerH) ;
    //扫描区域计算
    //    readerView.scanCrop = CGRectMake(0, 0, readerView.frame.size.width, readerView.frame.size.height);
    readerView.scanCrop = [self getScanCrop:CGRectMake((self.view.frame.size.width - 260) / 2.0, 80+64, 260, 260) readerViewBounds:readerView.bounds];
    //处理模拟器
    if (TARGET_IPHONE_SIMULATOR)
    {
        ZBarCameraSimulator *cameraSimulator
        = [[ZBarCameraSimulator alloc]initWithViewController:self];
        cameraSimulator.readerView = readerView;
    }
    [self.view addSubview:readerView];
    
    
    //透明区域
    
    UIImageView *img_top = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
    [img_top setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]] ;
    [self.view addSubview:img_top] ;
    
    
    UIImageView *img_left = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80+40, (self.view.frame.size.width - 260) / 2.0, 260)];
    [img_left setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]] ;
    [self.view addSubview:img_left] ;
    
    UIImageView *img_right = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - (self.view.frame.size.width - 260) / 2.0, 80+40, (self.view.frame.size.width - 260) / 2.0, 260)];
    [img_right setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]] ;
    [self.view addSubview:img_right] ;
    
    
    UIImageView *img_foot = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80 + 260+40, self.view.frame.size.width, self.view.frame.size.height - 80 - 260)];
    [img_foot setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]] ;
    [self.view addSubview:img_foot];
    
    UIImageView *maskImageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 260) / 2.0, 80+64, 260, 260)];
    [maskImageView setImage:[UIImage imageNamed:@"barcode_box"]];
    [self.view addSubview:maskImageView];
    
    UILabel *lab_top2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 80 + 260+40 , self.view.frame.size.width, 60)];
    [lab_top2 setBackgroundColor:[UIColor clearColor]] ;
    [lab_top2 setTextColor:[UIColor whiteColor]] ;
    lab_top2.textAlignment = NSTextAlignmentCenter;
    [lab_top2 setText:@"将二维码码放入框内自动扫描，\r\n若无法扫描请刷新重试"] ;
    //设置换行
    lab_top2.numberOfLines = 0;
    
    [self.view addSubview:lab_top2];
    
    [readerView start];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)openLight
{
    //关闭闪光灯
    if(readerView.torchMode == 0)
    {
        readerView.torchMode = 1;
        //        [self.navigationBar_ZZ.rightBarButtonItem setTitle:@"关闪光" forState:UIControlStateNormal];
        
    }
    else
    {
        //        readerView.torchMode = 0;
        //        [self.navigationBar_ZZ.rightBarButtonItem setTitle:@"开闪光" forState:UIControlStateNormal];
        
    }
    
}


//获取返回值
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image
{
    NSString *codeRes = nil;
    for (ZBarSymbol *symbol in symbols)
    {
        codeRes = symbol.data ;
        NSLog(@"%@", codeRes);
        break;
    }
    if (codeRes != nil)
        
    {
        
        MCWebViewController *webViewController = [[MCWebViewController alloc]initWithUrl:[NSURL URLWithString:codeRes]  titleString:@"扫一扫"];
        
        [self.navigationController pushViewController:webViewController animated:YES];
        
        
        
        
        
        
    }
    
    
    
}


- (void)startScan;
{
    [readerView start];
    
}
- (void)stopScan;
{
    [readerView stop];
    
}


@end
