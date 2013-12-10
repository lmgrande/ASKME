//
//  ViewController.h
//  ASKME
//
//  Created by LUISMI on 02/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAlertViewDelegate>
{
    NSTimer *timer;
}

@property (strong, nonatomic) NSString *nickNombre;

- (void) leerUsuarioPlist;

@end
