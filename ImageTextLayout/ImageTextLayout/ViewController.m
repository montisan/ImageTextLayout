//
//  ViewController.m
//  ImageTextLayout
//
//  Created by Peter on 16/3/1.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "ViewController.h"
#import "PTImageTextHeaderTableView.h"
#import "PTImageTextHelper.h"

#import "PTImageTextCellFactory.h"


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PTImageTextHeaderTableView *contentTable;

@property (nonatomic, strong) NSMutableArray *imageTexts;
@property (nonatomic, strong) NSMutableDictionary *cacheHeights;
@property (nonatomic, strong) UIImage *navigationImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadImageTexts];
    _cacheHeights = [NSMutableDictionary dictionary];
    
    self.contentTable = [[PTImageTextHeaderTableView alloc] initWithFrame:CGRectMake(0, -64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 64) style:UITableViewStylePlain headerHeight:250];
    self.contentTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTable.backgroundColor = [PTImageTextHelper getBackgroundColor];
    self.contentTable.headerImage = [UIImage imageNamed:@"header.jpg"];
    self.contentTable.dataSource = self;
    self.contentTable.delegate = self;
    [self.view addSubview:self.contentTable];
    
    
    self.navigationImage = [self.contentTable generateNavigationBarImage];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

}

- (void)loadImageTexts
{
    _imageTexts = [NSMutableArray array];
    
    // 生成图文内容测试数据
    [PTImageTextHelper addText:@"韩剧的风靡，除了情节浪漫和养眼的男女主角，唯美的取景地也是一大要素。在首尔、江原道、济州岛等地都遍布了韩剧足迹，那么就让蝉君带你跟随oppa足迹游韩国！" userName:nil toArray:_imageTexts];
    [PTImageTextHelper addTitle:@"在首尔，步步邂逅韩剧回忆" toArray:_imageTexts];
    [PTImageTextHelper addText:@"现代与传统并存的首尔，可谓是韩剧拍摄的最集中地。街头巷尾，处处是景，且发达的公共交通方便地串联起每一个景点。真爱粉，就不首尔打卡吧！" userName:nil toArray:_imageTexts];
    [PTImageTextHelper addImage:@"1.jpg" aspectRatio:0.628333 toArray:_imageTexts];
    [PTImageTextHelper addText:@"作为首尔的标志，N首尔塔一直是游客们必去的景点，如今因为都教授和女神的爱情锁而变得更加热门。建议日落前登塔，可以欣赏余晖和美丽夜景，1层的纪念品商店有出售同心锁和独创纪念品。" userName:@"蝉小队" toArray:_imageTexts];
    [PTImageTextHelper addText:@"《来自星星的你》里全智贤也吵着来挂的锁！首尔塔下面一层是免费的，上去则要330000韩币了，上面还有星星里全智贤去的旋转餐厅哦。" userName:@"小菁1993" toArray:_imageTexts];
    [PTImageTextHelper addImage:@"2.jpg" aspectRatio:0.666667 toArray:_imageTexts];
    [PTImageTextHelper addText:@"被誉为首尔的购物天堂，云集各种韩妆店、百货商场及免税店。此外，不少连锁美食店也汇集于此，这一No.1的观光景点也成为韩剧拍摄的热门选择地！" userName:@"蝉小队" toArray:_imageTexts];
    [PTImageTextHelper addText:@"懵智和金叹他哥居然在明洞主街拍的《急诊男女》~~话说还在明洞偶遇过朴信惠和《请回答1994》里的七峰☆_☆！" userName:@"豆汤包" toArray:_imageTexts];
    [PTImageTextHelper addImage:@"3.jpg" aspectRatio:1.333333 toArray:_imageTexts];
    [PTImageTextHelper addText:@"明洞天主教堂是《原来是美男啊》的拍摄地，很有感觉！" userName:@"叫我兰哥" toArray:_imageTexts];
    [PTImageTextHelper addImage:@"4.jpg" aspectRatio:0.67 toArray:_imageTexts];
    [PTImageTextHelper addText:@"景福宫作为朝鲜时代的正宫，规模最大，是韩国极具代表性的皇家宫殿，一年四季美景不同。因此，许多古装韩剧都不约而同的选择在此拍摄。" userName:@"蝉小队 " toArray:_imageTexts];
    [PTImageTextHelper addText:@"景福宫，多少次韩剧的背景~看到好多熟悉的场景。《屋塔房王世子》中，有天和嫔宫玩赏的后花园。勤政殿前，《拥抱太阳的月亮》里李喧王设计擒贼的场景。" userName:@"color老潘" toArray:_imageTexts];
    [PTImageTextHelper addText:@"最后一个王朝的宫殿，几乎所有古代的韩剧都是在这里拍的，看过《仁显王后的男人》，对这里记忆犹新。" userName:@"小菁1993" toArray:_imageTexts];
    
    // 加一条空数据
    [PTImageTextHelper addImage:@"" aspectRatio:0 toArray:_imageTexts];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_imageTexts count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat height = [_cacheHeights[@(indexPath.row)] floatValue];
    
    if (height < 1)
    {
        
        ImageTextType type = [(_imageTexts[indexPath.row])[@"type"] unsignedIntegerValue];
        NSDictionary *info = (_imageTexts[indexPath.row])[@"info"];
        
        if (ImageTextTypeTitle == type)
        {
            height = 50;
        }
        else if (ImageTextTypeText == type)
        {
            height = [PTImageTextHelper heightOfTextCellWithTextInfo:info constraintWidth:_contentTable.frame.size.width - 20];
        }
        else if (ImageTextTypeImage == type)
        {
            height = [PTImageTextHelper heightOfTextCellWithImageInfo:info constraintWidth:_contentTable.frame.size.width - 20];
        }
        
        
        _cacheHeights[@(indexPath.row)] = @(height);
        
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageTextType type = [(_imageTexts[indexPath.row])[@"type"] unsignedIntegerValue];
    NSDictionary *info = (_imageTexts[indexPath.row])[@"info"];

    UITableViewCell<PTImageTextCellProtocol> *cell =  [PTImageTextCellFactory cellWithTableView:tableView type:type];
    
    [cell updateInfo:info];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= (250 - 64*2))
    {
        [self.navigationController.navigationBar setBackgroundImage:self.navigationImage forBarMetrics:UIBarMetricsDefault];
    }
    else
    {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
