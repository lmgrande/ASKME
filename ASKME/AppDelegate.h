//
//  AppDelegate.h
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSTimer *notificationTimer;
@property (readwrite, assign) NSInteger tiempoBase;

//@property (strong, nonatomic) id<UIApplicationDelegate>delagete;
@property (nonatomic, strong) NSMutableDictionary* configuracionUsuario;
@property (readwrite, assign) NSInteger numeroPartidaJugadores;
@property (nonatomic, strong) NSString* tiempoPartidaJugadores;
@property (nonatomic, strong) NSString* opcionDeJuego;
@property (nonatomic, strong) NSString* tiempoEsperaListadoPartida;

-(void)obtenerTiempo;

@end
