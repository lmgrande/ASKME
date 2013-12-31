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
#import <math.h>
#import "RespuestaTableViewCell.h"

@interface PreguntasViewController ()
{
    NSMutableDictionary *partida;
    CGFloat contador;
    NSTimer *timerPartida;
    NSTimer *timerPregunta;
    int numero,j,segundosParaPuntos,puntosTotalesPartida,preguntasAcertadas,preguntasFalladas,preguntasNoContestadas;
    BOOL acertada;
}


@end

@implementation PreguntasViewController

@synthesize nickLabel, tableData, json, preguntasArray, preguntaLinearProgressView, partidaLinearProgressView, contadorGrafico, numerosContadorLabel, preguntaLabel, preguntasTableView, totalPreguntasPartida,numeroPreguntaActualPartida, puntosPreguntaLabel,puntosAcumuladosLabel,preguntasAcertadasLabel, preguntasFalladasLabel, preguntasNoContestadasLabel, iconoPreguntaUIImageView, materiaPreguntaLabel, fondoPiePreguntaImageView, proximaPreguntaButton;

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
    
    partida = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
               @"0", @"arte-literatura-contestadas",
               @"0", @"arte-literatura-acertadas",
               @"0", @"arte-literatura-puntos",
               @"0", @"ciencias-contestadas",
               @"0", @"ciencias-acertadas",
               @"0", @"ciencias-puntos",
               @"0", @"deportes-contestadas",
               @"0", @"deportes-acertadas",
               @"0", @"deportes-puntos",
               @"0", @"geografia-contestadas",
               @"0", @"geografia-acertadas",
               @"0", @"geografia-puntos",
               @"0", @"historia-contestadas",
               @"0", @"historia-acertadas",
               @"0", @"historia-puntos",
               @"0", @"ocio-contestadas",
               @"0", @"ocio-acertadas",
               @"0", @"ocio-puntos",
               @"0", @"otros-contestadas",
               @"0", @"otros-acertadas",
               @"0", @"otros-puntos",
               @"0", @"total-preguntas-partida",
               @"0", @"total-preguntas-contestadas",
               @"0", @"total-preguntas-acertadas",
               @"0", @"total-preguntas-falladas",
               @"0", @"total-preguntas-pasadas",
               @"0", @"puntos-totales-conseguidos",
               @"0", @"puntos-maximos-partida",
               nil];
    
    ViewController *nickNombreViewController = [[ViewController alloc]init];
    [nickNombreViewController leerUsuarioPlist];
    
    NSString *result=[NSString stringWithFormat:@"%@", nickNombreViewController.nickNombre];
    nickLabel.text = result;
    proximaPreguntaButton.hidden=YES;
    partidaLinearProgressView.progress = 0.0;
    preguntaLinearProgressView.progress = 0.0;
    [self performSelectorOnMainThread:@selector(moverProgressBarPartida) withObject:nil waitUntilDone:NO];
    numero = 12;
    j=0;
    puntosTotalesPartida=0;
    preguntasAcertadas=0;
    preguntasFalladas=0;
    preguntasNoContestadas=0;
    
    [self sacarDatosFicheroJSON];
    [self empezarContadorPartida];
    [self empezarContadorPregunta];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - métodos Data Source de la TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = nil;
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:@"RespuestaCell"];
//    
//    if (cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RespuestaCell"];
//    }
//    
//    UIImageView *cellBgView =[[UIImageView alloc]init];
//    [cellBgView setImage:[UIImage imageNamed:@"fondo_deg_gris_celda.png"]];
//    [cell setBackgroundView:cellBgView];
//    
//    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    
//    cell.indentationLevel = 1;
//    cell.indentationWidth = 40;
//    cell.textLabel.font = [UIFont systemFontOfSize:12];
//    cell.textLabel.numberOfLines = 0;
//
//    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
//    
//    return cell;

    NSString *cellTextoRespuesta = [tableData objectAtIndex:indexPath.row];
    NSString *cellIdentifier =@"CeldaRespuesta";
    RespuestaTableViewCell *cell = nil;
    cell = (RespuestaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    [tableView setSeparatorInset:UIEdgeInsetsZero];

    if (!cell) {
        cell = [[RespuestaTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.respuestaLabel.numberOfLines = 0;
    cell.respuestaLabel.text = cellTextoRespuesta;
    cell.parentViewController = self;
    cell.puntoVerdeView.image=nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RespuestaTableViewCell *cell = (RespuestaTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];

    Pregunta *preguntaActual = [preguntasArray objectAtIndex:j-1];
    
    if ([[tableData objectAtIndex:indexPath.row] isEqualToString:preguntaActual.textoCorrecta]) {
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo_deg_verde_celda.png"]];
        acertada=YES;
    }else{
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo_deg_rojo_celda.png"]];
        acertada=NO;
    }
    for (int i=0; i<tableData.count; i++) {
        if ([[tableData objectAtIndex:i] isEqualToString:preguntaActual.textoCorrecta]) {
            RespuestaTableViewCell *cell1 =(RespuestaTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            cell1.puntoVerdeView.image=[UIImage imageNamed:@"punto-verde-correcta.png"];
        }
    }
    tableView.allowsSelection = NO;
    segundosParaPuntos=[numerosContadorLabel.text intValue];
    numerosContadorLabel.hidden=YES;
    proximaPreguntaButton.hidden=NO;
    [self calcularPuntos];
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
        totalPreguntasPartida.text = [NSString stringWithFormat:@"%lu", (unsigned long)json.count];
        
    }

}

#pragma mark - cargar Preguntas

- (void)cargarPregunta
{
    Pregunta *miPregunta = [preguntasArray objectAtIndex:j];
    preguntaLabel.text = miPregunta.textoPregunta;
    
    NSArray *desordenarArray = [[NSArray alloc] initWithObjects:miPregunta.textoCorrecta, miPregunta.textoIncorrecta1, miPregunta.textoIncorrecta2, miPregunta.textoIncorrecta3, nil];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:desordenarArray];
    NSUInteger count = [temp count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [temp exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    tableData = [[NSArray alloc] initWithObjects:[temp objectAtIndex:0], [temp objectAtIndex:1], [temp objectAtIndex:2], [temp objectAtIndex:3], nil];
    
    [self.preguntasTableView reloadData];
    
    if ([miPregunta.textoMateria isEqual:@"general"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-otros.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-otros"];
        materiaPreguntaLabel.text = @"OTROS";
    }else if ([miPregunta.textoMateria isEqual:@"arteliteratura"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-arte-literatura.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-arte-literatura"];
        materiaPreguntaLabel.text = @"ARTE y LITERATURA";
    }else if ([miPregunta.textoMateria isEqual:@"ciencias"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-ciencias.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-ciencias"];
        materiaPreguntaLabel.text = @"CIENCIAS";
    }else if ([miPregunta.textoMateria isEqual:@"deportes"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-deportes.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-deportes"];
        materiaPreguntaLabel.text = @"DEPORTES";
    }else if ([miPregunta.textoMateria isEqual:@"espectaculosocio"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-ocio.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-ocio"];
        materiaPreguntaLabel.text = @"OCIO";
    }else if ([miPregunta.textoMateria isEqual:@"geografia"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-geografia.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-geografia"];
        materiaPreguntaLabel.text = @"GEOGRAFÍA";
    }else if ([miPregunta.textoMateria isEqual:@"historia"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-historia.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-historia"];
        materiaPreguntaLabel.text = @"HISTORIA";
    }else {
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-base.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-base"];
        materiaPreguntaLabel.text = @"MATERIA";
    }
    
    j++;
    
    numeroPreguntaActualPartida.text = [NSString stringWithFormat:@"%d", j];
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    [timerPregunta invalidate];
    [timerPartida invalidate];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)proximaPregunta:(id)sender
{
    [timerPregunta invalidate];
    contador=0;
    contadorGrafico.backgroundColor = [UIColor clearColor];
    numerosContadorLabel.text = @"12";
    numero = 12;
    [self empezarContadorPregunta];
}

#pragma mark - métodos circulo contador

- (void) empezarContadorPregunta{
    preguntasTableView.allowsSelection = YES;
    proximaPreguntaButton.hidden=YES;
    puntosPreguntaLabel.text = @"0";
    
    if (j==json.count) {
        [self pasarPantalla];
    }else{
        
        [self cargarPregunta];
        
        numerosContadorLabel.hidden=NO;
        preguntaLinearProgressView.progress = 0.0;
    
        timerPregunta = [NSTimer timerWithTimeInterval:0.1
                                                target:self
                                              selector:@selector(counterdownCircle)
                                              userInfo:nil
                                               repeats:YES];
    
        [[NSRunLoop currentRunLoop] addTimer:timerPregunta
                                     forMode:NSDefaultRunLoopMode];
    }
    
}

-(void) counterdownCircle{
    float newProgress = [self.preguntaLinearProgressView progress] + 0.0088;
    [self.preguntaLinearProgressView setProgress:newProgress animated:YES];
    
    //while (j<json.count) {
        if (contador<120) {
            
            contadorGrafico.colorRellenoContador = [UIColor grayColor];
            contador++;
            float intcontador = (int) contador;
            float segundo = fmodf(intcontador, 10.0);
            if (segundo==0) {
                numero--;
                if (numero==0) {
                    NSString *numeroContador = [NSString stringWithFormat:@"%d", 12];
                    numerosContadorLabel.text = numeroContador;
                }else{
                    NSString *numeroContador = [NSString stringWithFormat:@"%d", numero];
                    numerosContadorLabel.text = numeroContador;
                }
                
            }
            if (numerosContadorLabel.hidden==NO) {
                contadorGrafico.comenzar=90;
                contadorGrafico.finalizar=90+(contador*3);
                [contadorGrafico setNeedsDisplay];
            }
        }else{
            
            [timerPregunta invalidate];
            contador=0;
            contadorGrafico.backgroundColor = [UIColor clearColor];
            numerosContadorLabel.text = @"12";
            numero = 12;

            if (preguntasTableView.allowsSelection==YES){
                segundosParaPuntos=0;
                [self calcularPuntos];
            }
            [self empezarContadorPregunta];
        }
        NSLog(@"contador: %f",contador);
    //}
}

#pragma mark - otros métodos

-(void)calcularPuntos
{
    int puntosPregunta=0;
    if (segundosParaPuntos==0) {
        puntosPregunta=0;
        preguntasNoContestadas++;
    } else {
        if (acertada==NO) {
            puntosPregunta=-2;
            preguntasFalladas++;
        } else if (acertada==YES){
            preguntasAcertadas++;
            if(segundosParaPuntos<4){
                puntosPregunta=6;
            }else if(segundosParaPuntos<7){
                puntosPregunta=8;
            }else if(segundosParaPuntos<10){
                puntosPregunta=10;
            }else if(segundosParaPuntos<=12){
                puntosPregunta=12;
            }
        }
    }
    puntosTotalesPartida = puntosTotalesPartida+puntosPregunta;
    puntosPreguntaLabel.text = [NSString stringWithFormat:@"%d",puntosPregunta];
    puntosAcumuladosLabel.text = [NSString stringWithFormat:@"%d",puntosTotalesPartida];
    preguntasAcertadasLabel.text = [NSString stringWithFormat:@"%d",preguntasAcertadas];
    preguntasNoContestadasLabel.text = [NSString stringWithFormat:@"%d",preguntasNoContestadas];
    preguntasFalladasLabel.text = [NSString stringWithFormat:@"%d",preguntasFalladas];

}

- (void) empezarContadorPartida{
    
    //float newProgress = [self.partidaLinearProgressView progress] + 0.12;
    //[self.partidaLinearProgressView setProgress:newProgress animated:YES];
    timerPartida = [NSTimer scheduledTimerWithTimeInterval:120.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) pasarPantalla{
    [timerPregunta invalidate];
    [timerPartida invalidate];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"pantallaEstadisticas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}

- (void)moverProgressBarPartida {
    
    float actual = [partidaLinearProgressView progress];
    if (actual < 1) {
        partidaLinearProgressView.progress = actual + 0.01;
        [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(moverProgressBarPartida) userInfo:nil repeats:NO];
    }
    else{
        
        
        
    }
    
}

@end
