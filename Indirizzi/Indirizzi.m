//
//  Indirizzi.m
//  Indirizzi
//
//  Created by max on 08/03/14.
//  Copyright (c) 2014 max. All rights reserved.
//

#import "Indirizzi.h"
#import "Indirizzo.h"
#import "sqlite3.h"

NSString *const KSQLDB=@"Indirizzi.sqlite3";

@implementation Indirizzi

-(id)init
{
    db=nil;
    _elenco=[[NSMutableArray alloc]init];
    return self;
}
-(long)ID
{
    return id;
}

-(NSString *)getDbPath
{
   NSString *percorso=[[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:KSQLDB];
    return percorso;
}

-(BOOL)checkDb
{
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    BOOL found=[fileMgr fileExistsAtPath:[self getDbPath]];
    return found;
}

-(sqlite3 *)Database
{
    if(db==nil) {
        if(![self checkDb])
            return nil;
        NSString *dbpath=[self getDbPath];
        if(sqlite3_open([dbpath UTF8String],&db)!=SQLITE_OK)
            return nil;
    }
    return db;
}

-(void)CloseDb;
{
    sqlite3_close([self Database]);
    db=nil;
}
-(NSMutableArray *)elencoIndirizzi
{
    [_elenco removeAllObjects];
    const char *sql="SELECT id,NomeCognome,Indirizzo,Telefono FROM Indirizzi";
    sqlite3_stmt *sqlStatement;
    
    if(sqlite3_prepare([self Database],sql,-1,&sqlStatement,NULL)!=SQLITE_OK)
        return nil;
    while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
        Indirizzo *indirizzo=[[Indirizzo alloc]init];
        
        indirizzo.id= sqlite3_column_int(sqlStatement, 0);
        indirizzo.nomecognome=[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
        indirizzo.indirizzo=[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
        indirizzo.telefono=[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,3)];
        [_elenco addObject:indirizzo];
        
    }
    [self CloseDb];
    return _elenco;
}

-(BOOL)Update:(Indirizzo *)indirizzo
{
    NSString *sql=@"UPDATE Indirizzi Set NomeCognome='%@',Indirizzo='%@',Telefono='%@' WHERE id=%d";
    sql=[NSString stringWithFormat:sql,indirizzo.nomecognome,indirizzo.indirizzo,indirizzo.telefono,indirizzo.id];
    if (sqlite3_exec([self Database], [sql cStringUsingEncoding:NSASCIIStringEncoding], NULL, NULL, nil) != SQLITE_OK)
    {
        return NO;
    }
    [self CloseDb];
    return YES;
}

/*-(BOOL)Inserimento:(Indirizzo *)indirizzo
{
    const char *errmsg;
    NSString *sql=@"INSERT INTO Indirizzi(NomeCognome,Indirizzo,Telefono) VALUES (\"%@\",\"%@\",\"%@\")";
    sql=[NSString stringWithFormat:sql,indirizzo.nomecognome,indirizzo.indirizzo,indirizzo.telefono,indirizzo.id];
    if (sqlite3_exec([self Database], [sql cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &errmsg) != SQLITE_OK)
    {
        return NO;
    }
    if(sqlite3_changes([self Database])!=1)
        return NO;
    [self CloseDb];
    return YES;
}*/

/*-(BOOL)Delete:(Indirizzo *)indirizzo
{
    const char *errmsg;
    NSString *sql=@"DELETE FROM Indirizzi WHERE id=%d";
    sql=[NSString stringWithFormat:sql,indirizzo.id];
    if (sqlite3_exec([self Database], [sql cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &errmsg) != SQLITE_OK)
    {
        return NO;
    }
    if(sqlite3_changes([self Database])!=1)
        return NO;
    [self CloseDb];
    return YES;
}*/

-(void)createIndirizzi
{
    const char *sql_stmt = "CREATE TABLE IF NOT EXISTS Indirizzi (ID INTEGER PRIMARY KEY AUTOINCREMENT, NomeCognome TEXT, Indirizzo TEXT, Telefono TEXT,Cellulare TEXT)";
    const char *errMsg;
    if (sqlite3_exec([self Database], sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
    {
        NSLog(@"Errore %s",errMsg);
    }
}
-(BOOL)Delete:(Indirizzo *)indirizzo
{
    sqlite3_stmt    *statement;
    NSString *sql=@"DELETE FROM Indirizzi WHERE id=%d";
    sql=[NSString stringWithFormat:sql,indirizzo.id];
    const char *cmdsql=[sql UTF8String];
    
    sqlite3_prepare_v2([self Database], cmdsql, -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
    {
        NSLog(@"%s",sqlite3_errmsg([self Database]));
        return NO;
    }
    sqlite3_finalize(statement);
    [self CloseDb];
    return YES;
}

-(BOOL)Inserimento:(Indirizzo *)indirizzo
{
    sqlite3_stmt *statement;
    NSString *sql=@"INSERT INTO Indirizzi(NomeCognome,Indirizzo,Telefono) VALUES (\"%@\",\"%@\",\"%@\")";
    sql=[NSString stringWithFormat:sql,indirizzo.nomecognome,indirizzo.indirizzo,indirizzo.telefono];
    const char *cmdsql=[sql UTF8String];
    
    sqlite3_prepare_v2([self Database], cmdsql, -1, &statement, NULL);
     if (sqlite3_step(statement) != SQLITE_DONE)
    {
        NSLog(@"%s",sqlite3_errmsg([self Database]));
        return NO;
    }
    sqlite3_finalize(statement);
    [self CloseDb];
    return YES;
}

-(void)Save:(Indirizzo *)indirizzo inserimento:(BOOL)insert
{
    [self createIndirizzi];
    if(insert)
        [self Inserimento:indirizzo];
    else
        [self Update:indirizzo];
}
@end
