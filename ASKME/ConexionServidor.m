//
//  ConexionServidor.m
//  ASKME
//
//  Created by LUISMI on 26/02/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "ConexionServidor.h"

@implementation ConexionServidor

-(void)enviarAURL:(NSString*)urlString conParametrosPost:(NSDictionary*)parametros delegate:(id)delegado completionHandler:(ConexionServidorRequestCompletionHandler)completionBlock
{
    NSURLSessionConfiguration *configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuracionConexion.timeoutIntervalForRequest = 2.0;
    configuracionConexion.timeoutIntervalForResource = 2.0;
    
    NSURLSession *conexionSession = [NSURLSession sessionWithConfiguration:configuracionConexion delegate:delegado delegateQueue:nil];
    
    NSMutableString *paramsString = [NSMutableString string];
    [paramsString appendString:[NSString stringWithFormat:@""]];
    if (parametros !=nil) {
        [parametros enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if ([paramsString isEqualToString:@""]) {
                [paramsString appendString:[NSString stringWithFormat:@"%@=%@", key, obj]];
            }else{
                [paramsString appendString:[NSString stringWithFormat:@"&%@=%@", key, obj]];
            }
        }];
    }
    
    NSURL *url=[NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[paramsString dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [conexionSession dataTaskWithRequest:urlRequest completionHandler:completionBlock];
    
    [dataTask resume];
}

@end
