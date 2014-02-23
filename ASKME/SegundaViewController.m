//
//  SegundaViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "SegundaViewController.h"
#import "TrabajarConFicherosJason.h"

@interface SegundaViewController ()
{
    NSTimer *timer;
}

@property TrabajarConFicherosJason *trabajarFicherosJason;

@end


@implementation SegundaViewController

#pragma mark - customizando icono tab bar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *imagen = [UIImage imageNamed:@"ico-Tab-Bar-Usuario@x2.png"];
        CGImageRef imagenRef = [imagen CGImage];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Jugador" image:[UIImage imageWithCGImage:imagenRef scale:2.0f orientation:UIImageOrientationUp] selectedImage:nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
    
    BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:@"http://www.askmeapp.com/php_IOS/leerPreguntasJugador.php" andNombreFichero:@"preguntas.json"];
    
    if (guardadoJason) {
        ApplicationDelegate.opcionDeJuego = @"Jugador";
        [self empezar];
    }else{
        NSLog(@"No se ha podido grabar el fichero JASON");
    }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Preguntas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}


@end
