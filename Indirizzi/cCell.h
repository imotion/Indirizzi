//
//  cCell.h
//  Indirizzi
//
//  Created by Massimiliano Gorreri on 10/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Indirizzi.h"
#import "Indirizzo.h"

@interface cCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txnomecognome;
@property (weak, nonatomic) IBOutlet UILabel *lbnomecongome;
@property (weak, nonatomic) IBOutlet UISwitch *swdelete;
@property (strong,nonatomic) Indirizzo *indirizzo;
@end
