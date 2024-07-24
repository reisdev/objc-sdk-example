//
//  SDKTests.m
//  sdk-json
//
//  Created by Matheus Jesus on 24/07/2024.
//

#import <XCTest/XCTest.h>
#import "sdk-json/SDK.h"

@interface SDKTests : XCTestCase

- (void) testGetPokemon;

@end

@implementation SDKTests


- (void)testGetPokemon {

    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Method Works!"];

    NSMutableDictionary<NSString*, NSNumber*>* dict = [NSMutableDictionary new];

    [dict setValue:@35 forKey:@"id"];

    NSError* error;
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict
                                    options:0
                                      error:&error];


    [SDK getPokemon:data withResultClosure:^(NSData * data, NSError * error) {
        NSDictionary* response = [NSJSONSerialization JSONObjectWithData: data
                                                                 options: 0
                                                                   error: &error];
        if(error != nil) {
            NSLog(@"%@", error);
        } else {
            XCTAssertTrue([[response valueForKey: @"name"] isEqual: @"clefairy"]);
            [expectation fulfill];
        }
    }];

    [self waitForExpectationsWithTimeout:5 handler:^(NSError * _Nullable error) {
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
    }];
}

@end
