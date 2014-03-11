//
//  Indirizzi.h
//  Indirizzi
//
//  Created by max on 08/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Indirizzo.h"

@interface Indirizzi : NSObject {
    long id;
    sqlite3 *db;
}

@property(strong,nonatomic) NSMutableArray *elenco;
@property(strong,nonatomic) NSString *codice;
@property(strong,nonatomic) NSString *indirizzo;
@property(strong,nonatomic) NSString *nomecognome;
@property(strong,nonatomic) NSString *telefono;

-(long)ID;
-(NSMutableArray *)elencoIndirizzi;
-(void)Save:(Indirizzo *)indirizzo inserimento:(BOOL)insert;
-(BOOL)Delete:(Indirizzo *)indirizzo;
@end
