//
//  PreguntasViewController.m
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "PreguntasViewController.h"
#import "TrabajarConFicherosJason.h"
#import "Pregunta.h"
#import "GestionarDatosYPuntosPartida.h"
#import <math.h>
#import "RespuestaTableViewCell.h"

@interface PreguntasViewController ()
{
    Pregunta *miPreguntaMateria;
    
    CGFloat contador;
    NSTimer *timerPartida;
    NSTimer *timerPregunta;
    int numero,j,segundosParaPuntos;
    BOOL acertada;
    
}
@property GestionarDatosYPuntosPartida *datosPuntosPartida;
@property TrabajarConFicherosJason *trabajarFicherosJason;

@end

@implementation PreguntasViewController

@synthesize nickLabel, tableData, preguntaLinearProgressView, partidaLinearProgressView, contadorGrafico, numerosContadorLabel, preguntaLabel, preguntasTableView, totalPreguntasPartida,numeroPreguntaActualPartida, puntosPreguntaLabel, puntosMaximosPartida, puntosAcumuladosLabel,preguntasAcertadasLabel, preguntasFalladasLabel, preguntasNoContestadasLabel, iconoPreguntaUIImageView, materiaPreguntaLabel, fondoPiePreguntaImageView, proximaPreguntaButton;

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
    self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
    self.datosPuntosPartida = [[GestionarDatosYPuntosPartida alloc]init];
    [self.datosPuntosPartida inicializarPartida];
    [self.datosPuntosPartida inicializarPartidas];
    
    
    nickLabel.text = [ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"];
    proximaPreguntaButton.hidden=YES;
    
    if ([ApplicationDelegate.opcionDeJuego isEqualToString:@"Jugador"]) {
        partidaLinearProgressView.progress = 0.0;
    }else{
        if (ApplicationDelegate.tiempoBase>140) {
            partidaLinearProgressView.progress = 0.0;
        }else{
            float inicioBarraPartida = ((ApplicationDelegate.tiempoBase*270)/144)/270.0;
            NSLog(@"inicioBarraPartida: %f", inicioBarraPartida);
            partidaLinearProgressView.progress = inicioBarraPartida;
        }
    }
    preguntaLinearProgressView.progress = 0.0;
    [self performSelectorOnMainThread:@selector(moverProgressBarPartida) withObject:nil waitUntilDone:NO];
    numero = 16;
    j=0;
    self.datosPuntosPartida.puntosTotalesPartida=0;
    self.datosPuntosPartida.preguntasAcertadas=0;
    self.datosPuntosPartida.preguntasFalladas=0;
    self.datosPuntosPartida.preguntasNoContestadas=0;
    
    [self.trabajarFicherosJason sacarDatosFicheroJSON];
    totalPreguntasPartida.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.trabajarFicherosJason.preguntasArray.count];
    puntosMaximosPartida.text =[NSString stringWithFormat:@"%lu", 12*(unsigned long)self.trabajarFicherosJason.preguntasArray.count];
    
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
    
    Pregunta *preguntaActual = [self.trabajarFicherosJason.preguntasArray objectAtIndex:j-1];
    
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

#pragma mark - cargar Preguntas

- (void)cargarPregunta
{
    miPreguntaMateria = [self.trabajarFicherosJason.preguntasArray objectAtIndex:j];
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
    
    NSArray *opcionesMateria;
    
    opcionesMateria = [self.datosPuntosPartida comprobarMateria:miPreguntaMateria.textoMateria];
    
    fondoPiePreguntaImageView.image = [UIImage imageNamed:[opcionesMateria objectAtIndex:0]];
    iconoPreguntaUIImageView.image = [UIImage imageNamed:[opcionesMateria objectAtIndex:1]];
    materiaPreguntaLabel.text = [opcionesMateria objectAtIndex:2];
    
    j++;
    
    numeroPreguntaActualPartida.text = [NSString stringWithFormat:@"%d", j];
}

#pragma mark - métodos IBAction

- (IBAction)casaBoton:(id)sender
{
    [timerPregunta invalidate];
    [timerPartida invalidate];
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)proximaPregunta:(id)sender
{
    [timerPregunta invalidate];
    contador=0;
    contadorGrafico.backgroundColor = [UIColor clearColor];
    numerosContadorLabel.text = @"16";
    numero = 16;
    [self empezarContadorPregunta];
}

#pragma mark - métodos circulo contador

