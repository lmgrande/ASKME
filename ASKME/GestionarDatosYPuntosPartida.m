//
//  GestionarDatosYPuntosPartida.m
//  ASKME
//
//  Created by LUISMI on 11/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "GestionarDatosYPuntosPartida.h"

@implementation GestionarDatosYPuntosPartida
{
    NSInteger arteLiteraturaContestadas, arteLiteraturaAcertadas,arteLiteraturaPuntos;
    NSInteger cienciasContestadas, cienciasAcertadas,cienciasPuntos;
    NSInteger deportesContestadas, deportesAcertadas,deportesPuntos;
    NSInteger geografiaContestadas, geografiaAcertadas,geografiaPuntos;
    NSInteger historiaContestadas, historiaAcertadas,historiaPuntos;
    NSInteger ocioContestadas, ocioAcertadas,ocioPuntos;
    NSInteger otrosContestadas, otrosAcertadas,otrosPuntos;
}

@synthesize partida, partidas;
@synthesize totalPreguntasPartida, puntosMaximosPartida, totalPreguntasContestadas, puntosTotalesPartida,preguntasAcertadas,preguntasFalladas,preguntasNoContestadas;

-(void)inicializarPartida
{
    partida = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
               @"0", @"arte-literatura-contestadas",
               @"0", @"arte-literatura-acertadas",
               @"0", @"arte-literatura-puntos",
               @"0", @"ciencias-contestadas",
               @"0", @"ciencias-acertadas",
               @"0", @"ciencias-puntos",
               @"0", @"deportes-contestadas",
               @"0", @"deportes-acertadas",
               @"0", @"deportes-puntos",
               @"0", @"geografia-contestadas",
               @"0", @"geografia-acertadas",
               @"0", @"geografia-puntos",
               @"0", @"historia-contestadas",
               @"0", @"historia-acertadas",
               @"0", @"historia-puntos",
               @"0", @"ocio-contestadas",
               @"0", @"ocio-acertadas",
               @"0", @"ocio-puntos",
               @"0", @"otros-contestadas",
               @"0", @"otros-acertadas",
               @"0", @"otros-puntos",
               @"0", @"total-preguntas-partida",
               @"0", @"total-preguntas-contestadas",
               @"0", @"total-preguntas-acertadas",
               @"0", @"total-preguntas-falladas",
               @"0", @"total-preguntas-pasadas",
               @"0", @"puntos-totales-conseguidos",
               @"0", @"puntos-maximos-partida",
               nil];
}

-(void)inicializarPartidas
{
    partidas = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                @"0", @"arte-literatura-contestadas",
                @"0", @"arte-literatura-acertadas",
                @"0", @"arte-literatura-puntos",
                @"0", @"ciencias-contestadas",
                @"0", @"ciencias-acertadas",
                @"0", @"ciencias-puntos",
                @"0", @"deportes-contestadas",
                @"0", @"deportes-acertadas",
                @"0", @"deportes-puntos",
                @"0", @"geografia-contestadas",
                @"0", @"geografia-acertadas",
                @"0", @"geografia-puntos",
                @"0", @"historia-contestadas",
                @"0", @"historia-acertadas",
                @"0", @"historia-puntos",
                @"0", @"ocio-contestadas",
                @"0", @"ocio-acertadas",
                @"0", @"ocio-puntos",
                @"0", @"otros-contestadas",
                @"0", @"otros-acertadas",
                @"0", @"otros-puntos",
                @"0", @"total-preguntas-contestadas",
                @"0", @"total-preguntas-acertadas",
                @"0", @"total-preguntas-falladas",
                @"0", @"puntos-totales-conseguidos",
                nil];
}

