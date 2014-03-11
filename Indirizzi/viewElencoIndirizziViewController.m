//
//  viewElencoIndirizziViewController.m
//  Indirizzi
//
//  Created by max on 08/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import "viewElencoIndirizziViewController.h"
#import "Indirizzi.h"
#import "Indirizzo.h"
#import "cCell.h"

@interface viewElencoIndirizziViewController ()

@end

@implementation viewElencoIndirizziViewController

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
    indirizzi=[[Indirizzi alloc]init];
    elenco=[indirizzi elencoIndirizzi];
    isdelete=NO;
    conferma=NO;
    [_btnAdd setEnabled:YES];
    [_btnDelete setEnabled:YES];
    [_btnConferma setEnabled:NO];
    [_btnChiudi setEnabled:NO];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return elenco.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CorpiIdentifier;
    
    if(isdelete==YES)
        CorpiIdentifier=@"CellDelete";
    else
        CorpiIdentifier=@"Cell";
    cCell *cell = [_table dequeueReusableCellWithIdentifier:CorpiIdentifier];
    
    if (cell == nil) {
        cell = [[cCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CorpiIdentifier];
    }
    
    Indirizzo *indirizzo=[elenco objectAtIndex:indexPath.row];
    if(isdelete==NO) {
        [cell.txnomecognome setText:indirizzo.nomecognome];
        cell.indirizzo=indirizzo;
    } else {
        [cell.lbnomecongome setText:indirizzo.nomecognome];
        [cell.swdelete setOn:NO];
        cell.indirizzo=indirizzo;
    }
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     if ([segue.identifier isEqualToString:@"segueIndirizzo"]) {
        NSIndexPath *path;
        path = [_table indexPathForSelectedRow];
        VwIndirizzo *vIndirizzo= [segue destinationViewController];
        vIndirizzo.indirizzo=[elenco objectAtIndex:path.row];
        vIndirizzo.isnew=NO;
         [_table reloadData];
     }
    if ([segue.identifier isEqualToString:@"segueInserimento"]) {
        NSIndexPath *path;
        path = [_table indexPathForSelectedRow];
        VwIndirizzo *vIndirizzo= [segue destinationViewController];
        vIndirizzo.isnew=YES;
        [_table reloadData];
    }
}
- (IBAction)delete:(id)sender {
    if(isdelete==NO) {
        isdelete=YES;
        [_btnAdd setEnabled:NO];
        [_btnDelete setEnabled:NO];
        [_btnConferma setEnabled:YES];
        [_btnChiudi setEnabled:YES];
    } else {
        isdelete=NO;
        [_btnAdd setEnabled:YES];
        [_btnDelete setEnabled:YES];
        [_btnConferma setEnabled:NO];
        [_btnChiudi setEnabled:NO];
    }
    [_table reloadData];
}
- (IBAction)bntConferma:(id)sender {
    isdelete=NO;
    conferma=YES;
    [_btnAdd setEnabled:YES];
    [_btnDelete setEnabled:YES];
    [_btnConferma setEnabled:NO];
    [_btnChiudi setEnabled:NO];
    
    for(cCell *cell in _table.visibleCells)
    {
        if(cell.swdelete.on==YES) {
            Indirizzo *indirizzo=cell.indirizzo;
            Indirizzi *oindirizzi=[[Indirizzi alloc]init];
            [oindirizzi Delete:indirizzo];
        }
    }
    [_table reloadData];
}

- (IBAction)btnChiudi:(id)sender {
    isdelete=NO;
    [_btnAdd setEnabled:YES];
    [_btnDelete setEnabled:YES];
    [_btnConferma setEnabled:NO];
    [_btnChiudi setEnabled:NO];
       [_table reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    elenco=[indirizzi elencoIndirizzi];
    [_table reloadData];
}
@end
