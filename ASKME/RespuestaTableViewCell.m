//
//  RespuestaTableViewCell.m
//  ASKME
//
//  Created by LUISMI on 26/12/13.
//  Copyright (c) 2013 LUISMI. All rights reserved.
//

#import "RespuestaTableViewCell.h"
#import "PreguntasViewController.h"

@implementation RespuestaTableViewCell
@synthesize puntoVerdeView,respuestaLabel,acertada,parentViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // background view
        UIImageView *theBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fondo_deg_gris_celda.png"]];
        self.backgroundView = theBackgroundView;
        // cell respuesta label
        respuestaLabel = [[UILabel alloc] init];
        respuestaLabel.frame = CGRectMake(54, 0, 240, 46);
        [respuestaLabel setBackgroundColor:[UIColor clearColor]];
        [respuestaLabel setFont:[UIFont fontWithName:@"Helvetica Neue" size:12]];
        [respuestaLabel setTextColor:[UIColor blackColor]];
        //punto verde
        puntoVerdeView = [[UIImageView alloc]init];
        puntoVerdeView.frame = CGRectMake(18, 11, 18, 18);
        //set up contentView
        [self.contentView addSubview:respuestaLabel];
        [self.contentView addSubview:puntoVerdeView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state

}

@end
