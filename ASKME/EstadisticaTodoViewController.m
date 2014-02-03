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

    @property TrabajarConFicherosPlist *trabajarFicherosPlist;

@end

@implementation EstadisticaTodoViewController

@synthesize nickLabel,numeroPartidaLabel,puntosMaximoPartidaLabel,preguntasMaximoPartidaLabel,preguntasContestadasLabel, preguntasAcertadasLabel,preguntasNoAcertadasLabel,preguntasFalladasLabel,preguntasPasadasLabel,puntosPartidaArteLiteraturaLabel,puntosPartidaCienciasLabel,puntosPartidaDeportesLabel,puntosPartidaGeografiaLabel,puntosPartidaHistoriaLabel,puntosPartidaOcioLabel,puntosPartidaOtrosLabel,puntosPartidaTODOLabel,porcentajePartidaArteLiteraturaLabel,porcentajePartidaCienciasLabel,porcentajePartidaDeportesLabel,porcentajePartidaGeografiaLabel,porcentajePartidaHistoriaLabel,porcentajePartidaOcioLabel,porcentajePartidaOtrosLabel,porcentajePartidaTODOLabel,XdeYenArteLiteratura,XdeYenCiencias,XdeYenDeportes,XdeYenGeografia,XdeYenHistoria,XdeYenOcio,XdeYenOtros,XdeYenTODO, textoEsperarLabel, numerosEsperarLabel;

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
        textoEsperarLabel.hidden=FALSE;
        numerosEsperarLabel.hidden=FALSE;
    }
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
    
    NSInteger porcentajeArteLiteratura = ([[temp objectForKey:@"arte-literatura-acertadas"] integerValue]*100)/[[temp objectForKey:@"arte-literatura-contestadas"] integerValue];
    UIImageView *barraArteLiteratura = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeArteLiteratura/100)-140, 237, 140, 23)];
    UIImage *imgbarraArteLiteratura = [UIImage imageNamed:@"barra-ARTELITERATURA.png"];
    barraArteLiteratura.image = imgbarraArteLiteratura;
    [self.view addSubview:barraArteLiteratura];
    [self.view setNeedsDisplay];
    porcentajePartidaArteLiteraturaLabel.text=[NSString stringWithFormat:@"%d",porcentajeArteLiteratura];
    
    NSInteger porcentajeCiencias = ([[temp objectForKey:@"ciencias-acertadas"] integerValue]*100)/[[temp objectForKey:@"ciencias-contestadas"] integerValue];
    UIImageView *barraCiencias = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeCiencias/100)-140, 267, 140, 23)];
    UIImage *imgbarraCiencias = [UIImage imageNamed:@"barra-CIENCIAS"];
    barraCiencias.image = imgbarraCiencias;
    [self.view addSubview:barraCiencias];
    [self.view setNeedsDisplay];
    porcentajePartidaCienciasLabel.text=[NSString stringWithFormat:@"%d",porcentajeCiencias];
    
    NSInteger porcentajeDeportes = ([[temp objectForKey:@"deportes-acertadas"] integerValue]*100)/[[temp objectForKey:@"deportes-contestadas"] integerValue];
    UIImageView *barraDeportes = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeDeportes/100)-140, 297, 140, 23)];
    UIImage *imgbarraDeportes = [UIImage imageNamed:@"barra-DEPORTES"];
    barraDeportes.image = imgbarraDeportes;
    [self.view addSubview:barraDeportes];
    [self.view setNeedsDisplay];
    porcentajePartidaDeportesLabel.text=[NSString stringWithFormat:@"%d",porcentajeDeportes];
    
    NSInteger porcentajeGeografia = ([[temp objectForKey:@"geografia-acertadas"] integerValue]*100)/[[temp objectForKey:@"geografia-contestadas"] integerValue];
    UIImageView *barraGeografia = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeGeografia/100)-140, 327, 140, 23)];
    UIImage *imgbarraGeografia = [UIImage imageNamed:@"barra-GEOGRAFIA"];
    barraGeografia.image = imgbarraGeografia;
    [self.view addSubview:barraGeografia];
    [self.view setNeedsDisplay];
    porcentajePartidaGeografiaLabel.text=[NSString stringWithFormat:@"%d",porcentajeGeografia];
    
    NSInteger porcentajeHistoria = ([[temp objectForKey:@"historia-acertadas"] integerValue]*100)/[[temp objectForKey:@"historia-contestadas"] integerValue];
    UIImageView *barraHistoria = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeHistoria/100)-140, 357, 140, 23)];
    UIImage *imgbarraHistoria = [UIImage imageNamed:@"barra-HISTORIA"];
    barraHistoria.image = imgbarraHistoria;
    [self.view addSubview:barraHistoria];
    [self.view setNeedsDisplay];
    porcentajePartidaHistoriaLabel.text=[NSString stringWithFormat:@"%d",porcentajeHistoria];
    
    NSInteger porcentajeOcio = ([[temp objectForKey:@"ocio-acertadas"] integerValue]*100)/[[temp objectForKey:@"ocio-contestadas"] integerValue];
    UIImageView *barraOcio = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOcio/100)-140, 387, 140, 23)];
    UIImage *imgbarraOcio = [UIImage imageNamed:@"barra-OCIO"];
    barraOcio.image = imgbarraOcio;
    [self.view addSubview:barraOcio];
    [self.view setNeedsDisplay];
    porcentajePartidaOcioLabel.text=[NSString stringWithFormat:@"%d",porcentajeOcio];
    
    NSInteger porcentajeOtros = ([[temp objectForKey:@"otros-acertadas"] integerValue]*100)/[[temp objectForKey:@"otros-contestadas"] integerValue];
    UIImageView *barraOtros = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeOtros/100)-140, 417, 140, 23)];
    UIImage *imgbarraOtros = [UIImage imageNamed:@"barra-OTROS"];
    barraOtros.image = imgbarraOtros;
    [self.view addSubview:barraOtros];
    [self.view setNeedsDisplay];
    porcentajePartidaOtrosLabel.text=[NSString stringWithFormat:@"%d",porcentajeOtros];
    
    NSInteger porcentajeTODO = ([[temp objectForKey:@"total-preguntas-acertadas"] integerValue]*100)/[[temp objectForKey:@"total-preguntas-contestadas"] integerValue];
    UIImageView *barraTODO = [[UIImageView alloc] initWithFrame:CGRectMake((140*porcentajeTODO/100)-140, 447, 140, 23)];
    UIImage *imgbarraTODO = [UIImage imageNamed:@"barra-TODOS"];
    barraTODO.image = imgbarraTODO;
    [self.view addSubview:barraTODO];
    [self.view setNeedsDisplay];
    porcentajePartidaTODOLabel.text=[NSString stringWithFormat:@"%d",porcentajeTODO];
    
    
    XdeYenArteLiteratura.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"arte-literatura-acertadas"],[temp objectForKey:@"arte-literatura-contestadas"]];
    XdeYenCiencias.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"ciencias-acertadas"],[temp objectForKey:@"ciencias-contestadas"]];
    XdeYenDeportes.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"deportes-acertadas"],[temp objectForKey:@"deportes-contestadas"]];
    XdeYenGeografia.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"geografia-acertadas"],[temp objectForKey:@"geografia-contestadas"]];
    XdeYenHistoria.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"historia-acertadas"],[temp objectForKey:@"historia-contestadas"]];
    XdeYenOcio.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"ocio-acertadas"],[temp objectForKey:@"ocio-contestadas"]];
    XdeYenOtros.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"otros-acertadas"],[temp objectForKey:@"otros-contestadas"]];
    XdeYenTODO.text=[NSString stringWithFormat:@"%@ de %@",[temp objectForKey:@"total-preguntas-acertadas"],[temp objectForKey:@"total-preguntas-contestadas"]];
    
}

@end
