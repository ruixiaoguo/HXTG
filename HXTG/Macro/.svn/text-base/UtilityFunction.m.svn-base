//
//  UtilityFunction.m
//  HXTG
//
//  Created by grx on 2017/2/15.
//  Copyright © 2017年 grx. All rights reserved.
//

#import "UtilityFunction.h"

@implementation UtilityFunction

/*! Documents路径 */
+ (NSString *)documentsPath
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

/*! Library/Caches路径 */
+ (NSString *)cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/*! Library/Application Support路径 */
+ (NSString *)applicationSupportPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) firstObject];
}

/*! 文件夹路径，如果参数传入的文件夹不存在则创建 */
+ (NSString *)directoryPath:(NSString*)path
{
    NSFileManager* fileManager = DefaultFileManager;
    if (![fileManager fileExistsAtPath:path])
    {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}


/*! 获取文本大小 */
+ (CGSize)getTextSizeWithOutLineSystemFont:(UIFont *)font ConstrainedToSize:(CGSize)size string:(NSString *)labelString
{
    CGSize fitSize = CGSizeMake(0, 0);
    
    if( labelString.length > 0 )
    {
        fitSize = [labelString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    }
    return fitSize;
}

/*! 判断电话号码 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    NSString * MOBILE = @"^0?(13|15|17|18|14)[0-9]{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }

}

/*! 判断电话号码 */
+ (BOOL)isTelephoneNumber:(NSString *)mobileNum
{
    if (mobileNum.length < 7)
    {
        return NO;
    }
    
    NSString *telephone = @"^(0[0-9]{2,3}\\-)?([2-9][0-9]{6,7})+(\\-[0-9]{1,4})?$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telephone];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/*! 判断有效邮箱 */
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*! 判断有效身份证 */
+ (BOOL)verifyIDCardNumber:(NSString *)value
{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([value length] != 18) {
        return NO;
    }
    
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:value]) {
        return NO;
    }
    int summary = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6
    + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[value substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}


/*! 计算文字长度 */
+ (int)lengthOfStr:(NSString *)str
{
    int length=0;
    for (int i=0; i<[str length]; i++)
    {
        int a=[str characterAtIndex:i];
        if (a > 0x4e00 && a < 0x9fff)
        {
            length += 2;
        }else
        {
            length += 1;
        }
    }
    return length;
}

/*! 过滤html标签 */
+ (NSString *)removeHTML:(NSString *)html {
    
    NSScanner *theScanner;
    
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        
        [theScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@" "];
    }
    
    return html;
}

/*! 判断账户名 */
+ (BOOL)validateUserName:(NSString *)name
{
    /*! 不包含特殊符号 */
    NSString *userNameRegex = @"^[a-zA-Z0-9]+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL isName = [userNamePredicate evaluateWithObject:name];
    return isName;
}

/*! 是否含特殊字符 */
+ (BOOL)validateUserNameSign:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9_\\-\\u4e00-\\u9fa5]{6,20}$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL isName = [userNamePredicate evaluateWithObject:name];
    return isName;
}

/*! 用户密码验证 */
+ (BOOL) validatePassword:(NSString *)passWord
{
    /*! 要求数字、字母、字符，至少包含两种，不少于6位 */
    NSString *passWordRegex = @"^(?!^[0-9]+$)(?!^[A-z]+$)(?!^[^A-z0-9]+$)^.{6,20}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

/*! 判断银行卡号 */
+(BOOL)validateBankId:(NSString *)BankId
{
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[BankId length];
    int lastNum = [[BankId substringFromIndex:cardNoLength-1] intValue];
    
    BankId = [BankId substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [BankId substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
    
}

/*! 输入表情验证 */
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

/*! 只能为数字 */
+ (BOOL)validateNum:(NSString *)num{
    NSString *numberRegex = @"^[0-9]*$";
    NSPredicate *numberPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    BOOL isNum = [numberPredicate evaluateWithObject:num];
    return isNum;
}

+ (NSString *)responseUUID
{
    UIDevice *device = [UIDevice currentDevice];//创建设备对象
    NSString *deviceUID = [[device identifierForVendor]UUIDString];
    return deviceUID;
}

/*! 当前版本号 */
+(NSString *)gaintVersion
{
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return appVersion;
}

/*! 手机系统版本 */
+(NSString *)gaintDeviceVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

/*! 设备名称 */
+(NSString *)gaintDeviceName
{
    return [[UIDevice currentDevice] systemName];
}


@end
