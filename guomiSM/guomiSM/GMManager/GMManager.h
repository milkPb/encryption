//
//  GMManager.h
//  guomiSM
//
//  Created by 彭兵 on 2021/6/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMManager : NSObject


/// SM2 加密
/// @param startStr 入参
-(NSString *)SM2Encrypt:(NSString *)startStr;

/// SM3 摘要算法
/// @param startStr 入参
-(NSString *)SM3Hex:(NSString *)startStr;


/// SM4 加密
/// @param startStr 入参
-(NSString *)SM4Encrypt:(NSString *)startStr;




@end

NS_ASSUME_NONNULL_END
