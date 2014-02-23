//
//  ViewController.m
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    NSString *pantalla;
    NSTimer *timer;
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
        [self leerUsuarioMysql];
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

#pragma mark - leerDatos

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
        [ApplicationDelegate.configuracionUsuario setObject:nickNombre forKey:@"nombre_nick"];
    
    
    
}

- (void) leerUsuarioMysql
{
    NSURLSessionConfiguration *configuracionConexion = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuracionConexion.timeoutIntervalForRequest = 2.0;
    configuracionConexion.timeoutIntervalForResource = 2.0;
    
    NSURLSession *conexionSession = [NSURLSession sessionWithConfiguration:configuracionConexion];
    
    NSURL *url = [NSURL URLWithString:@"http://www.askmeapp.com/php_IOS/leeruser.php"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"nombre=%@", nickNombre] dataUsingEncoding:NSUTF8StringEncoding]];
    urlRequest.HTTPMethod = @"POST";
    urlRequest.HTTPBody = body;
    
    NSURLSessionDataTask *dataTask = [conexionSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSData *dataURL = data;
        NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
        
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error){
                if (HTTPResponse.statusCode == 200){
                    
                    if (![strResult  isEqual: nickNombre]){
                        if ([strResult isEqual:@""]){
                            NSLog(@"No puede conectarse a la Base de Datos.");
                            [self verAlertaNoConecta];
                        }else{
                            NSLog(@"No existe en la Base de Datos del Servidor");
                            pantalla = @"CrearUsuario";
                            [self empezar];
                        }
                    }else{
                        pantalla = @"Opciones";
                        [self empezar];
                    }
                }else{
                    [ApplicationDelegate obtenerTiempo];
                }
            }else{
                [ApplicationDelegate obtenerTiempo];
            }
        });
        
    }];
    
    [dataTask resume];
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

#pragma mark - Alertas

- (void) verAlertaNoConecta
{
    dispatch_async(dispatch_get_main_queue(), ^{
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Conexión a Usuarios"
                                                     message:@"No puede conectarse."
                                                    delegate:self
                                           cancelButtonTitle:@"Volver a Intentar"
                                           otherButtonTitles:nil, nil];
    
    [alerta setTag:0];
    [alerta show];
    });
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        if (buttonIndex == 0) {
            [self leerUsuarioMysql];
        }
    }
}

@end
