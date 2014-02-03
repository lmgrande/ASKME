//
//  GestionarDatosYPuntosPartida.h
//  ASKME
//
//  Created by LUISMI on 11/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol GestionarDatosYPuntosPartidaDelegado <NSObject>
//
//@end
//
//@protocol GestionarDatosYPuntosPartidaDataSource <NSObject>
//
//@end


@interface GestionarDatosYPuntosPartida : NSObject

//@property (weak, nonatomic) id<GestionarDatosYPuntosPartidaDelegado> delegate;
//@property (weak, nonatomic) id<GestionarDatosYPuntosPartidaDataSource> datasource;

@property (strong, nonatomic) NSMutableDictionary *partida;
@property (strong, nonatomic) NSMutableDictionary *partidas;

@property (nonatomic) NSInteger totalPreguntasContestadas;
@property (nonatomic) NSInteger totalPreguntasPartida;
@property (nonatomic) NSInteger puntosMaximosPartida;
@property (nonatomic) NSInteger puntosTotalesPartida;
@property (nonatomic) NSInteger preguntasAcertadas;
@property (nonatomic) NSInteger preguntasFalladas;
@property (nonatomic) NSInteger preguntasNoContestadas;

-(void)inicializarPartida;
-(void)inicializarPartidas;
-(void)grabarDatosPartidaPlist;
-(void)grabarDatosPartidasPlist;
-(NSArray*)comprobarMateria:(NSString*)materia;
-(void) acumularPuntosAciertos:(NSString*)materia andAcertada:(BOOL)acierto andPuntosPregunta:(NSInteger)puntos;
-(void)enviarPuntos:(NSString*)preguntas_Partida
                   :(NSString*)puntos_Partida
                   :(NSString*)preguntas_Contestadas
                   :(NSString*)preguntas_Acertadas
                   :(NSString*)preguntas_Falladas
                   :(NSString*)preguntas_Pasadas
                   :(NSString*)puntos_Conseguidos;

@end
