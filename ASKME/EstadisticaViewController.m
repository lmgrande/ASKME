//
//  EstadisticaViewController.m
//  ASKME
//
//  Created by LUISMI on 24/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "EstadisticaViewController.h"
#import "TrabajarConFicherosPlist.h"
#import "GestionarDatosYPuntosPartida.h"


@interface EstadisticaViewController ()
{
    NSTimer *timerEsperaListado;
}

    @property TrabajarConFicherosPlist *trabajarFicherosPlist;
    @property GestionarDatosYPuntosPartida *gestionarDatosYPuntosPartida;
    @property (weak, nonatomic) IBOutlet UIImageView *barraTodosUIImageView;

@end

@implementation EstadisticaViewController

    @synthesize nickLabel,numeroPartidaLabel,puntosMaximoPartidaLabel,preguntasMaximoPartidaLabel,preguntasContestadasLabel, preguntasAcertadasLabel,preguntasNoAcertadasLabel,preguntasFalladasLabel,preguntasPasadasLabel,puntosPartidaArteLiteraturaLabel,puntosPartidaCienciasLabel,puntosPartidaDeportesLabel,puntosPartidaGeografiaLabel,puntosPartidaHistoriaLabel,puntosPartidaOcioLabel,puntosPartidaOtrosLabel,puntosPartidaTODOLabel,porcentajePartidaArteLiteraturaLabel,porcentajePartidaCienciasLabel,porcentajePartidaDeportesLabel,porcentajePartidaGeografiaLabel,porcentajePartidaHistoriaLabel,porcentajePartidaOcioLabel,porcentajePartidaOtrosLabel,porcentajePartidaTODOLabel,XdeYenArteLiteratura,XdeYenCiencias,XdeYenDeportes,XdeYenGeografia,XdeYenHistoria,XdeYenOcio,XdeYenOtros,XdeYenTODO, textoEsperarLabel, numerosEsperarLabel, barraTodosUIImageView;

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
    
//    ViewController *nickNombreViewController = [[ViewController alloc]init];
//    [nickNombreViewController leerUsuarioPlist];
//    
//    NSString *result=[NSString stringWithFormat:@"%@", nickNombreViewController.nickNombre];
//    nickLabel.text = result;
    nickLabel.text = [ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"];
    self.trabajarFicherosPlist = [[TrabajarConFicherosPlist alloc]init];
    self.gestionarDatosYPuntosPartida = [[GestionarDatosYPuntosPartida alloc]init];
    
    
    if ([ApplicationDelegate.opcionDeJuego  isEqual: @"Jugador"]) {
        textoEsperarLabel.hidden=TRUE;
        numerosEsperarLabel.hidden=TRUE;
    }else if ([ApplicationDelegate.opcionDeJuego  isEqual: @"Jugadores"]){
        numerosEsperarLabel.text=[NSString stringWithFormat:@"%d",180-(ApplicationDelegate.tiempoBase+20)];
        textoEsperarLabel.hidden=FALSE;
        numerosEsperarLabel.hidden=FALSE;
        [self empezarContadorEsperaListado];
        //if ([numerosEsperarLabel.text integerValue]>15) {
            [self.gestionarDatosYPuntosPartida enviarPuntos:preguntasMaximoPartidaLabel.text :puntosMaximoPartidaLabel.text :preguntasContestadasLabel.text :preguntasAcertadasLabel.text :preguntasFalladasLabel.text :preguntasPasadasLabel.text :puntosPartidaTODOLabel.text];
        //}
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self leerDatosPartida];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    //ApplicationDelegate.tiempoEsperaListadoPartida=@"16";
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)estadisticaPartidaActualBoton:(id)sender {
}

