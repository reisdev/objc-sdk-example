//
//  sdk_json.m
//  sdk-json
//
//  Created by Matheus Jesus on 24/07/2024.
//

#import "SDK.h"

@implementation SDK

+ (void)getPokemon:(NSData *)data withResultClosure:(void (^)(NSData*, NSError*))completion {
    /// Parse `NSData` to a `NSDictionary`
    NSError* error = nil;

    id object = [NSJSONSerialization
                 JSONObjectWithData: data
                 options: 0
                 error: &error];

    /// Check if the data could be parsed
    if([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary* input = object;

        NSString* id = [input valueForKey: @"id"];

        if(id == nil) {
            NSError* error = [SDK generateError: @"Missing attribute 'id'"
                                       withCode:400];
            completion(nil, error);
            return;
        }

        NSURL* url = [NSURL
                      URLWithString: [NSString
                                      stringWithFormat: @"https://pokeapi.co/api/v2/pokemon/%@/", id]];

        NSURLSessionTask* task = [SDK requestWithUrl: url
             withCompletion: ^(NSData* _Nullable data,
                               NSURLResponse* _Nullable response,
                               NSError* _Nullable error) {
            if(error != nil) {
                completion(nil, error);
                return;
            }

            if(response == nil) {
                NSError* error = [SDK generateError: @"Empty response"
                                           withCode:400];
                completion(nil, error);
                return;
            }

            if(data == nil) {
                NSError* error = [SDK generateError: @"Empty data"
                                           withCode:400];
                completion(nil, error);
                return;
            }

            completion(data, nil);
        }];

        [task resume];
    } else {
        NSError* error = [SDK generateError: @"The data couldn't be serialized"
                                   withCode:400];
        completion(nil, error);
    }

}

+ (NSError*)generateError:(NSString*)message withCode:(NSInteger)code {
    return [NSError
            errorWithDomain: @"sibs.sdk-json"
            code:code
            userInfo:@{NSLocalizedDescriptionKey:message}];
}

+ (NSURLSessionTask*) requestWithUrl:(NSURL*)url withCompletion:(void (^)(NSData*,NSURLResponse*,NSError*))completion {
    return [[NSURLSession sharedSession] dataTaskWithURL: url
                                 completionHandler: completion];
}

@end
