//
//  PreguntasJugadoresViewController.h
//  ASKME
//
//  Created by LUISMI on 20/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreguntasJugadoresViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *partidaJugadoresLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiempoJugadoresLabel;

- (IBAction)casaBoton:(id)sender;

@end
