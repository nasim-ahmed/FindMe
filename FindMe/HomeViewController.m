//
//  HomeViewController.m
//  FindMe
//
//  Created by Nasim on 1/16/17.
//  Copyright © 2017 Nasim. All rights reserved.
//

#import "HomeViewController.h"
#import <MapKit/MapKit.h>
#import "Constant.h"
#import "AddLocationViewController.h"

@interface HomeViewController ()<MKMapViewDelegate, UITableViewDataSource, AddLocationProtocol>
@property (strong, nonatomic) MKMapView *MapView;
@property (strong, nonatomic) UITableView *TableView;
@property (strong, nonatomic) NSMutableArray<MKPointAnnotation*>* Annotations;
@end

static NSString *cellIdentifier = @"HomeViewControllerCell";

@implementation HomeViewController

- (void)dealloc {
    self.MapView = nil;
    self.TableView = nil;
    self.Annotations = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kOFF_WHITE_COLOR;
    self.navigationController.navigationBar.hidden = FALSE;
    
    [self SetupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)SetupViews {
    [self SetupNavItems];
    [self SetupTableView];
    [self SetupMapView];
}

- (void)SetupNavItems {
    self.navigationItem.hidesBackButton = YES;
    
    UISegmentedControl *SegController = [[UISegmentedControl alloc] initWithItems:@[@"Map", @"List"]];
    [SegController addTarget:self action:@selector(SwitchOverViews:) forControlEvents:UIControlEventValueChanged];
    SegController.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = SegController;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddNewLocation:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"LogOut" style:UIBarButtonItemStylePlain target:self action:@selector(LogOutUser:)];
}

- (void)SetupTableView {
    self.TableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.TableView.dataSource = self;
    [self.view addSubview:self.TableView];
}

- (void)SetupMapView {
    self.MapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.MapView.delegate = self;
    self.MapView.showsUserLocation = YES;
    self.MapView.mapType = MKMapTypeSatelliteFlyover;
    [self.view addSubview:self.MapView];
    
    [self.MapView addAnnotations:self.Annotations];
}

- (void)LogOutUser: (UIBarButtonItem*)item {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)AddNewLocation: (UIBarButtonItem*)item {
    AddLocationViewController* addLocationViewController = [[AddLocationViewController alloc] init];
    addLocationViewController.delegate = self;
    UINavigationController* NavigationController = [[UINavigationController alloc] initWithRootViewController:addLocationViewController];
    [self presentViewController:NavigationController animated:YES completion: NULL];
}
- (void)SwitchOverViews:(UISegmentedControl *)segmented{
    
    switch(segmented.selectedSegmentIndex) {
        case 0:
            self.MapView.hidden = NO;
            self.TableView.hidden = YES;
            break;
        case 1:
            self.MapView.hidden = YES;
            self.TableView.hidden = NO;
            break;
        default:
            break;
    }
    
}

- (NSMutableArray* )Annotations {
    if(_Annotations == nil) {
        _Annotations = [[NSMutableArray alloc] init];
    }
    return _Annotations;
}

#pragma mark --
#pragma mark -- Delegates
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [mapView setRegion:[mapView regionThatFits:region] animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.Annotations.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell *)[theTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell  =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    MKPointAnnotation* annotation = (MKPointAnnotation*) [self.Annotations objectAtIndex:indexPath.row];
    cell.textLabel.text = annotation.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  Coordinate = (%0.2f, %0.2f)", annotation.subtitle, annotation.coordinate.latitude, annotation.coordinate.longitude];
    
    return cell;
}

#pragma mark --
#pragma mark -- Protocol
- (void)AddAnnotation:(MKPointAnnotation* )annotation {
    [self.Annotations addObject:annotation];
    [self.TableView reloadData];
    [self RefreshMapWithAnnotation:annotation];
    
}

- (void)RefreshMapWithAnnotation:(MKPointAnnotation* )Annotation {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(Annotation.coordinate, 0.1, 0.1);
    [self.MapView setRegion:[self.MapView regionThatFits:region] animated:YES];
    [self.MapView addAnnotation:Annotation];
    
}
@end
