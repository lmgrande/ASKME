//
//  PreguntasViewController.h
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleUIView.h"
//#import "AppDelegate.h"


@interface PreguntasViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *preguntasTableView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (nonatomic, strong) NSArray *tableData;

//@property (nonatomic, strong) NSMutableArray *json;
//@property (nonatomic, strong) NSMutableArray *preguntasArray;

@property (strong, nonatomic) IBOutlet UIProgressView *preguntaLinearProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *partidaLinearProgressView;

@property (weak, nonatomic) IBOutlet CircleUIView *contadorGrafico;
@property (weak, nonatomic) IBOutlet UILabel *numerosContadorLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntaLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPreguntasPartida;
@property (weak, nonatomic) IBOutlet UILabel *numeroPreguntaActualPartida;
@property (weak, nonatomic) IBOutlet UILabel *puntosPreguntaLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosAcumuladosLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasAcertadasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasNoContestadasLabel;
@property (weak, nonatomic) IBOutlet UILabel *preguntasFalladasLabel;
@property (weak, nonatomic) IBOutlet UILabel *puntosMaximosPartida;

@property (weak, nonatomic) IBOutlet UIImageView *iconoPreguntaUIImageView;
@property (weak, nonatomic) IBOutlet UILabel *materiaPreguntaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fondoPiePreguntaImageView;
@property (weak, nonatomic) IBOutlet UIButton *proximaPreguntaButton;


- (IBAction)casaBoton:(id)sender;
- (IBAction)proximaPregunta:(id)sender;

//#pragma mark - Metodos
//
//- (void) sacarDatosFicheroJSON;

@end
