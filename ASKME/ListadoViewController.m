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
    }
    
    jugadoresLabel.text=[NSString stringWithFormat:@"%d",[self.trabajarFicherosJason.listadoArray count]];
    contadorListado.text=[NSString stringWithFormat:@"%d",180-ApplicationDelegate.tiempoBase];

    PosicionLabel = [[NSMutableArray alloc]init];
    UsuarioLabel = [[NSMutableArray alloc] init];
    PuntuacionLabel = [[NSMutableArray alloc]init];
    
//    NSSortDescriptor * puntosDescriptor = [[NSSortDescriptor alloc] initWithKey:@"puntosConseguidos" ascending:NO];
//    
//    id obj;
//    NSEnumerator * enumerator = [self.trabajarFicherosJason.listadoArray objectEnumerator];
//    while ((obj = [enumerator nextObject])) NSLog(@"%@", obj);
//    
//    NSArray * descriptors = [NSArray arrayWithObjects:puntosDescriptor, nil];
//    NSArray * sortedArray = [self.trabajarFicherosJason.listadoArray sortedArrayUsingDescriptors:descriptors];
//    
//    NSLog(@"\nSorted ...");
//    
//    enumerator = [sortedArray objectEnumerator];
//    int i=0;
//    while ((obj = [enumerator nextObject])){
//        NSLog(@"%@", obj);
//        [PosicionLabel addObject:[NSString stringWithFormat:@"%d",i+1]];
//        [UsuarioLabel addObject:[obj objectForKey:@"nombre"]];
//        [PuntuacionLabel addObject:[obj objectForKey:@"puntosConseguidos"]];
//        i=i+1;
//    }
    
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

    
//    for (int i =0; i<self.trabajarFicherosJason.listadoArray.count; i++) {
//        [PosicionLabel addObject:@"1"];
//        [UsuarioLabel addObject:[[self.trabajarFicherosJason.listadoArray objectAtIndex:i] objectForKey:@"nombre"]];
//        [PuntuacionLabel addObject:[[self.trabajarFicherosJason.listadoArray objectAtIndex:i] objectForKey:@"puntosConseguidos"]];
//    }
    
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
        //ApplicationDelegate.opcionDeJuego = @"Jugadores";
        //ApplicationDelegate.numeroPartidaJugadores = [[array objectAtIndex:0] objectForKey:@"partida"];
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
    
    return  Cell;
}

- (IBAction)casaBoton:(id)sender
{
    //ApplicationDelegate.tiempoEsperaListadoPartida=@"16";
    ApplicationDelegate.opcionDeJuego = @"Jugador";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpcionesTapBar"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
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
    //ApplicationDelegate.tiempoPartidaJugadores = @"0";
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Tercera"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}


@end
