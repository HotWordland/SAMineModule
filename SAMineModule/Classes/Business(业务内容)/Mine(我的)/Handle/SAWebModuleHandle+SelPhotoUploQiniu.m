//
//  SAWebModuleHandle+SelPhotoUploQiniu.m
//  SA
//
//  Created by Ryzen on 2021/6/8.
//

#import "SAWebModuleHandle+SelPhotoUploQiniu.h"
#import "TZImagePickerController.h"
#import "BYNetWorking+Qiniu.h"
#import "QiniuSDK.h"
@interface SAWebModuleHandle ()
//七牛上传的token
@property (nonatomic, copy, readwrite) NSString *qiniutoken;
@end
/**
  设置当前七牛上传的token key
 */
const char qiniutokenKey;
@implementation SAWebModuleHandle (SelPhotoUploQiniu)
//set
-(void)setQiniutoken:(NSNumber *)curInSegmentIndex{
    objc_setAssociatedObject(self, &qiniutokenKey, curInSegmentIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//get
- (NSString *)qiniutoken{
    return objc_getAssociatedObject(self, &qiniutokenKey);
}

/** 准备工作 */
-(void)getQiniuToken:(void(^)(id data))success
                fail:(void(^)(NSError *error, NSUInteger flag, id data))fail
{
    [BYNetWorking uptoken:@{} success:^(id data) {
        self.qiniutoken = data;
        success(data);
    } failed:^(NSError *error, NSUInteger flag, id data) {
        fail(error,flag,data);
    }];
}
/**
 处理
 @param params 参数
 */
-(void)handleSelPhotoUploQiniu:(id)params
{
    DLog(@"%@",params);
    if (!self.qiniutoken){
        [self getQiniuToken:^(id data) {
            [self uploadQiniu:params];
        } fail:^(NSError *error, NSUInteger flag, id data) {
            TOAST_WINDOW(@"获取七牛token失败");
        }];
        return;
    }
    [self uploadQiniu:params];
}
-(void)uploadQiniu:(id)params
{
    NSString *thid = [self getCallbackid:params];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        UIImage *originalImage = photos.firstObject;
        //            @strongify(self);
        CGFloat fixelW = CGImageGetWidth(originalImage.CGImage);
        CGFloat fixelH = CGImageGetHeight(originalImage.CGImage);
        CGFloat radios = (fixelH * 1.0) / (fixelW * 1.0);
        CGFloat resultImgWidth  = YYScreenSize().width * 0.33;
        CGFloat resultImgHeight = resultImgWidth * radios;
        UIImage *image = [originalImage imageByResizeToSize:CGSizeMake(resultImgWidth, resultImgHeight) contentMode:UIViewContentModeScaleAspectFill];
        //            self.avatarSelectImg = image;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
        NSString *imageDatab64str = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        QNUploadManager *upManager = [[QNUploadManager alloc] init];
        [upManager putData:imageData key:nil token:self.qiniutoken
        complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            NSLog(@"%@", info);
            NSLog(@"%@", resp);
            NSString *nkey = resp[@"key"];
            [self sendMessage:thid params:@{@"img":imageDatab64str,@"key":nkey}];
        } option:nil];
    }];
    [self.controller presentViewController:imagePickerVc animated:YES completion:nil];

}

@end
