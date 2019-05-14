/*Create database  IEgypt_92;*/

GO -- batch 1
create table Notified_Person(
 ID int primary key IDENTITY ,
);

GO -- batch 2
create table [User] (
    ID int primary key IDENTITY ,
    email varchar(255),
    first_name varchar(255),
	middle_name varchar(255),
    last_name varchar(255),
    birth_date date,
	age  AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
	[password] varchar(255),
	deactivated bit default 0,
	date_deactivated datetime
);

GO -- batch 3
create table Viewer (
ID  int primary key foreign key references [User](ID) on delete cascade on update cascade,
working_place varchar(255),
working_place_type varchar(255),
work_place_description varchar(255)
);


GO -- batch 4
create table Contributor(
 ID  int primary key foreign key references [User](ID) on delete cascade on update cascade,
 years_of_experience int,
 portfolio_link varchar(255),
 specialization varchar(255),
 notified_id int foreign key references Notified_Person (ID) on delete cascade on update cascade
);

GO -- batch 5
create table Staff(
ID  int primary key foreign key references [User](ID) on delete cascade on update cascade,
hired_date date,
working_hours int,
payment_rate int,
total_salary AS (payment_rate * working_hours),
notified_id int foreign key references Notified_Person (ID) on delete cascade on update cascade
);

GO -- batch 6
create table Content_manager(
ID int ,
[type] varchar(255),
primary key (ID),
foreign key (ID) references Staff (ID) on delete cascade on update cascade
);

GO -- batch 7
create table Reviewer (
ID int primary key foreign key references Staff (ID) on delete cascade on update cascade
);

GO -- batch 8
create table [Message] (
sent_at datetime ,
contributer_id int foreign key references Contributor (ID) on delete no action on update no action,
viewer_id int foreign key references Viewer (ID) on delete no action on update no action,
sender_type bit default null ,
read_at datetime,
[text] varchar(255),
read_status bit default 0,
primary key(sent_at,contributer_id,viewer_id,sender_type)
);

GO -- batch 9
create table Category(
[type] varchar(255) primary key,
[description] varchar(255)
);

GO -- batch 10
create table Sub_Category(
category_type varchar(255) foreign key references Category([type]) on delete cascade on update cascade,
name varchar(255),
primary key (category_type,name)
);
 
 GO -- batch 11
 create table Content_type(
 [type] varchar(255) primary key 
 );

 GO -- batch 12
 create table Notification_Object(
 ID int primary key identity
 );

 GO -- batch 13
create table Content(
 ID int primary key identity,
 link varchar(255),
 uploaded_at datetime,
 contributer_id int foreign key references Contributor(ID) on delete cascade on update cascade,
 category_type varchar(255) ,
 subcategory_name varchar(255) ,
 [type] varchar(255) foreign key references Content_type([type]) on delete cascade on update cascade,
 foreign key (category_type,subcategory_name) references Sub_Category(category_type,name) on delete cascade on update cascade
 );

 GO -- batch 14
create table Original_Content(
 ID int primary key foreign key references Content(ID) on delete no action on update no action,
 content_manager_id int foreign key references Content_manager(ID) on delete no action on update no action,
 reviewer_id int foreign key references Reviewer(ID) on delete no action on update no action,
 review_status bit default null,
 filter_status bit default null,
 rating int
 );

 GO -- batch 15
 create table Existing_Request(
 id int primary key identity,
 original_content_id int foreign key references Original_Content(ID) on delete cascade on update cascade,
 viewer_id int foreign key references Viewer(ID) on delete cascade on update cascade
 );

 GO -- batch 16
 create table New_Request(
 id int primary key identity,
 accept_status bit default null,
 specified bit default 0,
 information varchar(255),
 viewer_id int foreign key references Viewer(ID) on delete no action on update no action,
 notif_obj_id int foreign key references Notification_Object(ID) on delete no action on update no action,
 contributer_id int foreign key references Contributor(ID) on delete no action on update no action
 );
 
 GO -- batch 17
 create table New_Content(
 ID int primary key foreign key references Content(ID) on delete cascade on update cascade,
 new_request_id int foreign key references New_Request(id) on delete cascade on update cascade
 );

 GO -- batch 18
 create table comment(
 Viewer_id int foreign key references Viewer(ID) on delete cascade on update cascade,
 original_content_id int foreign key references Original_Content(ID) on delete cascade on update cascade,
 [date] datetime,
 [text] varchar(255),
 primary key (Viewer_id,original_content_id)
 );

 GO -- batch 19
 create table Rate(
 viewer_id int foreign key references Viewer(ID) on delete cascade on update cascade,
 original_content_id int foreign key references Original_Content(ID) on delete cascade on update cascade,
 [date] datetime,
 rate int ,
 primary key (viewer_id,original_content_id)
 );

 GO -- batch 20
 create table [Event](
 id int primary key identity,
 [description] varchar(255),
 location varchar(255),
 city varchar(255),
 [time] datetime,
 entertainer varchar(255),
 notification_object_id int foreign key references Notification_Object(ID) on delete cascade on update cascade,
 viewer_id int foreign key references Viewer(ID) on delete cascade on update cascade
 );

 GO -- batch 21
 create table Event_Photos_link(
 event_id int primary key foreign key references [Event](id) on delete cascade on update cascade,
 link varchar(255)
 );

 GO -- batch 21.1
 create table Event_Videos_link(
 event_id int primary key foreign key references [Event](id) on delete cascade on update cascade,
 link varchar(255)
 );

 GO -- batch 22
 create table Advertisement(
 id int primary key identity,
 [description] varchar(255),
 location varchar(255),
 event_id int foreign key references [Event](id) on delete no action on update no action,
 viewer_id int foreign key references Viewer(ID) on delete no action on update no action
 );

 GO -- batch 23
 create table Ads_Video_Link(
 advertisement_id int primary key foreign key references Advertisement(id) on delete cascade on update cascade,
 link varchar(255)
 );

 GO -- batch 24
 create table Ads_Photos_Link(
 advertisement_id int primary key foreign key references Advertisement(id) on delete cascade on update cascade,
 link varchar(255)
 );

 GO -- batch 25
 create table Announcement(
 ID int primary key identity,
 seen_at datetime,
 send_at datetime,
 notified_person_id int foreign key references Notified_Person(ID) on delete cascade on update cascade,
 notified_object_id int foreign key references Notification_Object(ID) on delete cascade on update cascade
 );

 
 
 

