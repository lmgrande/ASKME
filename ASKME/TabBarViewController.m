//
//  TabBarViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage *imagenFondo = [UIImage imageNamed:@"FONDO_Tab_Bar_Opciones@2x.png"];
    CGImageRef imagenFondoRef = [imagenFondo CGImage];
    [self.tabBar setBackgroundImage:[UIImage imageWithCGImage:imagenFondoRef scale:2.0f orientation:UIImageOrientationUp]];
    UIImage *imagenLineaSombra = [UIImage imageNamed:@"linea-superior-Tab-Bar-1x1.png"];
    CGImageRef imagenLineaSombraRef = [imagenLineaSombra CGImage];
    [self.tabBar setShadowImage:[UIImage imageWithCGImage:imagenLineaSombraRef scale:2.0f orientation:UIImageOrientationUp]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
