//
//  AppDelegate.h
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) id<UIApplicationDelegate>delagete;
@property (nonatomic, strong) NSMutableDictionary* configuracionUsuario;
@property (nonatomic, strong) NSString* numeroPartidaJugadores;
@property (nonatomic, strong) NSString* tiempoPartidaJugadores;
@property (nonatomic, strong) NSString* opcionDeJuego;

@end
