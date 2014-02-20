//
//  TrabajarConFicherosPlist.m
//  ASKME
//
//  Created by LUISMI on 18/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "TrabajarConFicherosPlist.h"

@implementation TrabajarConFicherosPlist

- (NSDictionary*) leerDatosPlist:(NSString*)nombreFichero
{
    
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",nombreFichero]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        plistPath = [[NSBundle mainBundle] pathForResource:nombreFichero ofType:@"plist"];
    }
    //NSLog(@"PATH: %@",plistPath);
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temporal = (NSDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temporal) {
        NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
        return nil;
    }else{
        return temporal;
    }
}

@end