- (void) empezarContadorPregunta{
    preguntasTableView.allowsSelection = YES;
    proximaPreguntaButton.hidden=YES;
    puntosPreguntaLabel.text = @"0";
    
    if (j==self.trabajarFicherosJason.preguntasArray.count) {
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
    float newProgress = [self.preguntaLinearProgressView progress] + 0.00625;
    [self.preguntaLinearProgressView setProgress:newProgress animated:YES];
    
    //while (j<json.count) {
    if (contador<160) {
        
        contadorGrafico.colorRellenoContador = [UIColor grayColor];
        contador++;
        float intcontador = (int) contador;
        float segundo = fmodf(intcontador, 10.0);
        if (segundo==0) {
            numero--;
            if (numero==0) {
                NSString *numeroContador = [NSString stringWithFormat:@"%d", 16];
                numerosContadorLabel.text = numeroContador;
            }else{
                NSString *numeroContador = [NSString stringWithFormat:@"%d", numero];
                numerosContadorLabel.text = numeroContador;
            }
            
        }
        if (numerosContadorLabel.hidden==NO) {
            contadorGrafico.comenzar=90;
            contadorGrafico.finalizar=90+(contador*2.25);
            [contadorGrafico setNeedsDisplay];
        }
    }else{
        
        [timerPregunta invalidate];
        contador=0;
        contadorGrafico.backgroundColor = [UIColor clearColor];
        numerosContadorLabel.text = @"16";
        numero = 16;
        
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
        self.datosPuntosPartida.preguntasNoContestadas++;
    } else {
        if (acertada==NO) {
            puntosPregunta=-2;
            self.datosPuntosPartida.preguntasFalladas++;
        } else if (acertada==YES){
            self.datosPuntosPartida.preguntasAcertadas++;
            if(segundosParaPuntos<5){
                puntosPregunta=6;
            }else if(segundosParaPuntos<9){
                puntosPregunta=8;
            }else if(segundosParaPuntos<13){
                puntosPregunta=10;
            }else if(segundosParaPuntos<=16){
                puntosPregunta=12;
            }
        }
        
        [self.datosPuntosPartida acumularPuntosAciertos:miPreguntaMateria.textoMateria andAcertada:acertada andPuntosPregunta:puntosPregunta];
        
    }
    
    self.datosPuntosPartida.puntosTotalesPartida = self.datosPuntosPartida.puntosTotalesPartida+puntosPregunta;
    puntosPreguntaLabel.text = [NSString stringWithFormat:@"%d",puntosPregunta];
    puntosAcumuladosLabel.text = [NSString stringWithFormat:@"%ld",(long)self.datosPuntosPartida.puntosTotalesPartida];
    preguntasAcertadasLabel.text = [NSString stringWithFormat:@"%d",self.datosPuntosPartida.preguntasAcertadas];
    preguntasNoContestadasLabel.text = [NSString stringWithFormat:@"%d",self.datosPuntosPartida.preguntasNoContestadas];
    preguntasFalladasLabel.text = [NSString stringWithFormat:@"%d",self.datosPuntosPartida.preguntasFalladas];
    
}

- (void) empezarContadorPartida
{
    float tiempoPartida;
    if ([ApplicationDelegate.opcionDeJuego isEqualToString:@"Jugador"]) {
        tiempoPartida=148;
    }else{
        if (ApplicationDelegate.tiempoBase==180) {
            tiempoPartida=144.0;
        }else{
            tiempoPartida=144-ApplicationDelegate.tiempoBase;
        }
    }
    NSLog(@"ApplicationDelegate.tiempoPartidaJugadores: %f",tiempoPartida);
    timerPartida = [NSTimer scheduledTimerWithTimeInterval:tiempoPartida         // El timer se ejcuta cada segundo
                                                    target:self        // Se ejecuta este timer en este view
                                                  selector:@selector(pasarPantalla)      // Se ejecuta el método contar
                                                  userInfo:nil
                                                   repeats:NO];
}

-(void) pasarPantalla
{
    if (preguntasTableView.indexPathForSelectedRow==nil && ([numeroPreguntaActualPartida.text integerValue]<[totalPreguntasPartida.text integerValue])) {
        segundosParaPuntos=0;
        [self calcularPuntos];
    }
    
    self.datosPuntosPartida.totalPreguntasPartida = [totalPreguntasPartida.text integerValue];
    self.datosPuntosPartida.puntosMaximosPartida = [puntosMaximosPartida.text integerValue];
    self.datosPuntosPartida.totalPreguntasContestadas = [numeroPreguntaActualPartida.text integerValue];
    
    [self.datosPuntosPartida grabarDatosPartidaPlist];
    
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
        [NSTimer scheduledTimerWithTimeInterval:1.44 target:self selector:@selector(moverProgressBarPartida) userInfo:nil repeats:NO];
    }
}



@end
