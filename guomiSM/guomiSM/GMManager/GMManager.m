//
//  GMManager.m
//  guomiSM
//
//  Created by 彭兵 on 2021/6/11.
//

#import "GMManager.h"
#import <openssl/sm2.h>
#import <openssl/sm3.h>
#import <openssl/sm4.h>
#import "GMUtils.h"

@implementation GMManager


-(NSString *)SM3Hex:(NSString *)startStr
{
    if (!startStr || startStr.length == 0) {
        return nil;
    }
    NSData *strData = [startStr dataUsingEncoding:NSUTF8StringEncoding];
    // 原文
    uint8_t *pData = (uint8_t *)strData.bytes;
    // 摘要结果
    SM3_CTX ctx;
    unsigned char output[SM3_DIGEST_LENGTH];
    memset(output, 0, SM3_DIGEST_LENGTH);
    do {
        if (!sm3_init(&ctx)) {
            break;
        }
        size_t pDataLen = strData.length;
        if (!sm3_update(&ctx, pData, pDataLen)) {
            break;
        }
        if (!sm3_final(output, &ctx)) {
            break;
        }
        memset(&ctx, 0, sizeof(SM3_CTX));
    } while (NO);
    // 转为 16 进制
    NSMutableString *digestStr = [NSMutableString stringWithCapacity:SM3_DIGEST_LENGTH];
    for (NSInteger i = 0; i < SM3_DIGEST_LENGTH; i++) {
        NSString *subStr = [NSString stringWithFormat:@"%X",output[i]&0xff];
        if (subStr.length == 1) {
            [digestStr appendFormat:@"0%@", subStr];
        }else{
            [digestStr appendString:subStr];
        }
    }
    return digestStr;
    
}


-(NSString *)SM4Encrypt:(NSString *)startStr
{
    
    
    return  @"666666";
    
}


///MARK: - ECB 加密

+ (nullable NSData *)ecbEncryptData:(NSData *)plainData key:(NSString *)key{
    if (plainData.length == 0 || key.length != SM4_BLOCK_SIZE * 2) {
        return nil;
    }
    
    uint8_t *plain_obj = (uint8_t *)plainData.bytes;
    size_t plain_obj_len = plainData.length;
    
    // 计算填充长度
    int pad_en = SM4_BLOCK_SIZE - plain_obj_len % SM4_BLOCK_SIZE;
    size_t result_len = plain_obj_len + pad_en;
    // 填充
    uint8_t p_text[result_len];
    memcpy(p_text, plain_obj, plain_obj_len);
    for (int i = 0; i < pad_en; i++) {
        p_text[plain_obj_len + i] = pad_en;
    }
    
    uint8_t *result = (uint8_t *)OPENSSL_zalloc((int)(result_len + 1));
    int group_num = (int)(result_len / SM4_BLOCK_SIZE);
    // 密钥 key Hex 转 uint8_t
    NSData *kData = [GMUtils hexToData:key];
    uint8_t *k_text = (uint8_t *)kData.bytes;
    SM4_KEY sm4Key;
    SM4_set_key(k_text, &sm4Key);
    // 循环加密
    for (NSInteger i = 0; i < group_num; i++) {
        uint8_t block[SM4_BLOCK_SIZE];
        memcpy(block, p_text + i * SM4_BLOCK_SIZE, SM4_BLOCK_SIZE);
        
        SM4_encrypt(block, block, &sm4Key);
        memcpy(result + i * SM4_BLOCK_SIZE, block, SM4_BLOCK_SIZE);
    }
    
    NSData *cipherData = [NSData dataWithBytes:result length:result_len];
    
    OPENSSL_free(result);
    
    return cipherData;
}


@end
