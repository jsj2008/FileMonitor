//Jul 31 19:19:38 360de-iPhone UserDefaults[2328] <Warning>: ---FileMonitor---Compare :  : NSDictionary_isEqualToDictionary__{
//    "objectForKey_" =     {
//        UIDisableLegacyTextView = 1;
//    };
//}_{
//    UIDisableLegacyTextView = 1;
//}

//    hasAccessibilityBeenMigrated = 1;
//}
//Jul 31 19:19:38 360de-iPhone UserDefaults[2328] <Warning>: ---FileMonitor---Compare :  : NSDictionary_isEqualToDictionary__{
//    "objectForKey_" =     {
//        hasAccessibilityBeenMigrated = 1;
//    };
//}_{
//    hasAccessibilityBeenMigrated = 1;
//}

#import "IFHOOK.h"
#ifdef NSDictionary_IF_HOOK

extern NSRegularExpression *regex;


HOOK_MESSAGE(BOOL,NSDictionary,writeToFile_atomically_,NSString *path,BOOL flag)
{
        NSRange range = [path rangeOfString:@"filemon"];
        if (range.location == NSNotFound) {
            NSString *pathexten = [path pathExtension];
            NSArray *checkingResults  = [regex matchesInString:pathexten options:0 range:NSMakeRange(0, [pathexten length])];
            if ([checkingResults count] != 0) {
                
            }else
            _LogNSDictionaryWrite(@"writeToFile_atomically_",self,path);
        }
    else
    {
//        NSLog(@"filemonitor write~");
    }
    return _NSDictionary_writeToFile_atomically_(self,sel,path,flag);
}
HOOK_MESSAGE(BOOL,NSDictionary,writeToURL_atomically_,NSURL *aURL,BOOL atomically)
{
    NSRange range = [[aURL absoluteString] rangeOfString:@"filemon"];
    if (range.location == NSNotFound) {
    _LogNSDictionaryWrite(@"writeToURL_atomically_",self,[aURL absoluteString]);
    }
    return _NSDictionary_writeToURL_atomically_(self,sel,aURL,atomically);
}


//file
HOOK_MESSAGE(BOOL,NSDictionary,initWithContentsOfFile_,NSString *path)
{
    NSDictionary *dic =  _NSDictionary_initWithContentsOfFile_(self,sel,path);
    NSString *pathexten = [path pathExtension];
    NSArray *checkingResults  = [regex matchesInString:pathexten options:0 range:NSMakeRange(0, [pathexten length])];
    if ([checkingResults count] != 0) {
        
    }else
    _LoginitWithContentsOffileorurl(@"initWithContentsOfFile_",self,path);
    return dic;
}

HOOK_MESSAGE(BOOL,NSDictionary,initWithContentsOfURL_,NSURL *aURL)
{
    NSDictionary *dic =  _NSDictionary_initWithContentsOfURL_(self,sel,aURL);
    _LoginitWithContentsOffileorurl(@"initWithContentsOfURL_",dic,aURL);
    return dic;
}

//compare
HOOK_MESSAGE(BOOL,NSDictionary,isEqualToDictionary_,NSDictionary *otherDictionary)
{
//    if ([otherDictionary objectForKey:@"UIDisableLegacyTextView"] ||[otherDictionary objectForKey:@"hasAccessibilityBeenMigrated"] || [otherDictionary objectForKey:@"NSStringDrawingLongTermThreshold"]) {
//    
//    }
//    else if([self objectForKey:@"NSColor"]  || [self objectForKey:@"NSFont"] || [self objectForKey:@"NSParagraphStyle"] )
//    {
//        
//    }
//    else{
//        _LogComparedata(@"isEqualToDictionary_",self,otherDictionary);
//    }
    return _NSDictionary_isEqualToDictionary_(self,sel,otherDictionary);
}

#endif
