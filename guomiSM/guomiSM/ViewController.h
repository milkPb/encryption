//
//  ViewController.h
//  guomiSM
//
//  Created by 彭兵 on 2021/6/9.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


/// 将数据进行MD5摘要算法处理
-(NSString *)stringToMD5:(NSString *)start;
///BASE64 编码
-(NSString *)Base64Encode:(NSString *)start;
///BASE64 解码
-(NSString *)Base64Decode:(NSString *)start;
///SHA224 编码
-(NSString *)SHA224Encode:(NSString *)start;
///SHA256 编码
-(NSString *)SHA256Encode:(NSString *)start;
///SHA384 编码
-(NSString *)SHA384Encode:(NSString *)start;
///SHA512 编码
-(NSString *)SHA512Encode:(NSString *)start;
///AES加密
-(NSString *)AesEncrypt:(NSString *)start;
///AES解密
-(NSString *)AesDecrypt:(NSString *)start;
///DES加密
-(NSString *)DesEncrypt:(NSString *)start;
///DES解密
-(NSString *)DesDecrypt:(NSString *)start;
///3DES加密
-(NSString *)Three_DesEncrypt:(NSString *)start;
///3DES解密
-(NSString *)Three_DesDecrypt:(NSString *)start;
///RSA加密
-(NSString *)RsaEncrypt:(NSString *)start;
///RSA解密
-(NSString *)RsaDecrypt:(NSString *)start;

///国密SM1加密
-(NSString *)SM1Encrypt:(NSString *)start;
///国密SM2加密
-(NSString *)SM2Encrypt:(NSString *)start;
///国密SM3加密
-(NSString *)SM3Encrypt:(NSString *)start;
///国密SM4加密
-(NSString *)SM4ECBEncrypt:(NSString *)start;
///国密SM4加密
-(NSString *)SM4CBCEncrypt:(NSString *)start;

@end

