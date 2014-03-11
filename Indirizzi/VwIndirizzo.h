//
//  VwIndirizzo.h
//  Indirizzi
//
//  Created by max on 09/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Indirizzo.h"

@interface VwIndirizzo : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txcognome;
@property (weak, nonatomic) IBOutlet UITextField *txtelefono;
@property (weak, nonatomic) IBOutlet UITextField *txindirizzo;
@property(nonatomic,assign) BOOL isnew;
@property(strong,nonatomic) Indirizzo *indirizzo;
@end
