//
//  OpcionesViewController.m
//  ASKME
//
//  Created by LUISMI on 08/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "OpcionesViewController.h"

@interface OpcionesViewController ()

@end

@implementation OpcionesViewController

@synthesize nombreUsuarioLabel;

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
    
    ViewController *nickNombreViewController = [[ViewController alloc]init];
    [nickNombreViewController leerUsuarioPlist];
    
    NSString *result=[NSString stringWithFormat:@"%@", nickNombreViewController.nickNombre];
    nombreUsuarioLabel.text = result;
    [self empezar];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - pasarPantalla

- (void) empezar{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:4.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) pasarPantalla{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}


@end
