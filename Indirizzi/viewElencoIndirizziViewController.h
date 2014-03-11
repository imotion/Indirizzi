//
//  viewElencoIndirizziViewController.h
//  Indirizzi
//
//  Created by max on 08/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Indirizzo.h"
#import "Indirizzi.h"
#import "VwIndirizzo.h"

@interface viewElencoIndirizziViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *elenco;
    Indirizzi *indirizzi;
    BOOL isdelete;
    BOOL conferma;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnDelete;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnAdd;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnConferma;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnChiudi;

@end
