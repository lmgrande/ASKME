//
//  PreguntasViewController.h
//  ASKME
//
//  Created by LUISMI on 15/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreguntasViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate>
//{
//    NSArray *tableData;
//}
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;

@property (nonatomic, strong) NSArray *tableData;

@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *preguntasArray;

- (IBAction)casaBoton:(id)sender;

#pragma mark - Metodos

- (void) sacarDatosFicheroJSON;

@end
