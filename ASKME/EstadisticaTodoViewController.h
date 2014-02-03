//
//  EstadisticaTodoViewController.h
//  ASKME
//
//  Created by LUISMI on 03/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstadisticaTodoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (weak, nonatomic) IBOutlet UILabel *numeroPartidaLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosMaximoPartidaLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasMaximoPartidaLabel;

@property (weak, nonatomic) IBOutlet UILabel *preguntasContestadasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasAcertadasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasNoAcertadasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasFalladasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasPasadasLabel;

@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaArteLiteraturaLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaCienciasLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaDeportesLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaGeografiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaHistoriaLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaOcioLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaOtrosLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosPartidaTODOLabel;

@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaArteLiteraturaLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaCienciasLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaDeportesLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaGeografiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaHistoriaLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaOcioLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaOtrosLabel;
@property (weak, nonatomic) IBOutlet UILabel *porcentajePartidaTODOLabel;

@property (weak, nonatomic) IBOutlet UILabel *XdeYenArteLiteratura;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenCiencias;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenDeportes;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenGeografia;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenHistoria;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenOcio;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenOtros;
@property (weak, nonatomic) IBOutlet UILabel *XdeYenTODO;

@property (weak, nonatomic) IBOutlet UILabel *textoEsperarLabel;
@property (weak, nonatomic) IBOutlet UILabel *numerosEsperarLabel;


- (IBAction)casaBoton:(id)sender;
- (IBAction)estadisticaPartidaActualBoton:(id)sender;
- (IBAction)estadisticaTodasLasPartidasBoton:(id)sender;


@end
