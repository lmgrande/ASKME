//
//  NickViewController.h
//  ASKME
//
//  Created by LUISMI on 08/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NickViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

- (IBAction)esconderTecladoNickTextField:(id)sender;

- (IBAction)grabarNickBoton:(id)sender;
- (IBAction)cancelarNickBoton:(id)sender;

@end
