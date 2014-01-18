//
//  TrabajarConFicherosJason.h
//  ASKME
//
//  Created by LUISMI on 15/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrabajarConFicherosJason : NSObject

@property (nonatomic, strong) NSMutableArray *preguntasArray;


- (BOOL) recogerYGrabarDatosEnFicheroJSON;
- (void) sacarDatosFicheroJSON;

@end
