//
//  NickViewController.m
//  ASKME
//
//  Created by LUISMI on 08/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "NickViewController.h"

@interface NickViewController (){
    NSString *nick;
}

@end

@implementation NickViewController

@synthesize nickTextField,errorLabel;

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

#pragma mark - IBAction

- (IBAction)esconderTecladoNickTextField:(id)sender {
    [nickTextField resignFirstResponder];
}

- (IBAction)grabarNickBoton:(id)sender {
    NSString *miNick = [[NSString alloc]init];
    miNick = nickTextField.text;
    if (miNick.length>2 & miNick.length<21) {
        nick = miNick;
        [self guardarNickEnPlist];
        nick = @"";
        errorLabel.text = @"";
        nickTextField.text = @"";
    }else{
        errorLabel.text = @"Incorrecto";
        nickTextField.text = @"";
        nick = @"";
    }

}

- (IBAction)cancelarNickBoton:(id)sender {
    errorLabel.text = @"";
    nickTextField.text = @"";
}

#pragma mark - GuardarDatos

- (void) guardarNickEnPlist
{
    NSString *error;
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"usuario.plist"];
    NSLog(@"PATH: %@",plistPath);
    NSDictionary *plistDict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects: nick, nil]
                                                          forKeys:[NSArray arrayWithObjects: @"nombre_nick", nil]];
    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
                                                                   format:NSPropertyListXMLFormat_v1_0
                                                         errorDescription:&error];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
        [self pasarPantalla];
    }
    else {
        NSLog(@"%@d",error);
    }
}

-(void) pasarPantalla{
    UIStoryboard *storyboard = [UIApplication sharedApplication].delegate.window.rootViewController.storyboard;
    UIViewController *cambiarViewController = [storyboard instantiateViewControllerWithIdentifier:@"Inicio"];
    [self presentViewController:cambiarViewController animated:YES completion:nil];
    
}


@end
