//
//  MCGivingFPViewController.h
//  CommunityThrough
//
//  Created by 邓梦超 on 17/4/26.
//  Copyright © 2017年 邓梦超. All rights reserved.
//

#import "MCRootViewControler.h"

@interface MCGivingFPViewController : MCRootViewControler<UITextFieldDelegate>{

    UIScrollView *zzView;

}
@property(nonatomic,strong)NSDictionary *dataDic;
@property(nonatomic,strong)UITextField *moneyTextField;
@property(nonatomic,assign)NSString *money;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *balance;
@property (nonatomic, assign)NSInteger currenSelect;//当前点击的是哪个
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIView *passWordView;
@property(nonatomic,strong)NSString *passWord;
@property(nonatomic,strong)UITextField *qqTextField;

@end
