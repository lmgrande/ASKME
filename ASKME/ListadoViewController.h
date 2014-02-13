//
//  ListadoViewController.h
//  ASKME
//
//  Created by LUISMI on 05/02/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListadoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

    @property (weak, nonatomic) IBOutlet UITableView *myTableView;

    @property (nonatomic, strong) NSArray *tableData;
    @property (weak, nonatomic) IBOutlet UILabel *jugadoresLabel;
    @property (weak, nonatomic) IBOutlet UILabel *contadorListado;

- (IBAction)casaBoton:(id)sender;
- (IBAction)mostrarSoloJugadoresSeleccionadosBoton:(id)sender;

@end
