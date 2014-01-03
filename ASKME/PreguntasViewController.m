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
    Pregunta *miPreguntaMateria;
    NSMutableDictionary *partida;
    NSMutableDictionary *partidas;
    CGFloat contador;
    NSTimer *timerPartida;
    NSTimer *timerPregunta;
    int numero,j,segundosParaPuntos,puntosTotalesPartida,preguntasAcertadas,preguntasFalladas,preguntasNoContestadas;
    BOOL acertada;
    NSInteger arteLiteraturaContestadas,arteLiteraturaAcertadas,arteLiteraturaPuntos;
    NSInteger cienciasContestadas,cienciasAcertadas,cienciasPuntos;
    NSInteger deportesContestadas,deportesAcertadas,deportesPuntos;
    NSInteger geografiaContestadas,geografiaAcertadas,geografiaPuntos;
    NSInteger historiaContestadas,historiaAcertadas,historiaPuntos;
    NSInteger ocioContestadas,ocioAcertadas,ocioPuntos;
    NSInteger otrosContestadas,otrosAcertadas,otrosPuntos;

}


@end

@implementation PreguntasViewController

@synthesize nickLabel, tableData, json, preguntasArray, preguntaLinearProgressView, partidaLinearProgressView, contadorGrafico, numerosContadorLabel, preguntaLabel, preguntasTableView, totalPreguntasPartida,numeroPreguntaActualPartida, puntosPreguntaLabel, puntosMaximosPartida, puntosAcumuladosLabel,preguntasAcertadasLabel, preguntasFalladasLabel, preguntasNoContestadasLabel, iconoPreguntaUIImageView, materiaPreguntaLabel, fondoPiePreguntaImageView, proximaPreguntaButton;

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
    partidas = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
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
               @"0", @"total-preguntas-contestadas",
               @"0", @"total-preguntas-acertadas",
               @"0", @"total-preguntas-falladas",
               @"0", @"puntos-totales-conseguidos",
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
        puntosMaximosPartida.text =[NSString stringWithFormat:@"%lu", 12*(unsigned long)json.count];;
        
    }

}

#pragma mark - cargar Preguntas

- (void)cargarPregunta
{
    miPreguntaMateria = [preguntasArray objectAtIndex:j];
    preguntaLabel.text = miPreguntaMateria.textoPregunta;
    
    NSArray *desordenarArray = [[NSArray alloc] initWithObjects:miPreguntaMateria.textoCorrecta, miPreguntaMateria.textoIncorrecta1, miPreguntaMateria.textoIncorrecta2, miPreguntaMateria.textoIncorrecta3, nil];
    NSMutableArray *temp = [NSMutableArray arrayWithArray:desordenarArray];
    NSUInteger count = [temp count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSUInteger nElements = count - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [temp exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    tableData = [[NSArray alloc] initWithObjects:[temp objectAtIndex:0], [temp objectAtIndex:1], [temp objectAtIndex:2], [temp objectAtIndex:3], nil];
    
    [self.preguntasTableView reloadData];
    
    if ([miPreguntaMateria.textoMateria isEqual:@"general"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-otros.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-otros"];
        materiaPreguntaLabel.text = @"OTROS";
        otrosContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"arteliteratura"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-arte-literatura.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-arte-literatura"];
        materiaPreguntaLabel.text = @"ARTE y LITERATURA";
        arteLiteraturaContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"ciencias"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-ciencias.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-ciencias"];
        materiaPreguntaLabel.text = @"CIENCIAS";
        cienciasContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"deportes"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-deportes.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-deportes"];
        materiaPreguntaLabel.text = @"DEPORTES";
        deportesContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"espectaculosocio"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-ocio.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-ocio"];
        materiaPreguntaLabel.text = @"OCIO";
        ocioContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"geografia"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-geografia.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-geografia"];
        materiaPreguntaLabel.text = @"GEOGRAFÍA";
        geografiaContestadas++;
    }else if ([miPreguntaMateria.textoMateria isEqual:@"historia"]){
        fondoPiePreguntaImageView.image = [UIImage imageNamed:@"FONDO-PIE-JUGADOR-historia.png"];
        iconoPreguntaUIImageView.image = [UIImage imageNamed:@"icono-historia"];
        materiaPreguntaLabel.text = @"HISTORIA";
        historiaContestadas++;
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

        if ([miPreguntaMateria.textoMateria isEqual:@"general"]&&(acertada==YES)){
            otrosAcertadas++;
            otrosPuntos=otrosPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"arteliteratura"]&&(acertada==YES)){
            arteLiteraturaAcertadas++;
            arteLiteraturaPuntos=arteLiteraturaPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"ciencias"]&&(acertada==YES)){
            cienciasAcertadas++;
            cienciasPuntos=cienciasPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"deportes"]&&(acertada==YES)){
            deportesAcertadas++;
            deportesPuntos=deportesPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"espectaculosocio"]&&(acertada==YES)){
            ocioAcertadas++;
            ocioPuntos=ocioPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"geografia"]&&(acertada==YES)){
            geografiaAcertadas++;
            geografiaPuntos=geografiaPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"historia"]&&(acertada==YES)){
            historiaAcertadas++;
            historiaPuntos=historiaPuntos+puntosPregunta;
        }
        if ([miPreguntaMateria.textoMateria isEqual:@"general"]&&(acertada==NO)){
            otrosPuntos=otrosPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"arteliteratura"]&&(acertada==NO)){
            arteLiteraturaPuntos=arteLiteraturaPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"ciencias"]&&(acertada==NO)){
            cienciasPuntos=cienciasPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"deportes"]&&(acertada==NO)){
            deportesPuntos=deportesPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"espectaculosocio"]&&(acertada==NO)){
            ocioPuntos=ocioPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"geografia"]&&(acertada==NO)){
            geografiaPuntos=geografiaPuntos+puntosPregunta;
        }else if ([miPreguntaMateria.textoMateria isEqual:@"historia"]&&(acertada==NO)){
            historiaPuntos=historiaPuntos+puntosPregunta;
        }
    }
    
    puntosTotalesPartida = puntosTotalesPartida+puntosPregunta;
    puntosPreguntaLabel.text = [NSString stringWithFormat:@"%d",puntosPregunta];
    puntosAcumuladosLabel.text = [NSString stringWithFormat:@"%d",puntosTotalesPartida];
    preguntasAcertadasLabel.text = [NSString stringWithFormat:@"%d",preguntasAcertadas];
    preguntasNoContestadasLabel.text = [NSString stringWithFormat:@"%d",preguntasNoContestadas];
    preguntasFalladasLabel.text = [NSString stringWithFormat:@"%d",preguntasFalladas];

}

