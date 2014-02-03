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
    jugarJugadoresLabel.hidden=TRUE;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    partidaJugadoresLabel.text = ApplicationDelegate.numeroPartidaJugadores;
    tiempoJugadoresLabel.text = [NSString stringWithFormat:@"%d",180 - [ApplicationDelegate.tiempoPartidaJugadores integerValue]];
    //tiempoJugadoresLabel.text = ApplicationDelegate.tiempoPartidaJugadores;
    self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
    
    
    if ([tiempoJugadoresLabel.text integerValue]>40) {
        
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%@.json",partidaJugadoresLabel.text]];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }
        
        esperarJugarLabel.text = @"Tiempo para finalizar la partida ...";
        tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",[tiempoJugadoresLabel.text integerValue]-40];
        jugarJugadoresLabel.hidden=FALSE;
        
        //    }else if (contador==0) {
        //        [self pasarPantalla];
    }else{
        if ([partidaJugadoresLabel.text integerValue]==19) {
            partidaJugadoresLabel.text=@"0";
            ceroUno=0;
        }else{
            ceroUno=1;
        }
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",[partidaJugadoresLabel.text integerValue]+ceroUno]];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }else{
            ApplicationDelegate.numeroPartidaJugadores = [NSString stringWithFormat:@"%d",[partidaJugadoresLabel.text integerValue]+ceroUno];
        }
        partidaJugadoresLabel.text = ApplicationDelegate.numeroPartidaJugadores;
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
    contadortiempo++;
    NSLog(@"Contador:%d TiempoEspera:%@", contadortiempo, tiempoJugadoresLabel.text);
    
    if (contadortiempo==180) {
        [self pasarPantalla];
    }else if (contadortiempo==140){
        if ([partidaJugadoresLabel.text integerValue]==19) {
            partidaJugadoresLabel.text=@"0";
            ceroUno=0;
        }else{
            ceroUno=1;
        }
        
        BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:[NSString stringWithFormat:@"http://www.askmeapp.com/jasonsHora/jason%d.json",[partidaJugadoresLabel.text integerValue]+ceroUno]];
        
        if (!guardadoJason) {
            NSLog(@"No se ha podido grabar el fichero JASON");
        }else{
            ApplicationDelegate.numeroPartidaJugadores = [NSString stringWithFormat:@"%d",[partidaJugadoresLabel.text integerValue]+ceroUno];
        }
        partidaJugadoresLabel.text = ApplicationDelegate.numeroPartidaJugadores;
        tiempoJugadoresLabel.text=@"40";
        
        jugarJugadoresLabel.hidden=TRUE;
        esperarJugarLabel.text = @"Tiempo para comenzar la partida ...";
    }
    tiempoJugadoresLabel.text=[NSString stringWithFormat:@"%d",[tiempoJugadoresLabel.text integerValue]-1];
    
}


-(void) pasarPantalla{
    [timerTiempo invalidate];
    ApplicationDelegate.tiempoPartidaJugadores = [NSString stringWithFormat:@"%d",contadortiempo];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Preguntas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    [timerTiempo invalidate];
    
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
