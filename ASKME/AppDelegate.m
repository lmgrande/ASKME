//
//  AppDelegate.m
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate
{
    NSTimer *notificationTimer;
}


@synthesize tiempoBase,numeroPartidaJugadores;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //IMPORTANTE: para ocultar la barra de arriba ahí que añadir en el plist "info" la propiedad "View controller-based status bar appearance" puesta a NO y tener puesta la propiedad "Status bar is initially hidden" a YES
    application.statusBarHidden = YES;

    [self obtenerTiempo];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    
    imageView.tag = 101;    // Give some decent tagvalue or keep a reference of imageView in self
    //    imageView.backgroundColor = [UIColor redColor];
    [imageView setImage:[UIImage imageNamed:@"Default-480h@2x.png"]];   // assuming Default.png is your splash image's name
    
    [UIApplication.sharedApplication.keyWindow.subviews.lastObject addSubview:imageView];
    
    if(notificationTimer)
    {
        [notificationTimer invalidate];
        //notificationTimer = nil;
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    UIImageView *imageView = (UIImageView *)[UIApplication.sharedApplication.keyWindow.subviews.lastObject viewWithTag:101];   // search by the same tag value
    [imageView removeFromSuperview];
    
    [self obtenerTiempo];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ViewController *cambiarViewController = (ViewController*)[storyboard instantiateViewControllerWithIdentifier:@"Inicio"];
    self.window.rootViewController = cambiarViewController;
    //[self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)checkForNotifications
{
    if (tiempoBase==180) {
        tiempoBase=0;
        if (numeroPartidaJugadores==19) {
            numeroPartidaJugadores=0;
        } else {
            numeroPartidaJugadores++;
        }
    }
    tiempoBase++;
    NSLog(@"TIEMPOBASE: %ld PARTIDA: %ld",(long)tiempoBase,(long)numeroPartidaJugadores);
}

- (void) verAlertaNoConecta
{
    UIAlertView *alertaConexionServer = [[UIAlertView alloc] initWithTitle:@"Conexión"
                                                     message:@"No puede conectarse."
                                                    delegate:self
                                           cancelButtonTitle:@"Volver a Intentar"
                                           otherButtonTitles:nil, nil];
    
    [alertaConexionServer setTag:0];
    [alertaConexionServer show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            [self obtenerTiempo];
        }
    }
}

-(void)obtenerTiempo
{
    NSURL *url = [NSURL URLWithString:@"http://www.askmeapp.com/RestoEntero.php"];
    
    NSError *error; // This so that we can access the error if something goes wrong
    NSData *jsonData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
        [self verAlertaNoConecta];
    }else{
    
        NSError *error1;
    
        // array of dictionary
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error1];
    
        if (error1) {
            NSLog(@"Error: %@", error1.localizedDescription);
        } else {
            numeroPartidaJugadores =[[[array objectAtIndex:0] objectForKey:@"partida"]integerValue];
            tiempoBase = [[[array objectAtIndex:0] objectForKey:@"tiempo"]integerValue];
        }
    }
    notificationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(checkForNotifications) userInfo:nil repeats:YES];
    
    self.configuracionUsuario = [[NSMutableDictionary alloc]init];
    self.opcionDeJuego = [[NSString alloc]init];
}


@end
