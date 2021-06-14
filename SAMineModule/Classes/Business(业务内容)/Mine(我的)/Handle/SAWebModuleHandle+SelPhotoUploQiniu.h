//
//  SAWebModuleHandle+SelPhotoUploQiniu.h
//  SA
//
//  Created by Ryzen on 2021/6/8.
//

#import "SAWebModuleHandle.h"

NS_ASSUME_NONNULL_BEGIN
//选择相册图片上传至七牛云
@interface SAWebModuleHandle (SelPhotoUploQiniu)
//七牛上传的token
@property (copy, nonatomic,readonly) NSString *qiniutoken;
/**
 处理
 @param params 参数
 */
-(void)handleSelPhotoUploQiniu:(id)params;

@end

NS_ASSUME_NONNULL_END
