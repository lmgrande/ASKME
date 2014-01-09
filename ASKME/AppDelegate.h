//
//  AppDelegate.h
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) id<UIApplicationDelegate>delagete;
@property (nonatomic, strong) NSMutableDictionary* configuracionUsuario;

@end
