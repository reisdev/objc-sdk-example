//
//  sdk_json.h
//  sdk-json
//
//  Created by Matheus Jesus on 24/07/2024.
//

#import <Foundation/Foundation.h>

@interface SDK : NSObject

+ (void)getPokemon:(NSData *)data withResultClosure:(void (^)(NSData*, NSError*))completion;

@end
