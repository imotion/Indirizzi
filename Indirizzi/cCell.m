//
//  cCell.m
//  Indirizzi
//
//  Created by Massimiliano Gorreri on 10/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import "cCell.h"

@implementation cCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       [_swdelete setSelected:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
