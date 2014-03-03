//
//  ConexionServidor.h
//  ASKME
//
//  Created by LUISMI on 26/02/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ConexionServidorRequestCompletionHandler) (NSData *data, NSURLResponse *response, NSError *error);

@interface ConexionServidor : NSObject

-(void)enviarAURL:(NSString*)urlString conParametrosPost:(NSDictionary*)parametros delegate:(id)delegado completionHandler:(ConexionServidorRequestCompletionHandler)completionBlock;


@end
