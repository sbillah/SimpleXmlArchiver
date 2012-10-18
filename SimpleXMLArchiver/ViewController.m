//
//  ViewController.h
//  SimpleXMLArchiver
//
//  Copyright (c) 2012 Lars Rosenquist. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "ViewController.h"
#import "SimpleArchiver.h"

@implementation ViewController

-(IBAction)clear:(id)sender {
    [self.myLabel setText:@""];
}

-(IBAction)objectToXml:(id)sender   {
    NSString *objectAsXML = [SimpleArchiver objectToXml:self.myParent];
    NSLog(@"Converted object to XML, resulting XML >>>>>");
    NSLog(objectAsXML);
    NSLog(@"<<<<< End of XML");
    [self.myLabel setText:objectAsXML];
    self.myParentAsString = objectAsXML;
}

-(IBAction)xmlToObject:(id)sender   {
    MyParent *parent = [SimpleArchiver xmlToObject:self.myParentAsString targetClass:[MyParent class]];
    self.myParent = parent;
    NSLog(@"Converted XML back to object.");
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create some test data
    
    MyParent *parent = [[MyParent alloc]init];
    parent.myName = @"I am the parent";
    parent.myInt = 42;
    parent.myNumber = [NSNumber numberWithInt:1234];
    
    MyChild *child = [[MyChild alloc]init];
    child.myName = @"I am the child";
    child.myFloat = 43.0f;
    
    parent.myChild = child;
    [child release];

    MyGrandChild *grandChild1 = [[MyGrandChild alloc]init];
    grandChild1.myName = @"I am the first grandchild";
    grandChild1.myInt = 44;
    
    MyGrandChild *grandChild2 = [[MyGrandChild alloc]init];
    grandChild2.myName = @"I am the second grandchild";
    grandChild2.myInt = 45;
    
    NSMutableArray *grandChildren = [[NSMutableArray alloc]initWithObjects:grandChild1, grandChild2, nil];
    
    child.myArrayOfGrandChildren = grandChildren;
    
    [grandChild1 release];
    [grandChild2 release];
    [grandChildren release];
    
    self.myParent = parent;
    
    [parent release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