- (void) empezarContadorPartida
{
    
    //float newProgress = [self.partidaLinearProgressView progress] + 0.12;
    //[self.partidaLinearProgressView setProgress:newProgress animated:YES];
    timerPartida = [NSTimer scheduledTimerWithTimeInterval:120.0         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:NO];
}

-(void) pasarPantalla
{
    if (preguntasTableView.indexPathForSelectedRow==nil) {
        segundosParaPuntos=0;
        [self calcularPuntos];
    }
    
    [self grabarDatosPartidaPlist];
    [timerPregunta invalidate];
    [timerPartida invalidate];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"pantallaEstadisticas"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}

- (void)moverProgressBarPartida
{
    float actual = [partidaLinearProgressView progress];
    if (actual < 1) {
        partidaLinearProgressView.progress = actual + 0.01;
        [NSTimer scheduledTimerWithTimeInterval:1.2 target:self selector:@selector(moverProgressBarPartida) userInfo:nil repeats:NO];
    }
}

-(void)grabarDatosPartidaPlist
{
    [partida setObject:totalPreguntasPartida.text forKey:@"total-preguntas-partida"];
    [partida setObject:numeroPreguntaActualPartida.text forKey:@"total-preguntas-contestadas"];
    [partida setObject:preguntasAcertadasLabel.text forKey:@"total-preguntas-acertadas"];
//    NSInteger resultado=(NSInteger)numeroPreguntaActualPartida.text-(NSInteger)preguntasAcertadasLabel.text;
//    NSString *preguntasFalladasPartida=[NSString stringWithFormat:@"%d", resultado];
//    [partida setObject:preguntasFalladasPartida forKey:@"total-preguntas-falladas"];
    [partida setObject:preguntasFalladasLabel.text forKey:@"total-preguntas-falladas"];
    [partida setObject:preguntasNoContestadasLabel.text forKey:@"total-preguntas-pasadas"];
    [partida setObject:puntosAcumuladosLabel.text forKey:@"puntos-totales-conseguidos"];
    [partida setObject:puntosMaximosPartida.text forKey:@"puntos-maximos-partida"];
    
    NSString *alC=[NSString stringWithFormat:@"%d", arteLiteraturaContestadas];
    NSString *alA=[NSString stringWithFormat:@"%d", arteLiteraturaAcertadas];
    NSString *alP=[NSString stringWithFormat:@"%d", arteLiteraturaPuntos];
    [partida setObject:alC forKey:@"arte-literatura-contestadas"];
    [partida setObject:alA forKey:@"arte-literatura-acertadas"];
    [partida setObject:alP forKey:@"arte-literatura-puntos"];
    
    NSString *cC=[NSString stringWithFormat:@"%d", cienciasContestadas];
    NSString *cA=[NSString stringWithFormat:@"%d", cienciasAcertadas];
    NSString *cP=[NSString stringWithFormat:@"%d", cienciasPuntos];
    [partida setObject:cC forKey:@"ciencias-contestadas"];
    [partida setObject:cA forKey:@"ciencias-acertadas"];
    [partida setObject:cP forKey:@"ciencias-puntos"];
    
    NSString *dC=[NSString stringWithFormat:@"%d", deportesContestadas];
    NSString *dA=[NSString stringWithFormat:@"%d", deportesAcertadas];
    NSString *dP=[NSString stringWithFormat:@"%d", deportesPuntos];
    [partida setObject:dC forKey:@"deportes-contestadas"];
    [partida setObject:dA forKey:@"deportes-acertadas"];
    [partida setObject:dP forKey:@"deportes-puntos"];
    
    NSString *gC=[NSString stringWithFormat:@"%d", geografiaContestadas];
    NSString *gA=[NSString stringWithFormat:@"%d", geografiaAcertadas];
    NSString *gP=[NSString stringWithFormat:@"%d", geografiaPuntos];
    [partida setObject:gC forKey:@"geografia-contestadas"];
    [partida setObject:gA forKey:@"geografia-acertadas"];
    [partida setObject:gP forKey:@"geografia-puntos"];
    
    NSString *hC=[NSString stringWithFormat:@"%d", historiaContestadas];
    NSString *hA=[NSString stringWithFormat:@"%d", historiaAcertadas];
    NSString *hP=[NSString stringWithFormat:@"%d", historiaPuntos];
    [partida setObject:hC forKey:@"historia-contestadas"];
    [partida setObject:hA forKey:@"historia-acertadas"];
    [partida setObject:hP forKey:@"historia-puntos"];
    
    NSString *oC=[NSString stringWithFormat:@"%d", ocioContestadas];
    NSString *oA=[NSString stringWithFormat:@"%d", ocioAcertadas];
    NSString *oP=[NSString stringWithFormat:@"%d", ocioPuntos];
    [partida setObject:oC forKey:@"ocio-contestadas"];
    [partida setObject:oA forKey:@"ocio-acertadas"];
    [partida setObject:oP forKey:@"ocio-puntos"];

    NSString *otrosC=[NSString stringWithFormat:@"%d", otrosContestadas];
    NSString *otrosA=[NSString stringWithFormat:@"%d", otrosAcertadas];
    NSString *otrosP=[NSString stringWithFormat:@"%d", otrosPuntos];
    [partida setObject:otrosC forKey:@"otros-contestadas"];
    [partida setObject:otrosA forKey:@"otros-acertadas"];
    [partida setObject:otrosP forKey:@"otros-puntos"];
    
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"datosPartida.plist"];
    NSLog(@"PATH datosPartida: %@",plistPath);
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:partida
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        [self grabarDatosPartidasPlist];
    }
    else {
        NSLog(@"%@d",error);
    }
}