-(void)grabarDatosPartidaPlist
{
    [self.partida setObject:[NSString stringWithFormat:@"%d", totalPreguntasPartida]forKey:@"total-preguntas-partida"];
    [self.partida setObject:[NSString stringWithFormat:@"%d", totalPreguntasContestadas] forKey:@"total-preguntas-contestadas"];
    [self.partida setObject:[NSString stringWithFormat:@"%d", preguntasAcertadas] forKey:@"total-preguntas-acertadas"];
    
    
    [self.partida setObject:[NSString stringWithFormat:@"%d", preguntasFalladas] forKey:@"total-preguntas-falladas"];
    [self.partida setObject:[NSString stringWithFormat:@"%d", preguntasNoContestadas] forKey:@"total-preguntas-pasadas"];
    [self.partida setObject:[NSString stringWithFormat:@"%d", puntosTotalesPartida] forKey:@"puntos-totales-conseguidos"];
    [self.partida setObject:[NSString stringWithFormat:@"%d", puntosMaximosPartida] forKey:@"puntos-maximos-partida"];
    
    NSString *alC=[NSString stringWithFormat:@"%d", arteLiteraturaContestadas];
    NSString *alA=[NSString stringWithFormat:@"%d", arteLiteraturaAcertadas];
    NSString *alP=[NSString stringWithFormat:@"%d", arteLiteraturaPuntos];
    [self.partida setObject:alC forKey:@"arte-literatura-contestadas"];
    [self.partida setObject:alA forKey:@"arte-literatura-acertadas"];
    [self.partida setObject:alP forKey:@"arte-literatura-puntos"];
    
    NSString *cC=[NSString stringWithFormat:@"%d", cienciasContestadas];
    NSString *cA=[NSString stringWithFormat:@"%d", cienciasAcertadas];
    NSString *cP=[NSString stringWithFormat:@"%d", cienciasPuntos];
    [self.partida setObject:cC forKey:@"ciencias-contestadas"];
    [self.partida setObject:cA forKey:@"ciencias-acertadas"];
    [self.partida setObject:cP forKey:@"ciencias-puntos"];
    
    NSString *dC=[NSString stringWithFormat:@"%d", deportesContestadas];
    NSString *dA=[NSString stringWithFormat:@"%d", deportesAcertadas];
    NSString *dP=[NSString stringWithFormat:@"%d", deportesPuntos];
    [self.partida setObject:dC forKey:@"deportes-contestadas"];
    [self.partida setObject:dA forKey:@"deportes-acertadas"];
    [self.partida setObject:dP forKey:@"deportes-puntos"];
    
    NSString *gC=[NSString stringWithFormat:@"%d", geografiaContestadas];
    NSString *gA=[NSString stringWithFormat:@"%d", geografiaAcertadas];
    NSString *gP=[NSString stringWithFormat:@"%d", geografiaPuntos];
    [self.partida setObject:gC forKey:@"geografia-contestadas"];
    [self.partida setObject:gA forKey:@"geografia-acertadas"];
    [self.partida setObject:gP forKey:@"geografia-puntos"];
    
    NSString *hC=[NSString stringWithFormat:@"%d", historiaContestadas];
    NSString *hA=[NSString stringWithFormat:@"%d", historiaAcertadas];
    NSString *hP=[NSString stringWithFormat:@"%d", historiaPuntos];
    [self.partida setObject:hC forKey:@"historia-contestadas"];
    [self.partida setObject:hA forKey:@"historia-acertadas"];
    [self.partida setObject:hP forKey:@"historia-puntos"];
    
    NSString *oC=[NSString stringWithFormat:@"%d", ocioContestadas];
    NSString *oA=[NSString stringWithFormat:@"%d", ocioAcertadas];
    NSString *oP=[NSString stringWithFormat:@"%d", ocioPuntos];
    [self.partida setObject:oC forKey:@"ocio-contestadas"];
    [self.partida setObject:oA forKey:@"ocio-acertadas"];
    [self.partida setObject:oP forKey:@"ocio-puntos"];
    
    NSString *otrosC=[NSString stringWithFormat:@"%d", otrosContestadas];
    NSString *otrosA=[NSString stringWithFormat:@"%d", otrosAcertadas];
    NSString *otrosP=[NSString stringWithFormat:@"%d", otrosPuntos];
    [self.partida setObject:otrosC forKey:@"otros-contestadas"];
    [self.partida setObject:otrosA forKey:@"otros-acertadas"];
    [self.partida setObject:otrosP forKey:@"otros-puntos"];
    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"datosPartida.plist"];
    NSLog(@"PATH datosPartida: %@",plistPath);
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:partida
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        [self grabarDatosPartidasPlist];
    }
    else {
        NSLog(@"%@d",error);
    }
}

