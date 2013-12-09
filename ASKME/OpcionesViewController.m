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
    
    NSString *result=[NSString stringWithFormat:@"%@ %@", @"Bienvenido", nickNombreViewController.nickNombre];
    nombreUsuarioLabel.text = result;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
