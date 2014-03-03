//
//  EstadisticaTodoViewController.m
//  ASKME
//
//  Created by LUISMI on 03/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "EstadisticaTodoViewController.h"
#import "TrabajarConFicherosPlist.h"



@interface EstadisticaTodoViewController ()
{
    NSTimer *timerEsperaListado;
}

    @property TrabajarConFicherosPlist *trabajarFicherosPlist;
    @property (weak, nonatomic) IBOutlet UIImageView *barraTodosUIImageView;
    @property (weak, nonatomic) IBOutlet UIView *barrasEstadisticasTodoUIView;


@end

@implementation EstadisticaTodoViewController

@synthesize nickLabel,numeroPartidaLabel,puntosMaximoPartidaLabel,preguntasMaximoPartidaLabel,preguntasContestadasLabel, preguntasAcertadasLabel,preguntasNoAcertadasLabel,preguntasFalladasLabel,preguntasPasadasLabel,puntosPartidaArteLiteraturaLabel,puntosPartidaCienciasLabel,puntosPartidaDeportesLabel,puntosPartidaGeografiaLabel,puntosPartidaHistoriaLabel,puntosPartidaOcioLabel,puntosPartidaOtrosLabel,puntosPartidaTODOLabel,porcentajePartidaArteLiteraturaLabel,porcentajePartidaCienciasLabel,porcentajePartidaDeportesLabel,porcentajePartidaGeografiaLabel,porcentajePartidaHistoriaLabel,porcentajePartidaOcioLabel,porcentajePartidaOtrosLabel,porcentajePartidaTODOLabel,XdeYenArteLiteratura,XdeYenCiencias,XdeYenDeportes,XdeYenGeografia,XdeYenHistoria,XdeYenOcio,XdeYenOtros,XdeYenTODO, textoEsperarLabel, numerosEsperarLabel, barraTodosUIImageView, barrasEstadisticasTodoUIView;

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
    nickLabel.text = [ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"];
    self.trabajarFicherosPlist = [[TrabajarConFicherosPlist alloc]init];
    if ([ApplicationDelegate.opcionDeJuego  isEqual: @"Jugador"]) {
        textoEsperarLabel.hidden=TRUE;
        numerosEsperarLabel.hidden=TRUE;
    }else if ([ApplicationDelegate.opcionDeJuego  isEqual: @"Jugadores"]){
        numerosEsperarLabel.text=[NSString stringWithFormat:@"%d",180-(ApplicationDelegate.tiempoBase+20)];
        textoEsperarLabel.hidden=FALSE;
        numerosEsperarLabel.hidden=FALSE;
        [self empezarContadorEsperaListado];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self leerDatosPartidas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)estadisticaPartidaActualBoton:(id)sender
{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"pantallaEstadisticas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)estadisticaTodasLasPartidasBoton:(id)sender
{
}

#pragma mark - leerDatos

- (void) leerDatosPartidas{
    
    NSDictionary *temp = [[NSDictionary alloc] initWithDictionary:[self.trabajarFicherosPlist leerDatosPlist:@"datosPartidas"]];
    
    preguntasContestadasLabel.text=[temp objectForKey:@"total-preguntas-contestadas"];
    preguntasAcertadasLabel.text=[temp objectForKey:@"total-preguntas-acertadas"];
    NSString *todasLasPasadas=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-contestadas"] integerValue]-([[temp objectForKey:@"total-preguntas-acertadas"] integerValue]+[[temp objectForKey:@"total-preguntas-falladas"] integerValue])];
    preguntasNoAcertadasLabel.text=[NSString stringWithFormat:@"%d",[todasLasPasadas integerValue]+[[temp objectForKey:@"total-preguntas-falladas"] integerValue]];
    preguntasFalladasLabel.text=[temp objectForKey:@"total-preguntas-falladas"];
    preguntasPasadasLabel.text=todasLasPasadas;
    
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
        [self.barrasEstadisticasTodoUIView addSubview:barraArteLiteratura];
        porcentajePartidaArteLiteraturaLabel.text=[NSString stringWithFormat:@"%d",porcentajeArteLiteratura];
    
        [self layoutConstraintBarrasTodo:barraArteLiteratura andPorcentajeBarra:porcentajeArteLiteratura andDuracion:0.5 andConstanteY:-230.0];
    }
    
    if ([[temp objectForKey:@"ciencias-contestadas"] integerValue]!=0) {
        NSInteger porcentajeCiencias = ([[temp objectForKey:@"ciencias-acertadas"] integerValue]*100)/[[temp objectForKey:@"ciencias-contestadas"] integerValue];
        UIImageView *barraCiencias = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeCiencias/100)-140, 267, 140, 23)];
        UIImage *imgbarraCiencias = [UIImage imageNamed:@"barra-CIENCIAS"];
        barraCiencias.image = imgbarraCiencias;
        [self.barrasEstadisticasTodoUIView addSubview:barraCiencias];
        porcentajePartidaCienciasLabel.text=[NSString stringWithFormat:@"%d",porcentajeCiencias];
        
        [self layoutConstraintBarrasTodo:barraCiencias andPorcentajeBarra:porcentajeCiencias andDuracion:0.6 andConstanteY:-200.0];
    }
    
    if ([[temp objectForKey:@"deportes-contestadas"] integerValue]!=0) {
        NSInteger porcentajeDeportes = ([[temp objectForKey:@"deportes-acertadas"] integerValue]*100)/[[temp objectForKey:@"deportes-contestadas"] integerValue];
        UIImageView *barraDeportes = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeDeportes/100)-140, 297, 140, 23)];
        UIImage *imgbarraDeportes = [UIImage imageNamed:@"barra-DEPORTES"];
        barraDeportes.image = imgbarraDeportes;
        [self.barrasEstadisticasTodoUIView addSubview:barraDeportes];
        porcentajePartidaDeportesLabel.text=[NSString stringWithFormat:@"%d",porcentajeDeportes];
        
        [self layoutConstraintBarrasTodo:barraDeportes andPorcentajeBarra:porcentajeDeportes andDuracion:0.7 andConstanteY:-170.0];
    }
    
    if ([[temp objectForKey:@"geografia-contestadas"] integerValue]!=0) {
        NSInteger porcentajeGeografia = ([[temp objectForKey:@"geografia-acertadas"] integerValue]*100)/[[temp objectForKey:@"geografia-contestadas"] integerValue];
        UIImageView *barraGeografia = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeGeografia/100)-140, 327, 140, 23)];
        UIImage *imgbarraGeografia = [UIImage imageNamed:@"barra-GEOGRAFIA"];
        barraGeografia.image = imgbarraGeografia;
        [self.barrasEstadisticasTodoUIView addSubview:barraGeografia];
        porcentajePartidaGeografiaLabel.text=[NSString stringWithFormat:@"%d",porcentajeGeografia];
        
        [self layoutConstraintBarrasTodo:barraGeografia andPorcentajeBarra:porcentajeGeografia andDuracion:0.8 andConstanteY:-140.0];
    }
    
    if ([[temp objectForKey:@"historia-contestadas"] integerValue]!=0) {
        NSInteger porcentajeHistoria = ([[temp objectForKey:@"historia-acertadas"] integerValue]*100)/[[temp objectForKey:@"historia-contestadas"] integerValue];
        UIImageView *barraHistoria = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeHistoria/100)-140, 357, 140, 23)];
        UIImage *imgbarraHistoria = [UIImage imageNamed:@"barra-HISTORIA"];
        barraHistoria.image = imgbarraHistoria;
        [self.barrasEstadisticasTodoUIView addSubview:barraHistoria];
        porcentajePartidaHistoriaLabel.text=[NSString stringWithFormat:@"%d",porcentajeHistoria];
        
        [self layoutConstraintBarrasTodo:barraHistoria andPorcentajeBarra:porcentajeHistoria andDuracion:0.9 andConstanteY:-110.0];
    }
    
    if ([[temp objectForKey:@"ocio-contestadas"] integerValue]!=0) {
        NSInteger porcentajeOcio = ([[temp objectForKey:@"ocio-acertadas"] integerValue]*100)/[[temp objectForKey:@"ocio-contestadas"] integerValue];
        UIImageView *barraOcio = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOcio/100)-140, 387, 140, 23)];
        UIImage *imgbarraOcio = [UIImage imageNamed:@"barra-OCIO"];
        barraOcio.image = imgbarraOcio;
        [self.barrasEstadisticasTodoUIView addSubview:barraOcio];
        porcentajePartidaOcioLabel.text=[NSString stringWithFormat:@"%d",porcentajeOcio];
        
        [self layoutConstraintBarrasTodo:barraOcio andPorcentajeBarra:porcentajeOcio andDuracion:1.0 andConstanteY:-80.0];
    }
    
    if ([[temp objectForKey:@"otros-contestadas"] integerValue]!=0) {
        NSInteger porcentajeOtros = ([[temp objectForKey:@"otros-acertadas"] integerValue]*100)/[[temp objectForKey:@"otros-contestadas"] integerValue];
        UIImageView *barraOtros = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOtros/100)-140, 417, 140, 23)];
        UIImage *imgbarraOtros = [UIImage imageNamed:@"barra-OTROS"];
        barraOtros.image = imgbarraOtros;
        [self.barrasEstadisticasTodoUIView addSubview:barraOtros];
        porcentajePartidaOtrosLabel.text=[NSString stringWithFormat:@"%d",porcentajeOtros];
        
        [self layoutConstraintBarrasTodo:barraOtros andPorcentajeBarra:porcentajeOtros andDuracion:1.1 andConstanteY:-50.0];
    }
    
    if ([[temp objectForKey:@"total-preguntas-contestadas"] integerValue]!=0) {
        NSInteger porcentajeTODO = ([[temp objectForKey:@"total-preguntas-acertadas"] integerValue]*100)/[[temp objectForKey:@"total-preguntas-contestadas"] integerValue];
        UIImageView *barraTODO = [[UIImageView alloc] initWithFrame:CGRectMake(-140, 447, 140, 23)];
        UIImage *imgbarraTODO = [UIImage imageNamed:@"barra-TODOS"];
        barraTODO.image = imgbarraTODO;
        barraTodosUIImageView=barraTODO;
        [self.barrasEstadisticasTodoUIView addSubview:barraTODO];
        porcentajePartidaTODOLabel.text=[NSString stringWithFormat:@"%d",porcentajeTODO];
        
        [self layoutConstraintBarrasTodo:barraTODO andPorcentajeBarra:porcentajeTODO andDuracion:1.2 andConstanteY:-20.0];
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
    if ([numerosEsperarLabel.text integerValue]>0) {
        numerosEsperarLabel.text=[NSString stringWithFormat:@"%d",180-(ApplicationDelegate.tiempoBase+20)];
        NSLog(@"timerEsperaListado: %@", numerosEsperarLabel.text);
    }else{
        [timerEsperaListado invalidate];
        UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
        UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Listado"];
        [self presentViewController:cambiarViewController animated:YES completion:nil];
    }
    
}

-(void) layoutConstraintBarrasTodo:(UIImageView*)barra andPorcentajeBarra:(NSInteger)porcentaje andDuracion:(float)duracion andConstanteY:(float)constanteY
{
    barra.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:barra attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.barrasEstadisticasTodoUIView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:(140*porcentaje/100)-140];
    [self.barrasEstadisticasTodoUIView addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:barra attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.barrasEstadisticasTodoUIView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:constanteY];
    [self.barrasEstadisticasTodoUIView addConstraint:constraint];
    
    barra.center=CGPointMake(-140, self.barrasEstadisticasTodoUIView.frame.size.height+constraint.constant);
    CGPoint posicionTotal = CGPointMake((140*porcentaje/100)-140, barra.frame.origin.y);
    UIViewAnimationOptions option = UIViewAnimationOptionCurveEaseInOut;
    barra.transform=CGAffineTransformMakeScale(0.5, 0.5);
    
    [UIView animateWithDuration:duracion delay:0 options:option animations:^{
        barra.center = posicionTotal;
        [barra setAlpha:0.5];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:0 options:option animations:^{
            [barra setAlpha:1];
        } completion:nil];
    }];
}

@end
