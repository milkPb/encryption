//
//  RSAManager.h
//  guomiSM
//
//  Created by 彭兵 on 2021/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RSAManager : NSObject

/**
 *  加密方法
 *
 *  @param str    需要加密的字符串
 *  @param pubKey 公钥字符串
 */
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;

/**
 *  解密方法
 *
 *  @param str     需要解密的字符串
 *  @param privKey 私钥字符串
 */
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
@end

NS_ASSUME_NONNULL_END