-(void)grabarDatosPartidasPlist
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath1;
    NSString *rootPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                               NSUserDomainMask, YES) objectAtIndex:0];
    plistPath1 = [rootPath1 stringByAppendingPathComponent:@"datosPartidas.plist"];
    NSLog(@"PATH: %@",plistPath1);
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath1];
    NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization
                                                        propertyListFromData:plistXML
                                                        mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                        format:&format
                                                        errorDescription:&errorDesc];
    if (!temp) {
        //grabar partida
        NSString *error;
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.partida
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath1 atomically:YES];
        }
        else {
            NSLog(@"%@d",error);
        }
        
    }else{
        
        NSString *alC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-contestadas"] integerValue]+[[self.partida objectForKey:@"arte-literatura-contestadas"] integerValue]];
        [self.partidas setObject:alC forKey:@"arte-literatura-contestadas"];
        
        NSString *alA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-acertadas"] integerValue]+[[self.partida objectForKey:@"arte-literatura-acertadas"] integerValue]];
        [self.partidas setObject:alA forKey:@"arte-literatura-acertadas"];
        
        NSString *alP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-puntos"] integerValue]+[[self.partida objectForKey:@"arte-literatura-puntos"] integerValue]];
        [self.partidas setObject:alP forKey:@"arte-literatura-puntos"];
        
        NSString *cC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-contestadas"] integerValue]+[[self.partida objectForKey:@"ciencias-contestadas"] integerValue]];
        [self.partidas setObject:cC forKey:@"ciencias-contestadas"];
        
        NSString *cA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-acertadas"] integerValue]+[[self.partida objectForKey:@"ciencias-acertadas"] integerValue]];
        [self.partidas setObject:cA forKey:@"ciencias-acertadas"];
        
        NSString *cP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-puntos"] integerValue]+[[self.partida objectForKey:@"ciencias-puntos"] integerValue]];
        [self.partidas setObject:cP forKey:@"ciencias-puntos"];
        
        NSString *dC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-contestadas"] integerValue]+[[self.partida objectForKey:@"deportes-contestadas"] integerValue]];
        [self.partidas setObject:dC forKey:@"deportes-contestadas"];
        
        NSString *dA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-acertadas"] integerValue]+[[self.partida objectForKey:@"deportes-acertadas"] integerValue]];
        [self.partidas setObject:dA forKey:@"deportes-acertadas"];
        
        NSString *dP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-puntos"] integerValue]+[[self.partida objectForKey:@"deportes-puntos"] integerValue]];
        [self.partidas setObject:dP forKey:@"deportes-puntos"];
        
        NSString *gC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-contestadas"] integerValue]+[[self.partida objectForKey:@"geografia-contestadas"] integerValue]];
        [self.partidas setObject:gC forKey:@"geografia-contestadas"];
        
        NSString *gA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-acertadas"] integerValue]+[[self.partida objectForKey:@"geografia-acertadas"] integerValue]];
        [self.partidas setObject:gA forKey:@"geografia-acertadas"];
        
        NSString *gP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-puntos"] integerValue]+[[self.partida objectForKey:@"geografia-puntos"] integerValue]];
        [self.partidas setObject:gP forKey:@"geografia-puntos"];
        
        NSString *hC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-contestadas"] integerValue]+[[self.partida objectForKey:@"historia-contestadas"] integerValue]];
        [self.partidas setObject:hC forKey:@"historia-contestadas"];
        
        NSString *hA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-acertadas"] integerValue]+[[self.partida objectForKey:@"historia-acertadas"] integerValue]];
        [self.partidas setObject:hA forKey:@"historia-acertadas"];
        
        NSString *hP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-puntos"] integerValue]+[[self.partida objectForKey:@"historia-puntos"] integerValue]];
        [self.partidas setObject:hP forKey:@"historia-puntos"];
        
        NSString *oC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-contestadas"] integerValue]+[[self.partida objectForKey:@"ocio-contestadas"] integerValue]];
        [self.partidas setObject:oC forKey:@"ocio-contestadas"];
        
        NSString *oA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-acertadas"] integerValue]+[[self.partida objectForKey:@"ocio-acertadas"] integerValue]];
        [self.partidas setObject:oA forKey:@"ocio-acertadas"];
        
        NSString *oP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-puntos"] integerValue]+[[self.partida objectForKey:@"ocio-puntos"] integerValue]];
        [self.partidas setObject:oP forKey:@"ocio-puntos"];
        
        NSString *otrosC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-contestadas"] integerValue]+[[self.partida objectForKey:@"otros-contestadas"] integerValue]];
        [self.partidas setObject:otrosC forKey:@"otros-contestadas"];
        
        NSString *otrosA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-acertadas"] integerValue]+[[self.partida objectForKey:@"otros-acertadas"] integerValue]];
        [self.partidas setObject:otrosA forKey:@"otros-acertadas"];
        
        NSString *otrosP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-puntos"] integerValue]+[[self.partida objectForKey:@"otros-puntos"] integerValue]];
        [self.partidas setObject:otrosP forKey:@"otros-puntos"];
        
        NSString *preguntasC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-contestadas"] integerValue]+[[self.partida objectForKey:@"total-preguntas-contestadas"] integerValue]];
        [self.partidas setObject:preguntasC forKey:@"total-preguntas-contestadas"];
        
        NSString *preguntasA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-acertadas"] integerValue]+[[self.partida objectForKey:@"total-preguntas-acertadas"] integerValue]];
        [self.partidas setObject:preguntasA forKey:@"total-preguntas-acertadas"];
        
        NSString *preguntasF=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-falladas"] integerValue]+[[self.partida objectForKey:@"total-preguntas-falladas"] integerValue]];
        [self.partidas setObject:preguntasF forKey:@"total-preguntas-falladas"];
        
        NSString *preguntasP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"puntos-totales-conseguidos"] integerValue]+[[self.partida objectForKey:@"puntos-totales-conseguidos"] integerValue]];
        [self.partidas setObject:preguntasP forKey:@"puntos-totales-conseguidos"];
        
        NSString *error;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"datosPartidas.plist"];
        NSLog(@"PATH datosPartidas: %@",plistPath);
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:self.partidas
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else {
            NSLog(@"%@d",error);
        }
        
    }
    
}


