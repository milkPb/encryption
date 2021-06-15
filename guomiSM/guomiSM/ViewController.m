//
//  ViewController.m
//  guomiSM
//
//  Created by 彭兵 on 2021/6/9.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "RSAManager.h"
#import "GMManager.h"
#import "GMSm2Utils.h"
#import "GMSm4Utils.h"
#define  EncrityKey @"kw23kw43kw2ae23e"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    NSArray * titleArray;
    NSString * startStr;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    startStr = @"pb123456";
    titleArray = @[@"MD5",@"BASE64编码",@"BASE64解码",@"SHA224",@"SHA256",@"SHA384",@"SHA512",@"AES加密",@"AES解密",@"DES加密",@"DES解密",@"3DES加密",@"3DES解密",@"RSA加密",@"RSA解密",@"国密SM2",@"国密SM3",@"国密SM4ECB",@"国密SM4CBC"];
    
    
    UITableView * table = [[UITableView alloc]initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    [table setTableHeaderView:[self headerView]];
    [self.view addSubview:table];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  titleArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cell_id = @"cell_id";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell_id];
    }
    cell.textLabel.text = titleArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self stringToMD5:startStr]];
    }
  else   if (indexPath.row == 1) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self Base64Encode:startStr]];
    }
  else   if (indexPath.row == 2) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self Base64Decode:[self Base64Encode:startStr]]];
    }
   else   if (indexPath.row == 3) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SHA224Encode:startStr]];
    }
   else   if (indexPath.row == 4) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SHA256Encode:startStr]];
    }
   else   if (indexPath.row == 5) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SHA384Encode:startStr]];
    }
   else   if (indexPath.row == 6)
   {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SHA512Encode:startStr]];
    }
   else   if (indexPath.row == 7)
   {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self AesEncrypt:startStr]];
    }
   else   if (indexPath.row == 8)
   {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self AesDecrypt:[self AesEncrypt:startStr]]];
    }
   else   if (indexPath.row == 9)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self DesEncrypt:startStr]];
     }
   else   if (indexPath.row == 10)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self DesDecrypt:[self DesEncrypt:startStr]]];
       
    }
   else   if (indexPath.row == 11)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self Three_DesEncrypt:startStr]];
     }
   else   if (indexPath.row == 12)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self Three_DesDecrypt:[self Three_DesEncrypt:startStr]]];
       
    }
   else   if (indexPath.row == 13)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self RsaEncrypt:startStr]];
     }
   else   if (indexPath.row == 14)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self RsaDecrypt:startStr]];
       
    }
   else   if (indexPath.row == 15)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SM2Encrypt:startStr]];
       
    }
   else   if (indexPath.row == 16)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SM3Encrypt:startStr]];
     }
   else   if (indexPath.row == 17)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SM4ECBEncrypt:startStr]];
       
    }
   else   if (indexPath.row == 18)
    {
    
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",titleArray[indexPath.row],[self SM4CBCEncrypt:startStr]];
       
    }
    NSLog(@"%@",cell.textLabel.text);
    return  cell;
    
}

///BASE64 编码
-(NSString *)Base64Encode:(NSString *)start
{
    NSData * data = [start dataUsingEncoding:NSUTF8StringEncoding];
    return  [data base64EncodedStringWithOptions:0];
    
}
///BASE64 解码
-(NSString *)Base64Decode:(NSString *)start
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:start options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
}
//MD5
-(NSString *)stringToMD5:(NSString *)start
{
    
    const char *cStr = [start cStringUsingEncoding:NSUTF8StringEncoding];
      unsigned char digest[CC_MD5_DIGEST_LENGTH];
      CC_MD5( cStr, (CC_LONG)start.length, digest );
      NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
      for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
          [result appendFormat:@"%02x", digest[i]];
      return result;

}

