//
//  PreguntasJugadoresViewController.m
//  ASKME
//
//  Created by LUISMI on 20/01/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "PreguntasJugadoresViewController.h"

@interface PreguntasJugadoresViewController ()

@end

@implementation PreguntasJugadoresViewController

@synthesize partidaJugadoresLabel,tiempoJugadoresLabel;

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
    partidaJugadoresLabel.text = ApplicationDelegate.numeroPartidaJugadores;
    tiempoJugadoresLabel.text = ApplicationDelegate.tiempoPartidaJugadores;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

@end
