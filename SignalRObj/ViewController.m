//
//  ViewController.m
//  SignalRObj
//
//  Created by Vikas on 09/05/16.
//  Copyright © 2016 FlightTrak. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SRHubConnection *hubConnection = [SRHubConnection connectionWithURLString:@"http://172.16.9.61/In4medEV.WebApp/"];
    // Create a proxy to the chat service
    chat = [hubConnection createHubProxy:@"NotificationHub"];
    [chat on:@"ReceiveLength" perform:self selector:@selector(addMessage:)];
    
    // Register for connection lifecycle events
    [hubConnection setStarted:^{
        NSLog(@"Connection Started");
     
            
        
    }];
    [hubConnection setReceived:^(NSString *message) {
        NSLog(@"Connection Recieved Data: %@",message);
    }];
    [hubConnection setConnectionSlow:^{
        NSLog(@"Connection Slow");
    }];
    [hubConnection setReconnecting:^{
        NSLog(@"Connection Reconnecting");
    }];
    [hubConnection setReconnected:^{
        NSLog(@"Connection Reconnected");
    }];
    [hubConnection setClosed:^{
        NSLog(@"Connection Closed");
    }];
    [hubConnection setError:^(NSError *error) {
        NSLog(@"Connection Error %@",error);
    }];
    // Start the connection
    [hubConnection start];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addMessage:(NSString *)message {
    // Print the message when it comes in
    NSLog(message);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)send:(id)sender
{
   // [chat invokeEvent:@"GetElapsedTime" withArgs:@"GetElapsedTime"];
    
    [chat invoke:@"GetElapsedTime" withArgs:@[@"GetPlayTime"] completionHandler:^(id response, NSError *error) {
        
        if (error) {
            
        }
    }];
}

@end
