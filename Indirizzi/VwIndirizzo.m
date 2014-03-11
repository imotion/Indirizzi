//
//  VwIndirizzo.m
//  Indirizzi
//
//  Created by max on 09/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import "VwIndirizzo.h"
#import "Indirizzi.h"

@interface VwIndirizzo ()

@end

@implementation VwIndirizzo

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	if(_isnew==NO) {
        [_txcognome setText:_indirizzo.nomecognome];
        [_txindirizzo setText:_indirizzo.telefono];
        [_txtelefono setText:_indirizzo.indirizzo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)exit:(id)sender {
    [self dismissViewControllerAnimated:YES completion: nil];
}

- (IBAction)Save:(id)sender {
    Indirizzi *indirizzi=[[Indirizzi alloc]init];
    if(_isnew==NO) {
        _indirizzo.nomecognome=_txcognome.text;
        _indirizzo.indirizzo=_txtelefono.text;
        _indirizzo.telefono=_txindirizzo.text;
        [indirizzi Save:_indirizzo inserimento:NO];
        [self dismissViewControllerAnimated:YES completion: nil];
    } else {
        Indirizzo *indirizzo=[[Indirizzo alloc]init];
        indirizzo.nomecognome=_txcognome.text;
        indirizzo.indirizzo=_txtelefono.text;
        indirizzo.telefono=_txindirizzo.text;
        [indirizzi Save:indirizzo inserimento:YES];
        [self dismissViewControllerAnimated:YES completion: nil];
    }
}

@end
