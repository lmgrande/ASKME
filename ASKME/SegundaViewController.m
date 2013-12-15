//
//  SegundaViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "SegundaViewController.h"
#import "Pregunta.h"

@interface SegundaViewController ()

@end

#define urlParaTraerDatos @"http://www.askmeapp.com/php_IOS/leerPreguntasJugador.php"

@implementation SegundaViewController

@synthesize json, preguntasArray;

#pragma mark - customizando icono tab bar

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIImage *imagen = [UIImage imageNamed:@"ico-Tab-Bar-Usuario@x2.png"];
        CGImageRef imagenRef = [imagen CGImage];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Jugador" image:[UIImage imageWithCGImage:imagenRef scale:2.0f orientation:UIImageOrientationUp] selectedImage:nil];
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
    
    [self recogerDatos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos

- (void) recogerDatos
{
    NSURL *url = [NSURL URLWithString:urlParaTraerDatos];
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    preguntasArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<json.count; i++)
    {
        NSLog(@"REGISTRO JSON: %D",i);
        NSString *textPregunta = [[json objectAtIndex:i] objectForKey:@"pregunta"];
        NSLog(@"Pregunta JSON: %@",textPregunta);
        NSString *textMateria = [[json objectAtIndex:i] objectForKey:@"materia"];
        NSLog(@"Materia JSON: %@",textMateria);
        NSString *textCorrecta = [[json objectAtIndex:i] objectForKey:@"correcta"];
        NSLog(@"Correcta JSON: %@",textCorrecta);
        NSString *textIncorrecta1 = [[json objectAtIndex:i] objectForKey:@"incorrecta1"];
        NSLog(@"Incorrecta1 JSON: %@",textIncorrecta1);
        NSString *textIncorrecta2 = [[json objectAtIndex:i] objectForKey:@"incorrecta2"];
        NSLog(@"Incorrecta2 JSON: %@",textIncorrecta2);
        NSString *textIncorrecta3 = [[json objectAtIndex:i] objectForKey:@"incorrecta3"];
        NSLog(@"Incorrecta3 JSON: %@",textIncorrecta3);
        
        Pregunta *miPregunta = [[Pregunta alloc] initWithTextoPregunta:textPregunta andTextoMateria:textMateria andTextoCorrecta:textCorrecta andTextoIncorrecta1:textIncorrecta1 andTextoIncorrecta2:textIncorrecta2 andTextoIncorrecta3:textIncorrecta3];
        
        [preguntasArray addObject:miPregunta];

    }
    
}

@end
