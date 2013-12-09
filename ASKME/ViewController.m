//
//  ViewController.m
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSString *pantalla;

}

@end

@implementation ViewController

@synthesize nickNombre;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //NSString *pantalla =[[NSString alloc]init];
    
    // leemos de usuario.plist
    
    [self leerUsuarioPlist];
    
    if (![nickNombre  isEqual: @""]) {
        NSLog(@" El usuario es: %@", nickNombre);
        pantalla = @"Opciones";
        [self empezar];
    }else{
        NSLog(@" No existe usuario");
        pantalla = @"CrearUsuario";
        [self empezar];
    }


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    // Probando repositorio 1
}

#pragma mark - leerPlist

- (void) leerUsuarioPlist{
    
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSString *plistPath;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                  NSUserDomainMask, YES) objectAtIndex:0];
        plistPath = [rootPath stringByAppendingPathComponent:@"usuario.plist"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"usuario" ofType:@"plist"];
        }
        NSLog(@"PATH: %@",plistPath);
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %u", errorDesc, format);
        }
        nickNombre = [temp objectForKey:@"nombre_nick"];
    
    
}

#pragma mark - pasarPantalla

- (void) empezar{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) pasarPantalla{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:pantalla];
    [self presentViewController:cambiarViewController animated:YES completion:nil];

}

//#pragma mark - PrepareForSegue
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"irACrearUsuario"]) {
//        NickViewController *nickViewController = (NickViewController *)segue.destinationViewController;
//    }
//}

@end