- (IBAction)estadisticaTodasLasPartidasBoton:(id)sender
{
    //ApplicationDelegate.tiempoEsperaListadoPartida=numerosEsperarLabel.text;
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"pantallaTodoEstadisticas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

#pragma mark - leerDatos

- (void) leerDatosPartida{
    
    NSDictionary *temp = [[NSDictionary alloc] initWithDictionary:[self.trabajarFicherosPlist leerDatosPlist:@"datosPartida"]];
    
    puntosMaximoPartidaLabel.text=[temp objectForKey:@"puntos-maximos-partida"];
    preguntasMaximoPartidaLabel.text=[temp objectForKey:@"total-preguntas-partida"];
    
    preguntasContestadasLabel.text=[temp objectForKey:@"total-preguntas-contestadas"];
    preguntasAcertadasLabel.text=[temp objectForKey:@"total-preguntas-acertadas"];
    NSString *todasLasNoAcertadas=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-falladas"] integerValue]+[[temp objectForKey:@"total-preguntas-pasadas"] integerValue]];
    preguntasNoAcertadasLabel.text=todasLasNoAcertadas;
    preguntasFalladasLabel.text=[temp objectForKey:@"total-preguntas-falladas"];
    preguntasPasadasLabel.text=[temp objectForKey:@"total-preguntas-pasadas"];
    
    puntosPartidaArteLiteraturaLabel.text=[temp objectForKey:@"arte-literatura-puntos"];
    puntosPartidaCienciasLabel.text=[temp objectForKey:@"ciencias-puntos"];
    puntosPartidaDeportesLabel.text=[temp objectForKey:@"deportes-puntos"];
    puntosPartidaGeografiaLabel.text=[temp objectForKey:@"geografia-puntos"];
    puntosPartidaHistoriaLabel.text=[temp objectForKey:@"historia-puntos"];
    puntosPartidaOcioLabel.text=[temp objectForKey:@"ocio-puntos"];
    puntosPartidaOtrosLabel.text=[temp objectForKey:@"otros-puntos"];
    puntosPartidaTODOLabel.text=[temp objectForKey:@"puntos-totales-conseguidos"];
    
    if ([[temp objectForKey:@"arte-literatura-contestadas"] integerValue]!=0) {
        NSInteger porcentajeArteLiteratura = ([[temp objectForKey:@"arte-literatura-acertadas"] integerValue]*100)/[[temp objectForKey:@"arte-literatura-contestadas"] integerValue];
        UIImageView *barraArteLiteratura = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeArteLiteratura/100)-140, 237, 140, 23)];
        UIImage *imgbarraArteLiteratura = [UIImage imageNamed:@"barra-ARTELITERATURA.png"];
        barraArteLiteratura.image = imgbarraArteLiteratura;
        [self.view addSubview:barraArteLiteratura];
        [self.view setNeedsDisplay];
        porcentajePartidaArteLiteraturaLabel.text=[NSString stringWithFormat:@"%d",porcentajeArteLiteratura];
    }
    
    if ([[temp objectForKey:@"ciencias-contestadas"] integerValue]!=0) {
        NSInteger porcentajeCiencias = ([[temp objectForKey:@"ciencias-acertadas"] integerValue]*100)/[[temp objectForKey:@"ciencias-contestadas"] integerValue];
        UIImageView *barraCiencias = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeCiencias/100)-140, 267, 140, 23)];
        UIImage *imgbarraCiencias = [UIImage imageNamed:@"barra-CIENCIAS"];
        barraCiencias.image = imgbarraCiencias;
        [self.view addSubview:barraCiencias];
        [self.view setNeedsDisplay];
        porcentajePartidaCienciasLabel.text=[NSString stringWithFormat:@"%d",porcentajeCiencias];
    }
    
    if ([[temp objectForKey:@"deportes-contestadas"] integerValue]!=0) {
        NSInteger porcentajeDeportes = ([[temp objectForKey:@"deportes-acertadas"] integerValue]*100)/[[temp objectForKey:@"deportes-contestadas"] integerValue];
        UIImageView *barraDeportes = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeDeportes/100)-140, 297, 140, 23)];
        UIImage *imgbarraDeportes = [UIImage imageNamed:@"barra-DEPORTES"];
        barraDeportes.image = imgbarraDeportes;
        [self.view addSubview:barraDeportes];
        [self.view setNeedsDisplay];
        porcentajePartidaDeportesLabel.text=[NSString stringWithFormat:@"%d",porcentajeDeportes];
    }
    
    if ([[temp objectForKey:@"geografia-contestadas"] integerValue]!=0) {
        NSInteger porcentajeGeografia = ([[temp objectForKey:@"geografia-acertadas"] integerValue]*100)/[[temp objectForKey:@"geografia-contestadas"] integerValue];
        UIImageView *barraGeografia = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeGeografia/100)-140, 327, 140, 23)];
        UIImage *imgbarraGeografia = [UIImage imageNamed:@"barra-GEOGRAFIA"];
        barraGeografia.image = imgbarraGeografia;
        [self.view addSubview:barraGeografia];
        [self.view setNeedsDisplay];
        porcentajePartidaGeografiaLabel.text=[NSString stringWithFormat:@"%d",porcentajeGeografia];
    }
    
    if ([[temp objectForKey:@"historia-contestadas"] integerValue]!=0) {
        NSInteger porcentajeHistoria = ([[temp objectForKey:@"historia-acertadas"] integerValue]*100)/[[temp objectForKey:@"historia-contestadas"] integerValue];
        UIImageView *barraHistoria = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeHistoria/100)-140, 357, 140, 23)];
        UIImage *imgbarraHistoria = [UIImage imageNamed:@"barra-HISTORIA"];
        barraHistoria.image = imgbarraHistoria;
        [self.view addSubview:barraHistoria];
        [self.view setNeedsDisplay];
        porcentajePartidaHistoriaLabel.text=[NSString stringWithFormat:@"%d",porcentajeHistoria];
    }
    
    if ([[temp objectForKey:@"ocio-contestadas"] integerValue]!=0) {
        NSInteger porcentajeOcio = ([[temp objectForKey:@"ocio-acertadas"] integerValue]*100)/[[temp objectForKey:@"ocio-contestadas"] integerValue];
        UIImageView *barraOcio = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOcio/100)-140, 387, 140, 23)];
        UIImage *imgbarraOcio = [UIImage imageNamed:@"barra-OCIO"];
        barraOcio.image = imgbarraOcio;
        [self.view addSubview:barraOcio];
        [self.view setNeedsDisplay];
        porcentajePartidaOcioLabel.text=[NSString stringWithFormat:@"%d",porcentajeOcio];
    }
    
    if ([[temp objectForKey:@"otros-contestadas"] integerValue]!=0) {
        NSInteger porcentajeOtros = ([[temp objectForKey:@"otros-acertadas"] integerValue]*100)/[[temp objectForKey:@"otros-contestadas"] integerValue];
        UIImageView *barraOtros = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOtros/100)-140, 417, 140, 23)];
        UIImage *imgbarraOtros = [UIImage imageNamed:@"barra-OTROS"];
        barraOtros.image = imgbarraOtros;
        [self.view addSubview:barraOtros];
        [self.view setNeedsDisplay];
        porcentajePartidaOtrosLabel.text=[NSString stringWithFormat:@"%d",porcentajeOtros];
    }
    
