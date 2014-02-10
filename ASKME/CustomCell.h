//
//  CustomCell.h
//  LMCustomCell
//
//  Created by LUISMI on 24/11/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *PosicionUsuarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *NombreUsuarioLabel;
@property (weak, nonatomic) IBOutlet UILabel *PuntuacionUsuarioLabel;

@end
