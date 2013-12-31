//
//  RespuestaTableViewCell.h
//  ASKME
//
//  Created by LUISMI on 26/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespuestaTableViewCell : UITableViewCell

@property (weak) UIViewController *parentViewController;
@property (nonatomic, strong) UIImageView *puntoVerdeView;
@property (nonatomic, strong) UILabel *respuestaLabel;
@property (nonatomic) BOOL acertada;

@end
