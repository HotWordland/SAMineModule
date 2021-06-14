//
//  JGAreaManagerPicker.m
//  JGAreaPicker
//
//  Created by 郭军 on 2019/7/3.
//  Copyright © 2019 JG. All rights reserved.
//

#import "JGAreaManagerPicker.h"
#import "JGProvinceManagerModel.h"
#import "Masonry.h"


#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width


@interface JGAreaManagerPicker() <UIPickerViewDelegate,UIPickerViewDataSource>

/** 弹窗 */
@property(nonatomic,retain) UIView *alertView;

@property (strong, nonatomic) UIPickerView *pickerView;


@property (nonatomic,strong) NSArray *provinceArr; // 省
@property (nonatomic,strong) NSArray *countryArr; // 市
@property (nonatomic,strong) NSArray *districtArr; // 区
@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标

@end



@implementation JGAreaManagerPicker




- (NSArray *)provinceArr
{
    if (_provinceArr == nil) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
-(NSArray *)countryArr
{
    if(_countryArr == nil)
    {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}

- (NSArray *)districtArr
{
    if (_districtArr == nil) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}



- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
//        self.frame = [UIScreen mainScreen].bounds;
//        self.backgroundColor = [UIColor colorWithWhite:0.01 alpha:0.4];
        
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _alertView.backgroundColor = [UIColor whiteColor];
        _alertView.clipsToBounds = YES;
        
        self.pickerView.frame = _alertView.bounds;
        
        [self addSubview:_alertView];
        [_alertView addSubview:self.pickerView];
                
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
//        tap.numberOfTouchesRequired = 1;
//        [self addGestureRecognizer:tap];
        
    }
    return self;
}



- (void)tapClick:(UITapGestureRecognizer *)tap {
    
    
    if( CGRectContainsPoint(_alertView.frame, [tap locationInView:self])) {
        
        
        
    }else {
        
           [self CloseBtnClick];
    }
    

    
}


- (void)SureBtnClick {
    
    
    
//    QJAddressManagerPickerModel *provinceModel = self.addressArr[self.index1];
//    QJAddressCityModel *disModel = provinceModel.sub_areas[self.index2];
//    QJAddressAreaModel *areaModel = disModel.sub_areas[self.index3];
//
//    NSString *detailAddress = [NSString stringWithFormat:@"%@-%@-%@",provinceModel.name,disModel.name,areaModel.areaName];
//    NSString *codes = [NSString stringWithFormat:@"%@-%@-%@",provinceModel.code,disModel.code,areaModel.code];
    
    // 此界面显示
    //    self.detailAddress.text = detailAddress;
    // 回调到上一个界面
//    if (self.backInfo) {
//
//        self.backInfo(detailAddress,codes);
//    }
//    [self hideActionSheetView];
}


//- (void)loadAddressData {
//
//    if (![JGCommonTools isNetWorkReachable]) {
//        [QJCustomHUD showError:@"网络连接错误,请检查网络"];
//        return;
//    }
//
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//
//    WEAKSELF;
//    [QJHttpManager HttpRequestDataWithUrlString:@"Base/GetAreaList" Aarameters:parameters httpMthod:GET Success:^(id data, QJHttpResponseState responseState) {
//
//        [weakSelf.addressArr addObjectsFromArray:[QJAddressManagerPickerModel mj_objectArrayWithKeyValuesArray:data]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [weakSelf calculateFirstData];
//            [weakSelf.pickerView reloadAllComponents];
//        });
//    } failure:^(QJHttpResponseState responseState, NSError *error, NSString *message) {
//        // 结束刷新
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [QJCustomHUD showError:message];
//        });
//    }];
//}


- (void)setAddressArr:(NSArray *)addressArr {
    _addressArr = addressArr;
    
    [self calculateFirstData];
    [self.pickerView reloadAllComponents];
    
}


// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    
    for (JGProvinceManagerModel *Model1 in self.addressArr) {
        [firstName addObject:Model1.areaName];
    }
    self.provinceArr = firstName;
    
    
    //拿出市的数组
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    JGProvinceManagerModel *provinceModel = self.addressArr[self.index1];
    for (JGCityManagerModel *Model2 in provinceModel.cities) {
        [cityNameArr addObject:Model2.areaName];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    
    //拿出区的数组
    //  index1对应省的字典         市的数组 index2市的字典   对应市的数组
    // 这里的allValue是取出来的大数组，取第0个就是需要的内容
    NSMutableArray *disArr = [[NSMutableArray alloc] init];
    JGCityManagerModel *disModel = provinceModel.cities[self.index2];
    for (JGAreaManagerModel *Model3 in disModel.counties) {
        [disArr addObject:Model3.areaName];
    }
    
    //组装对应省下面的区
    self.districtArr = disArr;
}



#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
#pragma mark UIPickerViewDelegate Implementation

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 50;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* label = (UILabel*)view;
    if (!label)
    {
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
    }
    
    NSString * title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text=title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            //            [self calculateData];
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            //            [self calculateData];
            [self calculateFirstData];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
    JGProvinceManagerModel *provinceModel = self.addressArr[self.index1];
    JGCityManagerModel *disModel = provinceModel.cities[self.index2];
    JGAreaManagerModel *areaModel = disModel.counties[self.index3];
    NSString *detailAddress = [NSString stringWithFormat:@"%@-%@-%@",provinceModel.areaName,disModel.areaName,areaModel.areaName];
    NSString *codes = [NSString stringWithFormat:@"%@-%@-%@",provinceModel.areaId,disModel.areaId,areaModel.areaId];
    if (self.backInfo) {
        self.backInfo(detailAddress,codes);
    }
}


- (void)configurePickerView:(UIPickerView *)pickerView
{
    pickerView.showsSelectionIndicator = NO;
}






#pragma mark - 弹出
-(void)showActionSheetView {
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

-(void)creatShowAnimation {
    self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, -160);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 关闭按钮点击才回调
- (void)hideActionSheetView {
    
    self.alertView.transform = CGAffineTransformMakeTranslation(0, -160);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alertView.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


- (void)CloseBtnClick {
    
    [self hideActionSheetView];
}


- (void)dealloc {
    NSLog(@"ActionSheet销毁了");
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //清除或改变分割线的颜色等。
    for(UIView *singleLine in self.pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor clearColor];
            [singleLine removeFromSuperview];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
