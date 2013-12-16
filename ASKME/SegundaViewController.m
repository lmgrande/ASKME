//
//  SegundaViewController.m
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "SegundaViewController.h"

@interface SegundaViewController ()

@end

#define urlParaTraerDatos @"http://www.askmeapp.com/php_IOS/leerPreguntasJugador.php"

@implementation SegundaViewController

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
    
    [self recogerYGrabarDatosEnFicheroJSON];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos

- (void) recogerYGrabarDatosEnFicheroJSON
{
    NSURL *url = [NSURL URLWithString:urlParaTraerDatos];
    
    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *jsonData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    NSError *error1;
    
    // array of dictionary
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error1];
    
    if (error1) {
        NSLog(@"Error: %@", error1.localizedDescription);
    } else {
        // para sobreescribir fichero json
        NSFileManager *fileManager = [NSFileManager defaultManager];
        // -------------------------------
        
        NSArray *documentsSearchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [documentsSearchPaths count] == 0 ? nil : [documentsSearchPaths objectAtIndex:0];
        
        NSString *fileName = @"preguntas.json";
        
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        // para sobreescribir fichero json
        if ([fileManager fileExistsAtPath:filePath] == YES) {
            NSError *errorfileExistsAtPath;
            [fileManager removeItemAtPath:filePath error:&errorfileExistsAtPath];
        }
        // -------------------------------
        
        NSOutputStream *outputStream = [NSOutputStream outputStreamToFileAtPath:filePath append:YES];
        [outputStream open];
        
        [NSJSONSerialization writeJSONObject:array
                                    toStream:outputStream
                                     options:kNilOptions
                                       error:&error1];
        [outputStream close];
        NSLog(@"Path JSON: %@",filePath);
        [self empezar];
    }

}

#pragma mark - pasarPantalla

- (void) empezar{
    
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) pasarPantalla{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Preguntas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}


@end