-(void)grabarDatosPartidasPlist
{
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSString *plistPath1;
    NSString *rootPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    plistPath1 = [rootPath1 stringByAppendingPathComponent:@"datosPartidas.plist"];
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath1]) {
//        plistPath1 = [[NSBundle mainBundle] pathForResource:@"datosPartidas" ofType:@"plist"];
//    }
    NSLog(@"PATH: %@",plistPath1);
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath1];
    NSMutableDictionary *temp = (NSMutableDictionary *)[NSPropertyListSerialization
                                          propertyListFromData:plistXML
                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                          format:&format
                                          errorDescription:&errorDesc];
    if (!temp) {
        //grabar partida
        NSString *error;
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:partida
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath1 atomically:YES];
        }
        else {
            NSLog(@"%@d",error);
        }

    }else
    {
        //añadir partida
        NSString *alC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-contestadas"] integerValue]+[[partida objectForKey:@"arte-literatura-contestadas"] integerValue]];
        [partidas setObject:alC forKey:@"arte-literatura-contestadas"];
        
        NSString *alA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-acertadas"] integerValue]+[[partida objectForKey:@"arte-literatura-acertadas"] integerValue]];
        [partidas setObject:alA forKey:@"arte-literatura-acertadas"];
        
        NSString *alP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"arte-literatura-puntos"] integerValue]+[[partida objectForKey:@"arte-literatura-puntos"] integerValue]];
        [partidas setObject:alP forKey:@"arte-literatura-puntos"];
        
        NSString *cC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-contestadas"] integerValue]+[[partida objectForKey:@"ciencias-contestadas"] integerValue]];
        [partidas setObject:cC forKey:@"ciencias-contestadas"];
        
        NSString *cA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-acertadas"] integerValue]+[[partida objectForKey:@"ciencias-acertadas"] integerValue]];
        [partidas setObject:cA forKey:@"ciencias-acertadas"];
        
        NSString *cP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ciencias-puntos"] integerValue]+[[partida objectForKey:@"ciencias-puntos"] integerValue]];
        [partidas setObject:cP forKey:@"ciencias-puntos"];

        NSString *dC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-contestadas"] integerValue]+[[partida objectForKey:@"deportes-contestadas"] integerValue]];
        [partidas setObject:dC forKey:@"deportes-contestadas"];
        
        NSString *dA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-acertadas"] integerValue]+[[partida objectForKey:@"deportes-acertadas"] integerValue]];
        [partidas setObject:dA forKey:@"deportes-acertadas"];
        
        NSString *dP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"deportes-puntos"] integerValue]+[[partida objectForKey:@"deportes-puntos"] integerValue]];
        [partidas setObject:dP forKey:@"deportes-puntos"];
        
        NSString *gC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-contestadas"] integerValue]+[[partida objectForKey:@"geografia-contestadas"] integerValue]];
        [partidas setObject:gC forKey:@"geografia-contestadas"];
        
        NSString *gA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-acertadas"] integerValue]+[[partida objectForKey:@"geografia-acertadas"] integerValue]];
        [partidas setObject:gA forKey:@"geografia-acertadas"];
        
        NSString *gP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"geografia-puntos"] integerValue]+[[partida objectForKey:@"geografia-puntos"] integerValue]];
        [partidas setObject:gP forKey:@"geografia-puntos"];
        
        NSString *hC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-contestadas"] integerValue]+[[partida objectForKey:@"historia-contestadas"] integerValue]];
        [partidas setObject:hC forKey:@"historia-contestadas"];
        
        NSString *hA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-acertadas"] integerValue]+[[partida objectForKey:@"historia-acertadas"] integerValue]];
        [partidas setObject:hA forKey:@"historia-acertadas"];
        
        NSString *hP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"historia-puntos"] integerValue]+[[partida objectForKey:@"historia-puntos"] integerValue]];
        [partidas setObject:hP forKey:@"historia-puntos"];

        NSString *oC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-contestadas"] integerValue]+[[partida objectForKey:@"ocio-contestadas"] integerValue]];
        [partidas setObject:oC forKey:@"ocio-contestadas"];
        
        NSString *oA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-acertadas"] integerValue]+[[partida objectForKey:@"ocio-acertadas"] integerValue]];
        [partidas setObject:oA forKey:@"ocio-acertadas"];
        
        NSString *oP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"ocio-puntos"] integerValue]+[[partida objectForKey:@"ocio-puntos"] integerValue]];
        [partidas setObject:oP forKey:@"ocio-puntos"];
        
        NSString *otrosC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-contestadas"] integerValue]+[[partida objectForKey:@"otros-contestadas"] integerValue]];
        [partidas setObject:otrosC forKey:@"otros-contestadas"];
        
        NSString *otrosA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-acertadas"] integerValue]+[[partida objectForKey:@"otros-acertadas"] integerValue]];
        [partidas setObject:otrosA forKey:@"otros-acertadas"];
        
        NSString *otrosP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"otros-puntos"] integerValue]+[[partida objectForKey:@"otros-puntos"] integerValue]];
        [partidas setObject:otrosP forKey:@"otros-puntos"];

        NSString *preguntasC=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-contestadas"] integerValue]+[[partida objectForKey:@"total-preguntas-contestadas"] integerValue]];
        [partidas setObject:preguntasC forKey:@"total-preguntas-contestadas"];
        
        NSString *preguntasA=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-acertadas"] integerValue]+[[partida objectForKey:@"total-preguntas-acertadas"] integerValue]];
        [partidas setObject:preguntasA forKey:@"total-preguntas-acertadas"];
        
        NSString *preguntasF=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"total-preguntas-falladas"] integerValue]+[[partida objectForKey:@"total-preguntas-falladas"] integerValue]];
        [partidas setObject:preguntasF forKey:@"total-preguntas-falladas"];

        NSString *preguntasP=[NSString stringWithFormat:@"%d",[[temp objectForKey:@"puntos-totales-conseguidos"] integerValue]+[[partida objectForKey:@"puntos-totales-conseguidos"] integerValue]];
        [partidas setObject:preguntasP forKey:@"puntos-totales-conseguidos"];

        NSString *error;
        NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *plistPath = [rootPath stringByAppendingPathComponent:@"datosPartidas.plist"];
        NSLog(@"PATH datosPartidas: %@",plistPath);
        
        NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:partidas
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                             errorDescription:&error];
        if(plistData) {
            [plistData writeToFile:plistPath atomically:YES];
        }
        else {
            NSLog(@"%@d",error);
        }

    }

}
@end
