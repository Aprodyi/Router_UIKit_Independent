//
//  NetworkRequest.m
//  Final_Project_MVP
//
//  Created by Вова on 10.05.2019.
//  Copyright © 2019 Вова. All rights reserved.
//

#import "SBSNetworkRequest.h"

@interface SBSNetworkRequest () <NSURLSessionDelegate>

@end

@implementation SBSNetworkRequest

NSString *boundary = @"---------BOUNDARY---------";

- (void)networkRequestWithEndpoint:(NSString *)endpoint
{
    NSString *urlString = [self getURLStringForEndpoint:endpoint];
    NSData *body = [self getBodyForEndpoint:endpoint];
    NSString *authValue = [self getAuthValue];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-type"];
    [request addValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:body];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (httpResponse.statusCode != 200)
        {
            NSLog(@"Ошибка, с кодом - %ld", httpResponse.statusCode);
            if (error != nil)
            {
                NSLog(@"Ошибка URLSession - %@", [error localizedDescription]);
            }
        }
        else
        {
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([endpoint isEqualToString:@"Tags"])
                {
                    [self.model loadingTagsIsDoneWithData:responseDictionary];
                }
                if ([endpoint isEqualToString:@"Categories"])
                {
                    [self.model loadingCategoriesIsDoneWithData:responseDictionary];
                }
                if ([endpoint isEqualToString:@"Crop"])
                {
                    [self.model loadingCropImageIsDoneWithData:responseDictionary];
                }
                if ([endpoint isEqualToString:@"Colors"])
                {
                    [self.model loadingColorsIsDoneWithData:responseDictionary];
                }
            });
        }
    }];
    [postDataTask resume];
}

- (NSString *)getAuthValue
{
    NSString *login = @"acc_ad7cf76fba2a73d";
    NSString *password = @"b7e63296f7d3b70227879c6439842173";
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", login, password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodedStringWithOptions:0]];
    return authValue;
}

- (NSString *)getURLStringForEndpoint:(NSString *)endpoint
{
    NSString *urlString;
    
    if ([endpoint isEqualToString:@"Tags"])
    {
        urlString = @"https://api.imagga.com/v2/tags";
    }
    if ([endpoint isEqualToString:@"Categories"])
    {
        urlString = @"https://api.imagga.com/v2/categories/personal_photos";
    }
    if ([endpoint isEqualToString:@"Crop"])
    {
        urlString = @"https://api.imagga.com/v2/croppings";
    }
    if ([endpoint isEqualToString:@"Colors"])
    {
        urlString = @"https://api.imagga.com/v2/colors";
    }
    
    return urlString;
}

- (NSData *)getBodyForEndpoint:(NSString *)endpoint
{
    NSData *imageData = [self.model getImageData];
    NSString *base64String = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSMutableData *body = [[NSMutableData alloc] init];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"image_base64"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@", base64String] dataUsingEncoding:NSUTF8StringEncoding]];
    
    if ([endpoint isEqualToString:@"Tags"])
    {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"language"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", @"ru"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if ([endpoint isEqualToString:@"Categories"])
    {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"language"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", @"ru"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    if ([endpoint isEqualToString:@"Crop"])
    {
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"no_scaling"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", @"0"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"rect_percentage"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", @"30"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"image_resut"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@", @"1"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return body.copy;
}

@end