//    if ([[temp objectForKey:@"total-preguntas-contestadas"] integerValue]!=0) {
//        NSInteger porcentajeTODO = ([[temp objectForKey:@"total-preguntas-acertadas"] integerValue]*100)/[[temp objectForKey:@"total-preguntas-contestadas"] integerValue];
//        UIImageView *barraTODO = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeTODO/100)-140, 447, 140, 23)];
//        UIImage *imgbarraTODO = [UIImage imageNamed:@"barra-TODOS"];
//        barraTODO.image = imgbarraTODO;
//        [self.view addSubview:barraTODO];
//        [self.view setNeedsDisplay];
//        porcentajePartidaTODOLabel.text=[NSString stringWithFormat:@"%d",porcentajeTODO];
//    }
    
    if ([[temp objectForKey:@"total-preguntas-contestadas"] integerValue]!=0) {
        NSInteger porcentajeTODO = ([[temp objectForKey:@"total-preguntas-acertadas"] integerValue]*100)/[[temp objectForKey:@"total-preguntas-contestadas"] integerValue];
        UIImageView *barraTODO = [[UIImageView alloc] initWithFrame:CGRectMake(-140, 447, 140, 23)];
        UIImage *imgbarraTODO = [UIImage imageNamed:@"barra-TODOS"];
        barraTODO.image = imgbarraTODO;
        barraTodosUIImageView=barraTODO;
        [self.view addSubview:barraTODO];
        //[self.view setNeedsDisplay];
        
        CGPoint posicionTotal = CGPointMake((140*porcentajeTODO/100)-70, 458.5);
        UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
        
        [UIView animateWithDuration:1.0 delay:0 options:option animations:^{
            
            [self.barraTodosUIImageView setAlpha:0.5];
            self.barraTodosUIImageView.center = posicionTotal;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:1.0 animations:^{
                
                [self.barraTodosUIImageView setAlpha:1];
                
                
            } completion:nil];
            
        }];
        
        
        porcentajePartidaTODOLabel.text=[NSString stringWithFormat:@"%d",porcentajeTODO];
    }
    
    XdeYenArteLiteratura.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"arte-literatura-acertadas"],[temp objectForKey:@"arte-literatura-contestadas"]];
    XdeYenCiencias.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"ciencias-acertadas"],[temp objectForKey:@"ciencias-contestadas"]];
    XdeYenDeportes.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"deportes-acertadas"],[temp objectForKey:@"deportes-contestadas"]];
    XdeYenGeografia.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"geografia-acertadas"],[temp objectForKey:@"geografia-contestadas"]];
    XdeYenHistoria.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"historia-acertadas"],[temp objectForKey:@"historia-contestadas"]];
    XdeYenOcio.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"ocio-acertadas"],[temp objectForKey:@"ocio-contestadas"]];
    XdeYenOtros.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"otros-acertadas"],[temp objectForKey:@"otros-contestadas"]];
    XdeYenTODO.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"total-preguntas-acertadas"],[temp objectForKey:@"total-preguntas-contestadas"]];
    
}

- (void) empezarContadorEsperaListado
{
    timerEsperaListado = [NSTimer scheduledTimerWithTimeInterval:1         // El timer se ejcuta cada segundo
                                                    target:self        // Se ejecuta este timer en este view
                                                  selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                                  userInfo:nil
                                                   repeats:YES];
}

-(void) pasarPantalla
{
    if ([numerosEsperarLabel.text integerValue]!=0) {
        numerosEsperarLabel.text=[NSString stringWithFormat:@"%d",180-(ApplicationDelegate.tiempoBase+20)];
    }else{
        [timerEsperaListado invalidate];
        //ApplicationDelegate.tiempoEsperaListadoPartida=@"16";
        UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
        UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Listado"];
        [self presentViewController:cambiarViewController animated:YES completion:nil];
    }
    
}


@end
