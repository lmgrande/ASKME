//
//  SegundaViewController.h
//  ASKME
//
//  Created by LUISMI on 12/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegundaViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *preguntasArray;

#pragma mark - Metodos

- (void) recogerDatos;

@end
