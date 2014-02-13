//
//  ListadoViewController.m
//  ASKME
//
//  Created by LUISMI on 05/02/14.
//  Copyright (c) 2014 LUISMI. All rights reserved.
//

#import "ListadoViewController.h"
#import "CustomCell.h"
#import "TrabajarConFicherosJason.h"


@interface ListadoViewController ()
{
    NSMutableArray *PosicionLabel;
    NSMutableArray *UsuarioLabel;
    NSMutableArray *PuntuacionLabel;
    
    NSMutableArray *usuariosSeleccionados;
}

@property TrabajarConFicherosJason *trabajarFicherosJason;

@end

@implementation ListadoViewController
{
    NSTimer *timerParaEmpezarJugadores;
    float tiempoRestante;
}


@synthesize tableData, jugadoresLabel,contadorListado;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.trabajarFicherosJason = [[TrabajarConFicherosJason alloc]init];
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    BOOL guardadoJason = [self.trabajarFicherosJason recogerYGrabarDatosEnFicheroJSON:@"http://www.askmeapp.com/php_IOS/leerListadoJson.php" andNombreFichero:@"listadoPartida.json"];
    
    if (!guardadoJason) {
        NSLog(@"No se ha podido grabar el fichero JASON");
    }else{
        [self.trabajarFicherosJason sacarDatosListadoJSON];
        usuariosSeleccionados=[self leerSeleccionadosListadoPlist];
    }
    
    jugadoresLabel.text=[NSString stringWithFormat:@"%d",[self.trabajarFicherosJason.listadoArray count]];
    contadorListado.text=[NSString stringWithFormat:@"%d",180-ApplicationDelegate.tiempoBase];

    PosicionLabel = [[NSMutableArray alloc]init];
    UsuarioLabel = [[NSMutableArray alloc] init];
    PuntuacionLabel = [[NSMutableArray alloc]init];
    
    NSSortDescriptor * puntosDescriptor = [[NSSortDescriptor alloc] initWithKey:@"puntosConseguidos" ascending:NO comparator:^(id obj1, id obj2)
                                           {
                                               return [obj1 compare:obj2 options:NSNumericSearch];
                                           }
                                        ];
    
    NSArray *sortDescriptors = @[puntosDescriptor];
    NSArray * sortedArray = [self.trabajarFicherosJason.listadoArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"\nSorted ...");
    
    [sortedArray enumerateObjectsUsingBlock: ^(id objeto, NSUInteger indice, BOOL *stop) {
        // Hacemos lo que queramos con el objeto
    
        NSLog(@"%@", sortedArray);
        [PosicionLabel addObject:[NSString stringWithFormat:@"%d",indice+1]];
        [UsuarioLabel addObject:[[sortedArray objectAtIndex:indice] objectForKey:@"nombre"]];
        [PuntuacionLabel addObject:[[sortedArray objectAtIndex:indice] objectForKey:@"puntosConseguidos"]];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSURL *url = [NSURL URLWithString:@"http://www.askmeapp.com/RestoEntero.php"];
    
    NSError *error = nil; // This so that we can access the error if something goes wrong
    NSData *jsonData = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:&error];
    
    NSError *error1;
    
    // array of dictionary
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error1];
    
    if (error1) {
        NSLog(@"Error: %@", error1.localizedDescription);
    } else {
        tiempoRestante = [[[array objectAtIndex:0] objectForKey:@"tiempo"]floatValue];
        NSLog(@"partida:%@ tiempo:%@",[[array objectAtIndex:0] objectForKey:@"partida"],[[array objectAtIndex:0] objectForKey:@"tiempo"]);
        [self empezar];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos de TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return PosicionLabel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *Cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!Cell) {
        Cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    Cell.PosicionUsuarioLabel.text = [PosicionLabel objectAtIndex:indexPath.row];
    Cell.NombreUsuarioLabel.text = [UsuarioLabel objectAtIndex:indexPath.row];
    Cell.PuntuacionUsuarioLabel.text = [PuntuacionLabel objectAtIndex:indexPath.row];
    
    for (int i=0; i<usuariosSeleccionados.count; i++) {
        //NSLog(@"PosicionUsuarioLabel: %@ ",Cell.PosicionUsuarioLabel.text);
        if ([Cell.NombreUsuarioLabel.text isEqualToString:[usuariosSeleccionados objectAtIndex:i]]) {
            Cell.marcaSeleccionarJugador.tag=1;
            Cell.marcaSeleccionarJugador.image=[UIImage imageNamed:@"boton_celda_listado_on.png"];
        }
    }
    
    return  Cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *Cell = (CustomCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    if (Cell.marcaSeleccionarJugador.tag==0) {
        [usuariosSeleccionados addObject:Cell.NombreUsuarioLabel.text];
        Cell.marcaSeleccionarJugador.tag=1;
        Cell.marcaSeleccionarJugador.image=[UIImage imageNamed:@"boton_celda_listado_on.png"];
    }else if (Cell.marcaSeleccionarJugador.tag==1){
        for (int i=0; i<usuariosSeleccionados.count; i++) {
            //NSLog(@"PosicionUsuarioLabel: %@ ",Cell.PosicionUsuarioLabel.text);
            if (![Cell.NombreUsuarioLabel.text isEqualToString:[ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"]]) {
                if ([Cell.NombreUsuarioLabel.text isEqualToString:[usuariosSeleccionados objectAtIndex:i]]) {
                    [usuariosSeleccionados removeObjectAtIndex:i];
                    Cell.marcaSeleccionarJugador.tag=0;
                    Cell.marcaSeleccionarJugador.image=[UIImage imageNamed:@"boton_celda_listado_off.png"];
                }
            }
        }
    }
    
//    Pregunta *preguntaActual = [self.trabajarFicherosJason.preguntasArray objectAtIndex:j-1];
//    
//    if ([[tableData objectAtIndex:indexPath.row] isEqualToString:preguntaActual.textoCorrecta]) {
//        Cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo_deg_verde_celda.png"]];
//        acertada=YES;
//    }else{
//        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo_deg_rojo_celda.png"]];
//        acertada=NO;
//    }
//    for (int i=0; i<tableData.count; i++) {
//        if ([[tableData objectAtIndex:i] isEqualToString:preguntaActual.textoCorrecta]) {
//            RespuestaTableViewCell *cell1 =(RespuestaTableViewCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//            cell1.puntoVerdeView.image=[UIImage imageNamed:@"punto-verde-correcta.png"];
//        }
//    }
//    tableView.allowsSelection = NO;
//    segundosParaPuntos=[numerosContadorLabel.text intValue];
//    numerosContadorLabel.hidden=YES;
//    proximaPreguntaButton.hidden=NO;
//    [self calcularPuntos];
}


- (IBAction)casaBoton:(id)sender
{
    [timerParaEmpezarJugadores invalidate];
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    [self grabarSeleccionadosListadoPlist:usuariosSeleccionados];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
}

- (IBAction)mostrarSoloJugadoresSeleccionadosBoton:(id)sender {
    NSLog(@"Jugadores Selececionados: %@",usuariosSeleccionados);
}

#pragma mark - pasarPantalla

- (void) empezar{
    
    timerParaEmpezarJugadores = [NSTimer scheduledTimerWithTimeInterval:1         // El timer se ejcuta cada segundo
                                             target:self        // Se ejecuta este timer en este view
                                           selector:@selector(proximaPartida)      // Se ejecuta el método contar
                                           userInfo:nil
                                            repeats:YES];
}

-(void)proximaPartida
{
    if (ApplicationDelegate.tiempoBase==180) {
        [self pasarPantalla];
    } else {
        contadorListado.text=[NSString stringWithFormat:@"%d",180-ApplicationDelegate.tiempoBase];
    }
}

-(void) pasarPantalla{
    [timerParaEmpezarJugadores invalidate];
    [self grabarSeleccionadosListadoPlist:usuariosSeleccionados];
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Tercera"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}

#pragma mark - leer y grabar Datos en Plist

- (NSMutableArray*)leerSeleccionadosListadoPlist{
    
    // instanciamos el filemanager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // obtenemos la ruta de la carpeta Documents
    NSArray *appPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [appPaths objectAtIndex:0];
    
    NSString *plistPath = [documentPath stringByAppendingPathComponent:@"seleccionadosListado.plist"];
    
    // comprobamos si el plist ya existe en la carpeta documents
    BOOL success = [fileManager fileExistsAtPath:plistPath];
    NSMutableArray *plistContent = [[NSMutableArray alloc]initWithObjects:[ApplicationDelegate.configuracionUsuario objectForKey:@"nombre_nick"], nil];
    if (success)
    {
        // si ya existe metemos el contenido en un array
        plistContent = [NSMutableArray arrayWithContentsOfFile:plistPath];
    }
    else {
        // si no existe copiamos el plist vacío desde nuestro bundle
        //NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"seleccionadosListado" ofType:@"plist"];
        
        // copiamos el plist a la carpeta documents
        success = [fileManager createFileAtPath:plistPath contents:nil attributes:nil];
        if (success)
        {
            // si todo fue bien metemos el contenido del NSMutableArray plistContent en seleccionadosListado.plist
            [plistContent writeToFile:plistPath atomically: YES];
        }
    }
    return plistContent;
}

-(void)grabarSeleccionadosListadoPlist:(NSMutableArray*)seleccionadosListado
{
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"seleccionadosListado.plist"];
    NSLog(@"PATH seleccionadosListado: %@",plistPath);
    
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:usuariosSeleccionados
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"%@d",error);
    }

}


@end
