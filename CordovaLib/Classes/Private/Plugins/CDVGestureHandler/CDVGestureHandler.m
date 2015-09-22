/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVGestureHandler.h"

@implementation CDVGestureHandler

- (void)pluginInitialize
{
    [self applyLongPressFix];
}

- (void)applyLongPressFix
{
    self.lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestures:)];
    self.lpgr.minimumPressDuration = 0.45f;
    self.lpgr.allowableMovement = 100.0f;

    NSArray *views = self.webView.subviews;
    if (views.count == 0) {
        NSLog(@"No webview subviews found, not applying the longpress fix.");
        return;
    }
    for (int i=0; i<views.count; i++) {
        UIView *webViewScrollView = views[i];
        if ([webViewScrollView isKindOfClass:[UIScrollView class]]) {
            NSArray *webViewScrollViewSubViews = webViewScrollView.subviews;
            UIView *browser = webViewScrollViewSubViews[0];
            [browser addGestureRecognizer:self.lpgr];
            break;
        }
    }
}

- (void)handleLongPressGestures:(UILongPressGestureRecognizer*)sender
{
    if ([sender isEqual:self.lpgr]) {
        if (sender.state == UIGestureRecognizerStateBegan) {
          NSLog(@"Ignoring a longpress in order to suppress the magnifying glass.");
        }
    }
}

@end
