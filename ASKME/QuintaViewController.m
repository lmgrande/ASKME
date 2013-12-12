//
//  QuintaViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "QuintaViewController.h"

@interface QuintaViewController ()

@end

@implementation QuintaViewController

#pragma mark - customizando icono tab bar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *imagen = [UIImage imageNamed:@"ico-Tab-Bar-Configuracion@x2.png"];
        CGImageRef imagenRef = [imagen CGImage];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Config." image:[UIImage imageWithCGImage:imagenRef scale:2.0f orientation:UIImageOrientationUp] selectedImage:nil];
    }
    return self;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
