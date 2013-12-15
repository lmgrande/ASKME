//
//  Pregunta.h
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pregunta : NSObject

@property (nonatomic, strong) NSString *textoPregunta;
@property (nonatomic, strong) NSString *textoMateria;
@property (nonatomic, strong) NSString *textoCorrecta;
@property (nonatomic, strong) NSString *textoIncorrecta1;
@property (nonatomic, strong) NSString *textoIncorrecta2;
@property (nonatomic, strong) NSString *textoIncorrecta3;

- (id) initWithTextoPregunta: (NSString *)textPregunta
             andTextoMateria: (NSString*)textMateria
            andTextoCorrecta: (NSString*)textCorrecta
         andTextoIncorrecta1: (NSString*)textIncorrecta1
         andTextoIncorrecta2: (NSString*)textIncorrecta2
         andTextoIncorrecta3: (NSString*)textIncorrecta3;

@end
