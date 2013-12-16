//
//  PreguntasViewController.m
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "PreguntasViewController.h"
#import "ViewController.h"
#import "Pregunta.h"

@interface PreguntasViewController ()

@end

@implementation PreguntasViewController

@synthesize nickLabel, tableData, json, preguntasArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Ciclo de vida de una View

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ViewController *nickNombreViewController = [[ViewController alloc]init];
    [nickNombreViewController leerUsuarioPlist];
    
    NSString *result=[NSString stringWithFormat:@"%@", nickNombreViewController.nickNombre];
    nickLabel.text = result;
    
    tableData = [[NSArray alloc] initWithObjects:@"Respuesta1 no se cuantas líneas me pueden caber en esta celda. Probemos a ver si caben dos líneas.", @"Respuesta2", @"Respuesta3", @"Respuesta4", nil];
    
    [self sacarDatosFicheroJSON];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - métodos Data Source de la TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"RespuestaCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RespuestaCell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.numberOfLines = 0;

    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}


#pragma mark - métodos para archivo JSON

- (void) sacarDatosFicheroJSON
{
    NSString *jsonPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/preguntas.json"];
    NSLog(@"Path JSON leer: %@",jsonPath);
    NSData *data = [NSData dataWithContentsOfFile:jsonPath];
    NSLog(@"Data JSON leer: %@",data);
    json = [[NSMutableArray alloc] init];
    json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
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

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}
@end
