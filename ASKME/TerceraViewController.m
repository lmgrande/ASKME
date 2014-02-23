//
//  TerceraViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "TerceraViewController.h"
#import "TrabajarConFicherosJason.h"

@interface TerceraViewController ()
{
    NSTimer *timer;
}

    @property TrabajarConFicherosJason *trabajarFicherosJason;

@end

@implementation TerceraViewController


#pragma mark - customizando icono tab bar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *imagen = [UIImage imageNamed:@"ico-Tab-Bar-Usuarios@x2.png"];
        CGImageRef imagenRef = [imagen CGImage];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Jugadores" image:[UIImage imageWithCGImage:imagenRef scale:2.0f orientation:UIImageOrientationUp] selectedImage:nil];
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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
//    NSURL *url = [NSURL URLWithString:@"http://www.askmeapp.com/RestoEntero.php"];
//    
//    NSError *error = nil; // This so that we can access the error if something goes wrong
//    NSData *jsonData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
//    
//    NSError *error1;
//    
//    // array of dictionary
//    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error1];
//    
//    if (error1) {
//        NSLog(@"Error: %@", error1.localizedDescription);
//    } else {
        ApplicationDelegate.opcionDeJuego = @"Jugadores";
        //ApplicationDelegate.numeroPartidaJugadores = [[array objectAtIndex:0] objectForKey:@"partida"];
        //NSLog(@"partida:%@ tiempo:%@",[[array objectAtIndex:0] objectForKey:@"partida"],[[array objectAtIndex:0] objectForKey:@"tiempo"]);
        self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
        [self empezar];
    //}
    
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
    if (ApplicationDelegate.tiempoBase>0 && ApplicationDelegate.tiempoBase<5) {
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",ApplicationDelegate.numeroPartidaJugadores] andNombreFichero:@"preguntas.json"];
        if (guardadoJason==YES) {
            UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Preguntas"];
            [self presentViewController:cambiarViewController animated:YES completion:nil];
        }else{
            NSLog(@"No se ha podido grabar el fichero JASON");
        }
    }else{
        UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Jugadores"];
        [self presentViewController:cambiarViewController animated:YES completion:nil];
    }
    
}


@end