-(NSArray*)comprobarMateria:(NSString*)materia
{
    NSArray *configInterfaceMateriaPregunta;
    
    if ([materia isEqual:@"general"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-otros.png", @"icono-otros", @"OTROS", nil];
        otrosContestadas++;
    }else if ([materia isEqual:@"arteliteratura"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-arte-literatura.png", @"icono-arte-literatura", @"ARTE y LITERATURA", nil];
        arteLiteraturaContestadas++;
    }else if ([materia isEqual:@"ciencias"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-ciencias.png", @"icono-ciencias", @"CIENCIAS", nil];
        cienciasContestadas++;
    }else if ([materia isEqual:@"deportes"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-deportes.png", @"icono-deportes", @"DEPORTES", nil];
        deportesContestadas++;
    }else if ([materia isEqual:@"espectaculosocio"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-ocio.png", @"icono-ocio", @"OCIO", nil];
        ocioContestadas++;
    }else if ([materia isEqual:@"geografia"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-geografia.png", @"icono-geografia", @"GEOGRAFÍA", nil];
        geografiaContestadas++;
    }else if ([materia isEqual:@"historia"]){
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-historia.png", @"icono-historia", @"HISTORIA", nil];
        historiaContestadas++;
    }else {
        configInterfaceMateriaPregunta = [[NSArray alloc] initWithObjects:@"FONDO-PIE-JUGADOR-base.png", @"icono-base", @"MATERIA", nil];
    }
    
    return configInterfaceMateriaPregunta;
}

-(void) acumularPuntosAciertos:(NSString*)materia andAcertada:(BOOL)acierto andPuntosPregunta:(NSInteger)puntos
{
    if ([materia isEqual:@"general"]&&(acierto==YES)){
        otrosAcertadas++;
        otrosPuntos=otrosPuntos+puntos;
    }else if ([materia isEqual:@"arteliteratura"]&&(acierto==YES)){
        arteLiteraturaAcertadas++;
        arteLiteraturaPuntos=arteLiteraturaPuntos+puntos;
    }else if ([materia isEqual:@"ciencias"]&&(acierto==YES)){
        cienciasAcertadas++;
        cienciasPuntos=cienciasPuntos+puntos;
    }else if ([materia isEqual:@"deportes"]&&(acierto==YES)){
        deportesAcertadas++;
        deportesPuntos=deportesPuntos+puntos;
    }else if ([materia isEqual:@"espectaculosocio"]&&(acierto==YES)){
        ocioAcertadas++;
        ocioPuntos=ocioPuntos+puntos;
    }else if ([materia isEqual:@"geografia"]&&(acierto==YES)){
        geografiaAcertadas++;
        geografiaPuntos=geografiaPuntos+puntos;
    }else if ([materia isEqual:@"historia"]&&(acierto==YES)){
        historiaAcertadas++;
        historiaPuntos=historiaPuntos+puntos;
    }
    if ([materia isEqual:@"general"]&&(acierto==NO)){
        otrosPuntos=otrosPuntos+puntos;
    }else if ([materia isEqual:@"arteliteratura"]&&(acierto==NO)){
        arteLiteraturaPuntos=arteLiteraturaPuntos+puntos;
    }else if ([materia isEqual:@"ciencias"]&&(acierto==NO)){
        cienciasPuntos=cienciasPuntos+puntos;
    }else if ([materia isEqual:@"deportes"]&&(acierto==NO)){
        deportesPuntos=deportesPuntos+puntos;
    }else if ([materia isEqual:@"espectaculosocio"]&&(acierto==NO)){
        ocioPuntos=ocioPuntos+puntos;
    }else if ([materia isEqual:@"geografia"]&&(acierto==NO)){
        geografiaPuntos=geografiaPuntos+puntos;
    }else if ([materia isEqual:@"historia"]&&(acierto==NO)){
        historiaPuntos=historiaPuntos+puntos;
    }
}

#pragma mark - Conexión con servidor para poner puntos en lista de puntuación

-(void)enviarPuntos:(NSString*)preguntas_Partida
                   :(NSString*)puntos_Partida
                   :(NSString*)preguntas_Contestadas
                   :(NSString*)preguntas_Acertadas
                   :(NSString*)preguntas_Falladas
                   :(NSString*)preguntas_Pasadas
                   :(NSString*)puntos_Conseguidos
{
    NSString *nombre_Usuario = [ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"];
//    NSString *preguntas_Partida = [NSString stringWithFormat:@"%d", totalPreguntasPartida];
//    NSString *puntos_Partida = [NSString stringWithFormat:@"%d", puntosMaximosPartida];
//    NSString *preguntas_Contestadas = [NSString stringWithFormat:@"%d", totalPreguntasContestadas];
//    NSString *preguntas_Acertadas = [NSString stringWithFormat:@"%d", preguntasAcertadas];
//    NSString *preguntas_Falladas = [NSString stringWithFormat:@"%d", preguntasFalladas];
//    NSString *preguntas_Pasadas = [NSString stringWithFormat:@"%d", preguntasNoContestadas];
//    NSString *puntos_Conseguidos = [NSString stringWithFormat:@"%d", puntosTotalesPartida];
    
    NSLog(@"nombreUsuario=%@&preguntasPartida=%@&puntosPartida=%@&preguntasContestadas=%@&preguntasAcertadas=%@&preguntasFalladas=%@&preguntasPasadas=%@&puntosConseguidos=%@", nombre_Usuario, preguntas_Partida, puntos_Partida, preguntas_Contestadas, preguntas_Acertadas, preguntas_Falladas, preguntas_Pasadas, puntos_Conseguidos);
    
    NSURLSessionConfiguration *configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuracionConexion.timeoutIntervalForRequest = 10.0;
    configuracionConexion.timeoutIntervalForResource = 10.0;
    
    NSURLSession *conexionSession = [NSURLSession sessionWithConfiguration:configuracionConexion];
    
    NSURL *url = [NSURL URLWithString:@"http://www.askmeapp.com/php_IOS/grabarPuntosPartidaUsuario.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *parametros = [NSString stringWithFormat:@"nombreUsuario=%@&preguntasPartida=%@&puntosPartida=%@&preguntasContestadas=%@&preguntasAcertadas=%@&preguntasFalladas=%@&preguntasPasadas=%@&puntosConseguidos=%@", nombre_Usuario, preguntas_Partida, puntos_Partida, preguntas_Contestadas, preguntas_Acertadas, preguntas_Falladas, preguntas_Pasadas, puntos_Conseguidos];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[parametros dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask *dataTask = [conexionSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *respuestaDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        if (!error) {
            NSLog(@"%@", response);
            NSLog(@"%@", respuestaDictionary);
        }
    }];
    
    [dataTask resume];
}

@end
