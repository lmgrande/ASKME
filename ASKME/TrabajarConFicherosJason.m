//
//  TrabajarConFicherosJason.m
//  ASKME
//
//  Created by LUISMI on 15/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "TrabajarConFicherosJason.h"
#import "Pregunta.h"

//#define urlParaTraerDatos @"http://www.askmeapp.com/php_IOS/leerPreguntasJugador.php"

@implementation TrabajarConFicherosJason
{
    BOOL correcto;
    NSMutableArray *json;
}

@synthesize preguntasArray;
@synthesize listadoArray;


#pragma mark - Metodos

- (BOOL) recogerYGrabarDatosEnFicheroJSON:(NSString*)urlParaTraerDatos andNombreFichero:(NSString*)nombreFichero
{
    NSURL *url = [NSURL URLWithString:urlParaTraerDatos];
    
    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *jsonData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    NSError *error1;
    
    // array of dictionary
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error1];
    
    if (error1) {
        NSLog(@"Error: %@", error1.localizedDescription);
        correcto =FALSE;
    } else {
        // para sobreescribir fichero json
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // -------------------------------
        
        NSArray *documentsSearchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [documentsSearchPaths count] == 0 ? nil : [documentsSearchPaths objectAtIndex:0];
        
        NSString *fileName = nombreFichero;
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        // para sobreescribir fichero json
        if ([fileManager fileExistsAtPath:filePath] == YES) {
            NSError *errorfileExistsAtPath;
            [fileManager removeItemAtPath:filePath error:&errorfileExistsAtPath];
        }
        // -------------------------------
        
        NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
        [outputStream open];
        
        [NSJSONSerialization writeJSONObject:array
                                    toStream:outputStream
                                     options:kNilOptions
                                       error:&error1];
        [outputStream close];
        NSLog(@"Path JSON: %@",filePath);
        correcto = YES;
    }
    
    return correcto;
    
}

- (void) sacarDatosFicheroJSON
{
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/preguntas.json"];
    NSLog(@"Path JSON leer: %@",jsonPath);
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSLog(@"Data JSON leer: %@",data);
    json = [[NSMutableArray alloc] init];
    json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    preguntasArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<json.count; i++)
    {
        NSLog(@"REGISTRO JSON: %D",i);
        NSString *textPregunta = [[json objectAtIndex:i] objectForKey:@"pregunta"];
        NSLog(@"Pregunta JSON: %@",textPregunta);
        NSString *textMateria = [[json objectAtIndex:i] objectForKey:@"materia"];
        NSLog(@"Materia JSON: %@",textMateria);
        NSString *textCorrecta = [[json objectAtIndex:i] objectForKey:@"correcta"];
        NSLog(@"Correcta JSON: %@",textCorrecta);
        NSString *textIncorrecta1 = [[json objectAtIndex:i] objectForKey:@"incorrecta1"];
        NSLog(@"Incorrecta1 JSON: %@",textIncorrecta1);
        NSString *textIncorrecta2 = [[json objectAtIndex:i] objectForKey:@"incorrecta2"];
        NSLog(@"Incorrecta2 JSON: %@",textIncorrecta2);
        NSString *textIncorrecta3 = [[json objectAtIndex:i] objectForKey:@"incorrecta3"];
        NSLog(@"Incorrecta3 JSON: %@",textIncorrecta3);
        
        Pregunta *miPregunta = [[Pregunta alloc] initWithTextoPregunta:textPregunta andTextoMateria:textMateria andTextoCorrecta:textCorrecta andTextoIncorrecta1:textIncorrecta1 andTextoIncorrecta2:textIncorrecta2 andTextoIncorrecta3:textIncorrecta3];
        
        [preguntasArray addObject:miPregunta];
    }
    
}

- (void) sacarDatosListadoJSON
{
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/listadoPartida.json"];
    NSLog(@"Path JSON leer: %@",jsonPath);
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSLog(@"Data JSON leer: %@",data);
    listadoArray = [[NSMutableArray alloc] init];
    listadoArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}


@end
