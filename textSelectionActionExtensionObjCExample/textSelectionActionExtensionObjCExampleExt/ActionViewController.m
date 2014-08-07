//
//  ActionViewController.m
//  textSelectionActionExtensionObjCExampleExt
//
//  Created by Jaz Garewal on 8/7/14.
//  Copyright (c) 2014 Skinny Bones Productions. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *searchTextField;
@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([UIPasteboard generalPasteboard].string) {
        __weak UITextField *searchTextField = self.searchTextField;
        dispatch_async(dispatch_get_main_queue(), ^{
            [searchTextField setText:[UIPasteboard generalPasteboard].string];
        });
    }
    self.webView.delegate = self;
}

- (IBAction)searchButtonTapped:(id)sender {
    NSString *searchTextString = [self.searchTextField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSString *urlString = [NSString stringWithFormat:@"http://wikipedia.org/search-redirect.php?family=wikipedia&search=%@&language=en", searchTextString];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadRequestFromString:urlString];
    });
}

- (void)loadRequestFromString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
   
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.webView loadRequest:urlRequest];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    [self.extensionContext completeRequestReturningItems:nil completionHandler:nil];
}

@end
