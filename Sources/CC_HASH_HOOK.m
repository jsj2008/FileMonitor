#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "IFHOOK.h"
#ifdef HASH_IF_HOOK

/*
 extern unsigned char *
 CC_MD5(const void *data, CC_LONG len, unsigned char *md);
 */
HOOK_CFUNCTION(unsigned char *, RTLD_DEFAULT, CC_MD5,const void *data, CC_LONG len, unsigned char *result)
{
    //data 输入  len 长度   result 输出
    unsigned char * ret = _CC_MD5(data,len,result);
    if (len) {
        NSString *NS_data =[NSString stringWithFormat:@"%s",data];
        NSString *NS_result =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",\
         result[0], result[1], result[2], result[3],\
         result[4], result[5], result[6], result[7],\
         result[8], result[9], result[10], result[11],\
         result[12], result[13], result[14], result[15]\
         ];
        
        NSRange range =[NS_data rangeOfString:@"MGCopyAnswer"];
        
        if (range.location != NSNotFound) {
            
        }
        else
            _LogHash(@"CC_MD5",NS_data,NS_result);
    }
    return ret;
}


HOOK_CFUNCTION(unsigned char *, RTLD_DEFAULT, CC_SHA1,const void *data, CC_LONG len, unsigned char *result)
{
    //    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    //    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //    CC_SHA1(data.bytes, data.length, digest);
    //    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    //    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    //        [output appendFormat:@"%02x", digest[i]];
    //    return output;
    
    unsigned char* ret =  _CC_SHA1(data,len,result);
    
    if (len)
    {
        NSString *NS_result =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",\
                                result[0], result[1], result[2], result[3],\
                                result[4], result[5], result[6], result[7],\
                                result[8], result[9], result[10], result[11],\
                                result[12], result[13], result[14], result[15],\
                                result[16], result[17], result[18], result[19]
                                ];
        NSString *NS_data =[NSString stringWithFormat:@"%s",data];
        _LogHash(@"CC_SHA1",NS_data,NS_result);
    }
    
    return ret;
}


//extern unsigned char *CC_MD2(const void *data, CC_LONG len, unsigned char *md)
//HOOK_CFUNCTION(unsigned char *, RTLD_DEFAULT, CC_MD2,const void *data, CC_LONG len, unsigned char *md)
//{
//    unsigned char* ret =  _CC_SHA1(data,len,result);
//    
//    if (len)
//    {
//        NSString *NS_result =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",\
//                                result[0], result[1], result[2], result[3],\
//                                result[4], result[5], result[6], result[7],\
//                                result[8], result[9], result[10], result[11],\
//                                result[12], result[13], result[14], result[15],\
//                                result[16], result[17], result[18], result[19]
//                                ];
//        NSString *NS_data =[NSString stringWithFormat:@"%s",data];
//        _LogHash(@"CC_MD2",NS_data,NS_result);
//    }
//    
//    return ret;
//}
//


#endif