///SHA224编码
-(NSString *)SHA224Encode:(NSString *)start
{
    const char * cstr = [start cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:start.length];
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(data.bytes, (int)data.length, digest);
    
    NSMutableString*output=[NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH*2];
    for(int i=0; i < CC_SHA224_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}

///SHA256
-(NSString *)SHA256Encode:(NSString *)start
{
    const char * cstr = [start cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:start.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (int)data.length, digest);
    
    NSMutableString*output=[NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i=0; i < CC_SHA256_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}

///SHA384
-(NSString *)SHA384Encode:(NSString *)start
{
    const char * cstr = [start cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:start.length];
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(data.bytes, (int)data.length, digest);
    
    NSMutableString*output=[NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH*2];
    for(int i=0; i < CC_SHA384_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}

///SHA512
-(NSString *)SHA512Encode:(NSString *)start
{
    const char * cstr = [start cStringUsingEncoding:NSUTF8StringEncoding];
    NSData * data = [NSData dataWithBytes:cstr length:start.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (int)data.length, digest);
    
    NSMutableString*output=[NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH*2];
    for(int i=0; i < CC_SHA512_DIGEST_LENGTH;i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}

///AES256加密
-(NSString *)AesEncrypt:(NSString *)start
{
   
    if (!start) {
         return nil;
     }
     char keyPtr[kCCKeySizeAES256 + 1];
     bzero(keyPtr, sizeof(keyPtr));
     [EncrityKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
      
     NSData *sourceData = [start dataUsingEncoding:NSUTF8StringEncoding];
     NSUInteger dataLength = [sourceData length];
     size_t buffersize = dataLength + kCCBlockSizeAES128;
     void *buffer = malloc(buffersize);
     size_t numBytesEncrypted = 0;
     CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [sourceData bytes], dataLength, buffer, buffersize, &numBytesEncrypted);
      
     if (cryptStatus == kCCSuccess)
     {
         NSData *encryptData = [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
         //对加密后的二进制数据进行base64转码
         return [encryptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
     } else {
         free(buffer);
         return nil;
     }
}

///AES256解密
-(NSString *)AesDecrypt:(NSString *)start
{
    if (!start) {
            return nil;
        }
        //先对加密的字符串进行base64解码
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:start options:NSDataBase64DecodingIgnoreUnknownCharacters];
        char keyPtr[kCCKeySizeAES256 + 1];
        bzero(keyPtr, sizeof(keyPtr));
        [EncrityKey getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
         
        NSUInteger dataLength = [decodeData length];
        size_t bufferSize = dataLength + kCCBlockSizeAES128;
        void *buffer = malloc(bufferSize);
        size_t numBytesDecrypted = 0;
        CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding | kCCOptionECBMode, keyPtr, kCCBlockSizeAES128, NULL, [decodeData bytes], dataLength, buffer, bufferSize, &numBytesDecrypted);
        if (cryptStatus == kCCSuccess) {
            NSData *data = [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
            NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            return result;
        } else {
            free(buffer);
            return nil;
     }
}


///DES加密
-(NSString *)DesEncrypt:(NSString *)start
{
    NSData *data = [start dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
       unsigned char buffer[1024];
       memset(buffer, 0, sizeof(char));
       size_t numBytesEncrypted = 0;
       const Byte iv[] = {1,2,3,4,5,6,7,8};
       CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                             kCCAlgorithmDES,
                                             kCCOptionPKCS7Padding | kCCOptionECBMode,
                                             [EncrityKey UTF8String],
                                             kCCKeySizeDES,
                                             iv,
                                             [data bytes],
                                             [data length],
                                             buffer,
                                             1024,
                                             &numBytesEncrypted);
       
       NSString* plainText = nil;
       if (cryptStatus == kCCSuccess)
       {
           NSData * dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
           ///base64编码
           plainText = [dataTemp base64EncodedStringWithOptions:0];
       }
       else
       {
           
       }
       return plainText;
}


///DES解密
-(NSString *)DesDecrypt:(NSString *)start
{
    //加密后的data转换成64位，解密的时候需要用initWithBase64EncodedString方法转为data
    NSData *data = [[NSData alloc] initWithBase64EncodedString:start options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString*plaintext =nil;
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesDecrypted =0;
    const Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [EncrityKey UTF8String],kCCKeySizeDES,
                                          iv,
                                          [data bytes],
                                          [data length],
                                          buffer,1024,
                                          &numBytesDecrypted);
    if(cryptStatus ==kCCSuccess){
        NSData*plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        
    }
    return plaintext;
}

///3DES加密
-(NSString *)Three_DesEncrypt:(NSString *)start
{
    NSData*data;
    NSString*ciphertext = nil;
    NSData *textData = [start dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [textData length];
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesEncrypted =0;
    const Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithm3DES,kCCOptionPKCS7Padding| kCCOptionECBMode ,
                                          [EncrityKey UTF8String],
                                          kCCKeySize3DES,
                                          iv,
                                          [textData bytes], dataLength,
                                          buffer,1024,
                                          &numBytesEncrypted);
    if(cryptStatus ==kCCSuccess) {
        data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        //加密后的data转换成64位，解密的时候需要用initWithBase64EncodedString方法转为data
        ciphertext = [data base64EncodedStringWithOptions:0];
    }
    return ciphertext;
    
    
}
///3DES解密
-(NSString *)Three_DesDecrypt:(NSString *)start
{
    //加密后的data转换成64位，解密的时候需要用initWithBase64EncodedString方法转为data
    NSData *data = [[NSData alloc] initWithBase64EncodedString:start options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString*plaintext =nil;
    unsigned char buffer[1024];
    memset(buffer,0,sizeof(char));
    size_t numBytesDecrypted =0;
    const Byte iv[] = {1,2,3,4,5,6,7,8};
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode ,
                                          [EncrityKey UTF8String],kCCKeySize3DES,
                                          iv,
                                          [data bytes],
                                          [data length],
                                          buffer,1024,
                                          &numBytesDecrypted);
    if(cryptStatus ==kCCSuccess){
        NSData*plaindata = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plaintext = [[NSString alloc]initWithData:plaindata encoding:NSUTF8StringEncoding];
        
    }
    return plaintext;

}


///RSA加密
-(NSString *)RsaEncrypt:(NSString *)start
{
   ///公钥
    NSString * publicKey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDZsTQpOgI1r62aGmtC3zJ0UDeKiyDkPCNzquRzoJ8iOkh19IZBTJQl7JO1aREB8XOLg1TjMQEmWeUXVCTt286RZ/VRNPOXITYr6pvE0waB5QrTv/WL+XYQ7brG/69SFVdwPuwSlFe916E610/9ud/a1IOIGWoE4TOs1IBdU1+ibQIDAQAB";
    
    return [RSAManager encryptString:start publicKey:publicKey];
    
    
}



///RSA解密
-(NSString *)RsaDecrypt:(NSString *)start
{
    ///公钥
    NSString * publicKey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvHxAI/ltA2vLfmqnwDrPUTgg2VLuYQ0QP+mgv8o5To8gm7Wfn0ELHuTLK4uYE8I5CYUAuzQQytxz/ydnRcXWfpLGTaksL5DceiXEHtv6khlb5C9iA3o4VGE5R2lNUTuaQdyDKIA6SILoYa5ydyqqnDsgmISgJ3DyQAbrubmuO8oeS5zJRDwm5ZtMo9SzzpBrwmksuuuQdUo8qBb/CeJ90vzSK6WNYEgFOAfENjrjlXBRNIJWzBmnw3r/KnNGGSfVPqC1P6bs+RW1y+dDFEB3ZD3So93MSS7qNxRIXy62ddJ+j7CHzpm2jWIqUsBf+OigwTSp4obyle/cfSW43pWcNwIDAQAB";
    
    
    ///私钥
    NSString * privateKey = @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8fEAj+W0Da8t+aqfAOs9ROCDZUu5hDRA/6aC/yjlOjyCbtZ+fQQse5Msri5gTwjkJhQC7NBDK3HP/J2dFxdZ+ksZNqSwvkNx6JcQe2/qSGVvkL2IDejhUYTlHaU1RO5pB3IMogDpIguhhrnJ3KqqcOyCYhKAncPJABuu5ua47yh5LnMlEPCblm0yj1LPOkGvCaSy665B1SjyoFv8J4n3S/NIrpY1gSAU4B8Q2OuOVcFE0glbMGafDev8qc0YZJ9U+oLU/puz5FbXL50MUQHdkPdKj3cxJLuo3FEhfLrZ10n6PsIfOmbaNYipSwF/46KDBNKnihvKV79x9JbjelZw3AgMBAAECggEAeawzs4VWC/lP+aFb/Ml5/1IeUmwomdnW/YsRS/19FOtr/1g1XJaeWSkUxl1spISiUTTcjfxEQtAgyTtkfTQDDN4uyP9GGMaIrQkoG0uh6yIXoau8t8X0CvRgB2tAkAnLwGxa9pAgD6MB49y645ZVYFkC57HluNA+cXqGPPRSNyFb39aqpJ4HvJbEaCujw5nVDibziRkxUEe01hXPqe35wrm/+oLS908EPFpIawsHGu2Y+7o/JaOtgzwGHSmVyxfLjVidQDSu83/o2FXsx1sBIpNCNhR/IYBxZL87uXZLEEnTML/yDe5Vw1PhWQQ/NfrP7ZpV2ZTAaozoXKlABiNoQQKBgQDvLEtAXrfUpZp44kSQoFNd+yubtH/gsrv/fNxScYXLhcdyDwIqsMz0XQxLOCIdVBbnp5ujb2OiG6GtgrY3G253xGj7P016VgHMqrAhe4NA9lbg4JNgHamr87SueYAKb3VGw9mPy1t9eiJL+00TntroPO0tJeiNqg/TiPAp4igfsQKBgQDJvweAhq3dySrs0HXvs7ecICsNR3Q6cYZH7denmTYg2hUO2v2QGsejzizI65VnLgq2KXxEh6tREloaf3Om/e6sAJnDgkGDuXAIA2oyOsQboyl3SqN53qxmnf3fSZ9+FLx9jOm49d4e08ydPOZ/qgaFPJuaACuONOFcV2brcHGcZwKBgQC2G1fAz13RP7Z6TG5AYJKZgGEX0Tt87xpN0dg/vchNyrKtmdfggXXMqfxuWXNAOYKnJ+tNacbG65sS7e+nze8yqg31H6HygAImv+AT3mN11xsXZmdQS8Wg85KjNkfTqkH1e7Hv1rr2s0Ph7polUlMDeUBtm+uR0eby/dU/Tr+WQQKBgQDCnqwoCsRzbfsg1MDQ6jg4PrgJaWLwdk+p2AHwRlb3PiqOWCe/+nWYye5eLRXFoZ7nuAGPQqm73c5aPZVeBR1XhITRHDkDT8KJmHG73wEMAEyiLbiienMp00PzQVzBDlP/cg6ORXFvn7aGARgDFAySP7ODzqI130GACTjZ63FOBQKBgCQI9+mAbh4RSFct8cxISjXJiF6uyAUr9AAtzpdXRM8JrP4Lu/MEbO2fyVkWtckNTISAFAwMfMgxEqPAwhqpRuotrSx5jrWxTX3HsRRHcak7SQoFCzrvvaD5fPnG6JtjZlIpYJo/l17um53EWLKThf15ZsnOP89J+7BQoEashs0X";
    
    ///加密
    NSString * encrtyStr = [RSAManager encryptString:start publicKey:publicKey];
    ///解密
    NSString * decrytyStr = [RSAManager decryptString:encrtyStr privateKey:privateKey];
    
    NSLog(@"加密%@----解密%@",encrtyStr,decrytyStr);
    
    return encrtyStr;
    
    
    

}


///国密SM2加密
-(NSString *)SM2Encrypt:(NSString *)start
{
    
    // 生成一对新的公私钥
    NSArray *keyPair = [GMSm2Utils createKeyPair];
    NSString *pubKey = keyPair[0]; // 测试用 04 开头公钥，Hex 编码格式
    NSString *priKey = keyPair[1]; // 测试用私钥，Hex 编码格式
    
    NSString *enResult1 = [GMSm2Utils encryptText:start publicKey:pubKey]; // 加密普通字符串
//    NSString *enResult2 = [GMSm2Utils encryptHex:start publicKey:pubKey]; // 加密 Hex 编码格式字符串
//    NSData *enResult3 = [GMSm2Utils encryptData:start publicKey:pubKey]; // 加密 NSData 类型数据
//
    
    // sm2 解密
    NSString *deResult1 = [GMSm2Utils decryptToText:start privateKey:priKey]; // 解密为普通字符串明文
//    NSString *deResult2 = [GMSm2Utils decryptToHex:start privateKey:priKey]; // 解密为 Hex 格式明文
//    NSData *deResult3 = [GMSm2Utils decryptToData:start privateKey:priKey]; // 解密为 NSData 格式明文
//
    
    return enResult1;
    
}

///国密SM3加密
-(NSString *)SM3Encrypt:(NSString *)start
{
  
    return  [[[GMManager alloc] init] SM3Hex:start];
    
    
}
///国密SM4加密
-(NSString *)SM4ECBEncrypt:(NSString *)start
{
    NSString *sm4Key = [GMSm4Utils createSm4Key]; //  生成 32 字节 Hex 编码格式字符串密钥
    // ECB 加解密模式
    NSString *sm4EcbCipertext = [GMSm4Utils ecbEncryptText:start key:sm4Key];
    
    ///解密
    NSString *sm4EcbPlaintext = [GMSm4Utils ecbDecryptText:sm4EcbCipertext key:sm4Key];
 
    
    NSLog(@"加密结果%@----解密结果%@",sm4EcbCipertext,sm4EcbPlaintext);
    return  sm4EcbCipertext;
    
}
///国密SM4加密
-(NSString *)SM4CBCEncrypt:(NSString *)start
{
    
    NSString *sm4Key = [GMSm4Utils createSm4Key];
    
    // CBC 加解密模式
    NSString *ivec = [GMSm4Utils createSm4Key]; // 生成 32 字节初始化向量
    NSString *sm4CbcCipertext = [GMSm4Utils cbcEncryptText:start key:sm4Key IV:ivec];
    NSString *sm4CbcPlaintext = [GMSm4Utils cbcDecryptText:sm4CbcCipertext key:sm4Key IV:ivec];
    
    NSLog(@"加密结果%@----解密结果%@",sm4CbcCipertext,sm4CbcPlaintext);
    
    
    return sm4CbcCipertext;
}












-(UIView *)headerView
{
    UILabel * textLeb = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 55)];
    textLeb.textAlignment = NSTextAlignmentCenter;
    textLeb.text = [NSString stringWithFormat:@"加密文本：%@",startStr];
    return  textLeb;
    
    
    
}
@end
