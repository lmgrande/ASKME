//
//  Pregunta.m
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "Pregunta.h"

@implementation Pregunta

@synthesize textoPregunta, textoMateria, textoCorrecta, textoIncorrecta1, textoIncorrecta2, textoIncorrecta3;

- (id) initWithTextoPregunta: (NSString *)textPregunta
             andTextoMateria: (NSString*)textMateria
            andTextoCorrecta: (NSString*)textCorrecta
         andTextoIncorrecta1: (NSString*)textIncorrecta1
         andTextoIncorrecta2: (NSString*)textIncorrecta2
         andTextoIncorrecta3: (NSString*)textIncorrecta3
{
    self = [super init];
    if (self) {
        textoPregunta = textPregunta;
        textoMateria = textMateria;
        textoCorrecta =textCorrecta;
        textoIncorrecta1 = textIncorrecta1;
        textoIncorrecta2 = textIncorrecta2;
        textoIncorrecta3 = textIncorrecta3;
    }
    return self;
}

@end
