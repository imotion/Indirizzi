//
//  Indirizzo.h
//  Indirizzi
//
//  Created by max on 08/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Indirizzo : NSObject

@property(nonatomic,assign) NSInteger id;
@property(strong,nonatomic) NSString *codice;
@property(strong,nonatomic) NSString *indirizzo;
@property(strong,nonatomic) NSString *nomecognome;
@property(strong,nonatomic) NSString *telefono;

@end
