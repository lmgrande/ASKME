//
//  PreguntasJugadoresViewController.m
//  ASKME
//
//  Created by LUISMI on 20/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "PreguntasJugadoresViewController.h"
#import "TrabajarConFicherosJason.h"

@interface PreguntasJugadoresViewController ()
{
    NSTimer *timerTiempo;
    NSInteger contadortiempo;
    NSInteger ceroUno;
}

@property TrabajarConFicherosJason *trabajarFicherosJason;

@end

@implementation PreguntasJugadoresViewController

@synthesize partidaJugadoresLabel,tiempoJugadoresLabel, esperarJugarLabel, jugarJugadoresLabel;

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
    timerTiempo=nil;
    contadortiempo=[ApplicationDelegate.tiempoPartidaJugadores integerValue];
    partidaJugadoresLabel.text=@"";
    tiempoJugadoresLabel.text=@"";
    esperarJugarLabel.text = @"";

}

-(void)viewDidAppear:(BOOL)animated
{
     jugarJugadoresLabel.hidden=TRUE;
    partidaJugadoresLabel.text = [NSString stringWithFormat:@"%d",ApplicationDelegate.numeroPartidaJugadores];
    //tiempoJugadoresLabel.text = [NSString stringWithFormat:@"%d",180 - ApplicationDelegate.tiempoBase];
    //tiempoJugadoresLabel.text = ApplicationDelegate.tiempoPartidaJugadores;
    self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
    NSLog(@"tiempoJugadoresLabel: %@",tiempoJugadoresLabel.text);
//    if (ApplicationDelegate.tiempoBase<5) {
//        [self pasarPantalla];
//    }else
    if (ApplicationDelegate.tiempoBase>=5 && ApplicationDelegate.tiempoBase<140) {
        
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",ApplicationDelegate.numeroPartidaJugadores] andNombreFichero:@"preguntas.json"];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }
        
        esperarJugarLabel.text = @"Tiempo para finalizar la partida ...";
        tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",140 - ApplicationDelegate.tiempoBase];
        jugarJugadoresLabel.hidden=FALSE;
        
        //    }else if (contador==0) {
        //        [self pasarPantalla];
    }else{
        if ([partidaJugadoresLabel.text integerValue]==19) {
            partidaJugadoresLabel.text=@"0";
            ceroUno=0;
        }else{
            ceroUno=1;
            partidaJugadoresLabel.text=[NSString stringWithFormat:@"%d",ApplicationDelegate.numeroPartidaJugadores+ceroUno];
        }
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",ApplicationDelegate.numeroPartidaJugadores+ceroUno] andNombreFichero:@"preguntas.json"];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }
        jugarJugadoresLabel.hidden=TRUE;
        esperarJugarLabel.text = @"Tiempo para comenzar la partida ...";
        
    }
    
    [self empezarContadorTiempo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) empezarContadorTiempo{
    
    
    
    timerTiempo = [NSTimer timerWithTimeInterval:1.0
                                          target:self
                                        selector:@selector(counterDown)
                                        userInfo:nil
                                         repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timerTiempo forMode:NSDefaultRunLoopMode];
    
    
}

-(void) counterDown{
    //contadortiempo++;
    //NSLog(@"Contador:%d TiempoEspera:%@", contadortiempo, tiempoJugadoresLabel.text);
    
    if (ApplicationDelegate.tiempoBase==180) {
        [self pasarPantalla];
    }else if (ApplicationDelegate.tiempoBase>140){
        tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",180 - ApplicationDelegate.tiempoBase];
    }else if (ApplicationDelegate.tiempoBase==140){
        tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",40];
        if (ApplicationDelegate.numeroPartidaJugadores==19) {
            partidaJugadoresLabel.text=@"0";
            ceroUno=0;
        }else{
            ceroUno=1;
            partidaJugadoresLabel.text=[NSString stringWithFormat:@"%d",ApplicationDelegate.numeroPartidaJugadores+ceroUno];
        }
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",ApplicationDelegate.numeroPartidaJugadores+ceroUno] andNombreFichero:@"preguntas.json"];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }
        //tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",180 - ApplicationDelegate.tiempoBase];
        
        jugarJugadoresLabel.hidden=TRUE;
        esperarJugarLabel.text = @"Tiempo para comenzar la partida ...";
    }else if (ApplicationDelegate.tiempoBase<140){
        tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",140 - ApplicationDelegate.tiempoBase];
    }
    
}


-(void) pasarPantalla{
    [timerTiempo invalidate];
    //ApplicationDelegate.tiempoPartidaJugadores = [NSString stringWithFormat:@"%d",contadortiempo];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Preguntas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    [timerTiempo invalidate];
    
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)jugarJugadoresBoton:(id)sender
{
    [timerTiempo invalidate];
    [self pasarPantalla];
}

@end
