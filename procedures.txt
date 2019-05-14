GO -- batch 45
 create proc Original_Content_Search 
 @typename varchar(255), 
 @categoryname varchar(255)
 as
 if @categoryname is null 
 select link 
 from Content
 right join Original_Content on Content.ID=Original_content.ID
 where Content.[type]=@typename and Original_Content.review_status=1 and Original_Content.filter_status=1
 else 
 if @typename is null 
 select link 
 from Content
 right join Original_Content on Content.ID=Original_content.ID
 where Content.category_type=@categoryname and Original_Content.review_status=1 and Original_Content.filter_status=1
 else print 'ERROR'

 GO -- batch 47
 create proc Contributor_Search @fullname varchar(255)
 as 
 if(@fullname is null)begin
 print 'ERROR'
 end 
 else begin
 select concat('full name:',' ',first_name,' ',middle_name,' ',last_name,' ','email:',email,' ','years of experince:',years_of_experience,' portfolio:',portfolio_link,' specialization:',specialization) 
 from [User] 
 right join Contributor on Contributor.ID=[User].ID
 where concat(first_name,' ',middle_name,' ',last_name)=@fullname
 end

 GO -- batch 49
 
 create procedure Register_User (@usertype varchar(255), @email varchar(255), @password varchar(255), @firstname varchar(255),
@middlename varchar(255), @lastname varchar(255), @birth_date date, @working_place_name varchar(255), @working_place_type varchar(255),
@wokring_place_description varchar(255), @specilization varchar(255), @portofolio_link varchar(255), @years_experience int, @hire_date date,
@working_hours int, @payment_rate int, @user_id int output)
 as
 declare @returned int
 declare @noti int 
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values (@email,@firstname,@middlename,@lastname,@birth_date,@password);
 set @returned = (select ID from [User] where email=@email)
 set @user_id = @returned
 set @noti = (select max(ID) from Notified_Person)
 if @usertype='Viewer' begin
 insert into Viewer (ID,working_place,working_place_type,work_place_description) 
 values (@returned,@working_place_name,@working_place_type,@wokring_place_description);
 end
 if @usertype='Contributor'begin
 set identity_insert Notified_Person on 
 insert into Notified_Person (ID) values (@noti+1);
 set identity_insert Notified_Person off
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values (@returned,@years_experience,@portofolio_link,@specilization,@noti+1);
 end
 if @usertype='Reviewer' begin
 set identity_insert Notified_Person on 
 insert into Notified_Person (ID) values (@noti+1);
 set identity_insert Notified_Person off
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values (@returned,@hire_date,@working_hours,@payment_rate,@noti+1);
 insert into Reviewer (ID) 
 values (@returned);
 end
 if  @usertype='Content_manager' begin
 set identity_insert Notified_Person on 
 insert into Notified_Person (ID) values (@noti+1);
 set identity_insert Notified_Person off
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values (@returned,@hire_date,@working_hours,@payment_rate,@noti+1);
 insert into Content_manager (ID,[type]) 
 values (@returned,null);
 end
 
GO -- batch 51
 create proc Check_Type 
 @typename varchar(255),
 @content_manager_id int
 as
 if exists(select ID from Content_manager where @content_manager_id=ID)begin
 if exists(select [type] from Content_type where @typename=[type])begin
 update Content_manager 
 set [type] = @typename
 where ID = @content_manager_id
 end 
 else begin
 insert into Content_type ([type]) values (@typename);
 update Content_manager 
 set [type] = @typename
 where ID = @content_manager_id
 end
 end 
 else print 'ERROR'

 GO -- batch 53

 create proc Order_Contributor 
 as 
 select first_name,middle_name,last_name,email,years_of_experience,portfolio_link,specialization 
 from Contributor
 left join [User] on Contributor.ID=[User].ID
 order by years_of_experience desc 

 GO -- batch 55
 create proc Show_Original_Content
@contributor_id int
as
if (@contributor_id is null)begin
select first_name,middle_name,last_name,email,years_of_experience,portfolio_link,specialization,link,uploaded_at,category_type,subcategory_name,[type]
 from Contributor
 left join [User] on Contributor.ID=[User].ID
 right join Content on Contributor.ID=Content.contributer_id
 right join Original_Content on Content.ID=Original_Content.ID
 end 
 else begin 
 select first_name,middle_name,last_name,email,years_of_experience,portfolio_link,specialization,link,uploaded_at,category_type,subcategory_name,[type]
 from Contributor
 left join [User] on Contributor.ID=[User].ID
 right join Content on Contributor.ID=Content.contributer_id
 right join Original_Content on Content.ID=Original_Content.ID
 where Contributor.ID=@contributor_id
 end 

 GO -- batch 57
 create proc User_login @email varchar(255), @password varchar(255), @user_id int OUTPUT
 as 
 if(exists(select email,[password] from [User] where email=@email and [password]=@password))begin
	if((select deactivated from [User] where email=@email)=1 and (datediff(day,(select date_deactivated from [User] where email=@email),current_timestamp)>14))begin
	set @user_id = '-1'
	print @user_id
	end 
	else begin
	if((select deactivated from [User] where email=@email)=1)begin 
	update [User]
	set deactivated = 0
	where email=@email
	update [User]
	set date_deactivated = null
	where email=@email
	end 
	set @user_id = (select ID from [User] where email=@email)
	print @user_id 
	end
	end
	else begin 
	set @user_id = '-1'
	print @user_id
	end

	GO -- batch 58
 create function usertype (@userid int)
 returns char
 begin
 declare @t char 
 if (exists (select ID from Viewer where ID=@userid))begin
 set @t = 'v'
 end 
 if (exists (select ID from Contributor where ID=@userid))begin
 set @t = 'c'
 end 
 if (exists (select ID from Staff where ID=@userid))begin
 set @t = 's'
 end 
 return @t
 end

 GO -- batch 60
 create proc Show_Profile
@user_id int, 
@email varchar(255) OUTPUT, 
@password varchar(255) OUTPUT, 
@firstname varchar(255) OUTPUT, 
@middlename varchar(255) OUTPUT,
@lastname varchar(255) OUTPUT, 
@birth_date date OUTPUT, 
@working_place_name varchar(255) OUTPUT, 
@working_place_type varchar(255) OUTPUT, 
@working_place_description varchar(255) OUTPUT, 
@specilization varchar(255) OUTPUT,
@portofolio_link varchar(255) OUTPUT, 
@years_experience int OUTPUT, 
@hire_date date OUTPUT, 
@working_hours int OUTPUT, 
@payment_rate int OUTPUT
as
if(@user_id is null or not exists(select ID from [User] where ID=@user_id))begin
print 'ERROR'
end
else begin
declare @t char
set @t = dbo.usertype(@user_id)
if (exists (select ID from [User] where ID=@user_id))begin
if (@t='v')begin
select email,[password],first_name,middle_name,last_name,birth_date,working_place,working_place_type,work_place_description
from [User]
right join Viewer on [User].ID=Viewer.ID
where Viewer.ID=@user_id
end
if (@t='c')begin
select email,[password],first_name,middle_name,last_name,birth_date,years_of_experience,portfolio_link,specialization,notified_id
from [User]
right join Contributor on [User].ID=Contributor.ID
where Contributor.ID=@user_id
end
if (@t='s')begin
select email,[password],first_name,middle_name,last_name,birth_date,hired_date,working_hours,payment_rate
from [User]
right join Staff on [User].ID=Staff.ID
where Staff.ID=@user_id
end
end 
else begin
return null
end
end

GO -- batch 62
create proc Edit_Profile @user_id int, @email varchar(255), @password varchar(255),
@firstname varchar(255), @middlename varchar(255), @lastname varchar(255), @birth_date date, 
@working_place_name varchar(255), @working_place_type varchar(255),
@wokring_place_description varchar(255), @specilization varchar(255), @portofolio_link varchar(255), 
@years_experience int, @hire_date date,
@working_hours int, @payment_rate int
as 
if(@user_id is null)begin
print 'ERROR'
end
else begin
declare @t char
set @t = dbo.usertype(@user_id)
if (@email is not null)begin 
	update [User]
	set email = @email
	where ID = @user_id
	end 
	if (@password is not null)begin 
	update [User]
	set [password] = @password
	where ID = @user_id
	end 
	if (@firstname is not null)begin 
	update [User]
	set first_name = @firstname
	where ID = @user_id
	end
	if (@middlename is not null)begin 
	update [User]
	set middle_name = @middlename
	where ID = @user_id
	end
	if (@lastname is not null)begin 
	update [User]
	set last_name = @lastname
	where ID = @user_id
	end 
	if (@birth_date is not null)begin 
	update [User]
	set birth_date = @birth_date
	where ID = @user_id
	end 
if (@t ='v')begin
	if (@working_place_name is not null)begin 
	update Viewer
	set working_place = @working_place_name
	where ID = @user_id
	end 
	if (@working_place_type is not null)begin 
	update Viewer
	set working_place_type = @working_place_type
	where ID = @user_id
	end 
	if (@wokring_place_description is not null)begin 
	update Viewer
	set work_place_description = @wokring_place_description
	where ID = @user_id
	end 
end
if (@t ='c')begin
	if (@specilization is not null)begin 
	update Contributor
	set specialization = @specilization
	where ID = @user_id
	end 
	if (@portofolio_link is not null)begin 
	update Contributor
	set portfolio_link = @portofolio_link
	where ID = @user_id
	end 
	if (@years_experience is not null)begin 
	update Contributor
	set years_of_experience = @years_experience
	where ID = @user_id
	end 
end
if (@t ='s')begin
	if (@hire_date is not null)begin 
	update Staff
	set hired_date = @hire_date
	where ID = @user_id
	end 
	if (@working_hours is not null)begin 
	update Staff
	set working_hours = @working_hours
	where ID = @user_id
	end 
	if (@payment_rate is not null)begin 
	update Staff
	set payment_rate = @payment_rate
	where ID = @user_id
	end 
end 
end

GO -- batch 64
create proc Deactivate_Profile @user_id int
as
if(exists(select ID from [User] where ID=@user_id))begin
	update [User]
	set deactivated = 1
	where ID = @user_id
	update [User]
	set date_deactivated = CURRENT_TIMESTAMP
	where ID = @user_id
end 
else begin print 'ERROR' end 

GO -- batch 65
create proc Show_Event @event_id int 
as
if (@event_id is null)begin
select [description],location,city,[time],entertainer,first_name,middle_name,last_name
from [Event]
left join [User] on [Event].viewer_id=[User].ID
end
else begin
select [description],location,city,[time],entertainer,first_name,middle_name,last_name
from [Event]
left join [User] on [Event].viewer_id=[User].ID
where [Event].id=@event_id
end

GO -- batch 67
create proc Show_Notification @user_id int
as
declare @t char
set @t = dbo.usertype(@user_id)
if(exists (select ID from [User] where ID=@user_id ) or @user_id is null)begin
print 'ERROR'
end 
else begin
	if (@t ='c')begin
	declare @n int 
	set @n = (select notified_id from Contributor where ID=@user_id)
	select accept_status as 'accept_status',information as 'information',viewer_id  as 'viewer_id', null as '[description]',null as 'location', null as 'city',null as '[time]', null as 'entertainer'
	from Contributor 
	inner join New_Request on New_Request.contributer_id=Contributor.ID
	where Contributor.ID=@user_id
	union all
	select null as 'accept_status',null as 'information',null as 'viewer_id',[description] as '[description]',location as 'location',city as 'city',[time] as '[time]',entertainer as 'entertainer'
	from Contributor
	inner join Announcement on Announcement.notified_person_id=Contributor.notified_id
	inner join [Event] on [Event].notification_object_id=Announcement.notified_object_id
	where Contributor.ID= @user_id
	if((select seen_at from Announcement where notified_person_id=@n) is null)begin
	update Announcement
	set seen_at= CURRENT_TIMESTAMP
	where notified_person_id= (select notified_id from Contributor where ID=@user_id)
	end
	end 
	else begin
	declare @n2 int 
	set @n2 = (select notified_id from Staff where ID=@user_id)
	select [description],location,city,[time],entertainer
	from Staff
	left join Announcement on Announcement.notified_person_id=Staff.notified_id
	left join [Event] on [Event].notification_object_id=Announcement.notified_object_id
	where Staff.ID= @user_id
	if((select seen_at from Announcement where notified_person_id=@n2) is null)begin
	update Announcement
	set seen_at= CURRENT_TIMESTAMP
	where notified_person_id= (select notified_id from Staff where ID=@user_id)
	end
	end 

end

GO -- batch 69
create proc Show_New_Content @viewer_id int, @content_id int
as
if(@viewer_id is null)begin
print 'ERROR'
end 
else begin
if(@content_id is null)begin
select link,[User].ID,first_name,middle_name,last_name
from Content
right join New_Content on New_Content.ID=Content.ID
left join [User] on [User].ID=Content.contributer_id
left join New_Request on New_Request.id=New_Content.new_request_id
where New_Request.viewer_id=@viewer_id
end
else begin
select link,[User].ID,first_name,middle_name,last_name
from Content
right join New_Content on New_Content.ID=Content.ID
left join [User] on [User].ID=Content.contributer_id
left join New_Request on New_Request.id=New_Content.new_request_id
where Content.ID=@content_id and New_Request.viewer_id=@viewer_id
end
end
 

 GO -- batch 71
 create proc Viewer_Create_Event
@city varchar(255), @event_date_time datetime, @description varchar(255), @entartainer varchar(255), 
@viewer_id int,@location varchar(255) , @event_id int OUTPUT
as 
declare @notif int
set @notif = ((select max(ID) from Notification_Object)+1)
if(@viewer_id is null or (not exists(select ID from Viewer where ID=@viewer_id)))begin
print 'ERROR'
end 
else begin 
set identity_insert Notification_Object on
insert into Notification_Object (ID) values (@notif);
set identity_insert Notification_Object off
insert into [Event] ([description],location,city,[time],entertainer,notification_object_id,viewer_id)
values (@description,@location,@city,@event_date_time,@entartainer,@notif,@viewer_id);
DECLARE @cnt INT = 1;
declare @ct int 
set @ct = ((select max(ID) from Contributor)+1)
WHILE @cnt < @ct
BEGIN
   if(exists (select ID from Contributor where ID=@cnt))begin
   declare @n3 int
	set @n3 = (select notified_id from Contributor where ID=@cnt)
   insert into Announcement (send_at,notified_person_id,notified_object_id)
	values(CURRENT_TIMESTAMP,@n3,@notif);
	end 
   SET @cnt = @cnt + 1;
end
DECLARE @cnt1 INT = 1;
declare @ct1 int 
set @ct1 = ((select max(ID) from Staff)+1)
WHILE @cnt1 < @ct1
BEGIN
   if(exists (select ID from Staff where ID=@cnt1))begin
   declare @n31 int
	set @n31 = (select notified_id from Staff where ID=@cnt1)
   insert into Announcement (send_at,notified_person_id,notified_object_id)
	values(CURRENT_TIMESTAMP,@n31,@notif);
	end 
   SET @cnt1 = @cnt1 + 1;
end
end 

GO -- batch 73
create proc Viewer_Upload_Event_Photo
@event_id int, @link varchar(255)
as
if(exists ( select id from [Event] where @event_id=id))begin
insert into Event_Photos_link (event_id,link) values (@event_id,@link) ;
end
else begin
print 'ERROR'
end

GO -- batch 75
create proc Viewer_Upload_Event_Video
@event_id int, @link varchar(255)
as
if(exists ( select id from [Event] where @event_id=id))begin
insert into Event_Videos_link(event_id,link) values (@event_id,@link) ;
end
else begin
print 'ERROR'
end 

GO -- batch 77
create proc Viewer_Create_Ad_From_Event @event_id int
as
if(exists ( select id from [Event] where @event_id=id))begin
declare @d varchar(255)
declare @l varchar(255)
declare @v int 
set @d = (select [description] from [Event] where [Event].id=@event_id)
set @l = (select location from [Event] where [Event].id=@event_id)
set @v = (select viewer_id from [Event] where [Event].id=@event_id)
insert into Advertisement([description],location,event_id,viewer_id) values (@d,@l,@event_id,@v) 
end
else begin
print 'ERROR'
end 


GO -- batch 79
create proc Apply_Existing_Request
@viewer_id int ,@original_content_id int
as 
if(exists (select ID from Viewer where ID=@viewer_id) and @viewer_id is not null )begin
	if(exists (select ID from Original_Content where ID=@original_content_id))begin
		if((select rating from  Original_Content where ID=@original_content_id)>3)begin
			insert into Existing_Request (original_content_id,viewer_id) values (@original_content_id,@viewer_id);
		end
		else begin print 'ERROR3' end 
end
else begin print 'ERROR2' end 
end
else begin print 'ERROR1' end 


GO -- batch 81
create proc Apply_New_Request @information varchar(255), @contributor_id int, @viewer_id int
as
if(exists (select ID from Viewer where ID=@viewer_id) and not exists(select contributer_id from New_Request where viewer_id=@viewer_id and information=@information and contributer_id=@contributor_id))begin
			declare @t int
set @t = ((select max(ID) from Notification_Object)+1)
if (@contributor_id is not null)begin
	if(exists (select ID from Contributor where ID=@contributor_id))begin
		set identity_insert Notification_Object on
		insert into Notification_Object (ID) values (@t);
		set identity_insert Notification_Object off
		insert into New_Request (specified,information,viewer_id,notif_obj_id,contributer_id)
		values (@contributor_id,@information,@viewer_id,@t,@contributor_id);
		declare @n int
		set @n = (select notified_id from Contributor where ID=@contributor_id)
		insert into Announcement (send_at,notified_person_id,notified_object_id)
		values(CURRENT_TIMESTAMP,@n,@t);
		end 
		else begin print 'ERROR' end
end 
else begin 
declare @t2 int
set @t2 =  ((select max(ID) from Notification_Object)+1)
set identity_insert Notification_Object on
insert into Notification_Object (ID) values (@t2);
set identity_insert Notification_Object off
insert into New_Request (specified,information,viewer_id,notif_obj_id,contributer_id)
	values (null,@information,@viewer_id,@t2,null);
DECLARE @cnt INT = 1;
declare @ct int 
set @ct = ((select max(ID) from Contributor)+1)
WHILE @cnt < @ct
BEGIN
   if(exists (select ID from Contributor where ID=@cnt))begin
   declare @n3 int
	set @n3 = (select notified_id from Contributor where ID=@cnt)
   insert into Announcement (send_at,notified_person_id,notified_object_id)
	values(CURRENT_TIMESTAMP,@n3,@t2);
	end 
   SET @cnt = @cnt + 1;
end
end

end
else begin print 'ERROR' end


GO -- batch 83
create proc Delete_New_Request @request_id int
as
if((select accept_status from New_Request where id=@request_id)='1')begin
print 'ERROR'
end
else begin
if(exists (select id from New_Request where id=@request_id))begin
	declare @n int
	set @n = (select notif_obj_id from New_Request where id=@request_id)
	delete from Announcement where notified_object_id=@n
	delete from Notification_Object where ID=@n
	delete from New_Request where id=@request_id

end 
else begin print 'ERROR' end
end 


GO -- batch 85
create proc Rating_Original_Content @orignal_content_id int,
@rating_value int, @viewer_id int
as
if(@orignal_content_id is null or @rating_value is null)begin print 'ERROR' end 
else begin
if(exists (select ID from Viewer where ID=@viewer_id))begin
 insert into Rate (viewer_id,original_content_id,[date],rate)
 values (@viewer_id,@orignal_content_id,CURRENT_TIMESTAMP,@rating_value);
 declare @avg int
 set @avg = (select avg(rate) from Rate where original_content_id=@orignal_content_id)
 update Original_Content
 set rating=@avg
 where ID=@orignal_content_id
 end
 else begin print 'ERROR' end 
 end


 GO -- batch 87
 create proc Write_Comment @comment_text varchar(255),
@viewer_id int, @original_content_id int, @written_time datetime
as 
if(exists (select ID from Viewer where ID=@viewer_id))begin
	if (@comment_text is not null and @original_content_id is not null and @written_time is not null)begin
	insert into comment (Viewer_id,original_content_id,[date],[text])
	values (@viewer_id,@original_content_id,CURRENT_TIMESTAMP,@comment_text);
	end
	else begin print 'ERROR' end
end 
else begin print 'ERROR' end


GO -- batch 89
create proc Edit_Comment @comment_text varchar(255),
@viewer_id int, @original_content_id int, @last_written_time datetime, @updated_written_time datetime
as 
if(exists (select ID from Viewer where ID=@viewer_id))begin
	if (@comment_text is not null and @original_content_id is not null and @last_written_time is not null and @updated_written_time is not null)begin
		update comment
		set [text] = @comment_text
		where Viewer_id=@viewer_id and original_content_id=@original_content_id and [date]=@last_written_time;
		update comment
		set [date] = current_timestamp
		where Viewer_id=@viewer_id and original_content_id=@original_content_id and [date]=@last_written_time;
	end 
	else begin print 'ERROR' end 
end
else begin print 'ERROR' end

GO -- batch 91
create proc Delete_Comment @viewer_id int, @original_content_id int,
@written_time datetime
as
if(exists (select ID from Viewer where ID=@viewer_id))begin
	if (@original_content_id is not null and @written_time is not null and @viewer_id is not null)begin
		delete from comment where  Viewer_id=@viewer_id and original_content_id=@original_content_id and [date]=@written_time;
	end 
	else begin print 'ERROR' end 
end 
else begin print 'ERROR' end 


GO -- batch 93 
create proc Create_Ads @viewer_id int,@description varchar(255), @location varchar(255)
as
if(exists (select ID from Viewer where ID=@viewer_id))begin
	if (@description is not null and @location is not null)begin
		insert into Advertisement ([description],location,viewer_id)
		values (@description,@location,@viewer_id);
	end
	else begin print 'ERROR' end
end 
else begin print 'ERROR' end

GO -- batch 95
create proc Edit_Ad @ad_id int,@description varchar(255), @location varchar(255)
as 
	if (@ad_id is not null and (@description is not null or @location is not null))begin
		update Advertisement
		set [description] = @description
		where id=@ad_id ;
		update Advertisement
		set location = @location
		where id=@ad_id ;
	end 
	else begin print 'ERROR' end 


	GO -- batch 97
create proc Delete_Ads @ad_id int
as
	if (@ad_id is not null)begin
		delete from Advertisement where  id=@ad_id ;
	end 
	else begin print 'ERROR' end 


	GO -- batch 99
create proc Send_Message @msg_text varchar(255), @viewer_id int,
@contributor_id int, @sender_type bit, @sent_at datetime
as 
if(exists (select ID from Viewer where ID=@viewer_id))begin
	if (@msg_text is not null and @contributor_id is not null and @sender_type is not null and @sent_at is not null)begin
	insert into [Message] (sent_at,contributer_id,viewer_id,sender_type,[text])
	values (@sent_at,@contributor_id,@viewer_id,@sender_type,@msg_text);
	end 
	else begin print 'ERROR' end
end 
else begin print 'ERROR' end


GO -- batch 101
create proc Show_Message @contributor_id int
as
if (@contributor_id is not null)begin
select * from [Message] where contributer_id=@contributor_id;
update Message
set read_at = CURRENT_TIMESTAMP
where contributer_id=@contributor_id
update Message
set read_status = '1'
where contributer_id=@contributor_id
end
else begin print 'ERROR' end 

GO -- batch 103
create proc Highest_Rating_Original_content
as
declare @m int
set @m = (select max(rating) from Original_Content)
select link 
from Original_Content
left join Content on Original_Content.ID=Content.ID
where Original_Content.rating=@m


GO -- batch 105
create proc Assign_New_Request @request_id int,
@contributor_id int 
as
if((select accept_status from New_Request where id=@request_id)='1')begin
print 'ERROR'
end
else begin
if(((select accept_status from New_Request where id=@request_id)='0') and ((select specified from New_Request where id=@request_id)='1'))begin
print 'ERROR'
end 
else begin 
 declare @oc int
 set @oc = (select contributer_id from New_Request where ID=@request_id)
 declare @ocn int 
 set @ocn = (select notified_id from Contributor where ID=@oc)
 declare @on int
 set @on = (select notif_obj_id from New_Request where id=@request_id)
 declare @n int
 set @n=(select notified_id from Contributor where ID=@contributor_id)
 update Announcement
 set notified_person_id=@n
 where notified_object_id=@on
 update New_Request
 set contributer_id=@contributor_id
 where id=@request_id
 update New_Request
 set specified=1
 where id=@request_id
 end 
 end
 
	GO -- batch 107
create proc Receive_New_Requests @request_id int, @contributor_id int
as
if(not exists (select ID from Contributor where ID=@contributor_id) or @contributor_id is null)begin
	print 'ERROR' 
end
else begin 
	if (@request_id is null)begin
	select * from New_Request where contributer_id=@contributor_id or (contributer_id=null and (accept_status='0' or accept_status=null))
	end 
	else begin
	select * from New_Request where (contributer_id=@contributor_id and id=@request_id) or (contributer_id=null and (accept_status='0' or accept_status=null))
	end 
end

GO -- batch 109
create proc Respond_New_Request @contributor_id int,
@accept_status bit, @request_id int
as
if(not exists (select ID from Contributor where ID=@contributor_id) or @contributor_id is null)begin
	print 'ERROR' 
end
else begin 
if(((select accept_status from New_Request where id=@request_id)='1') or ((select accept_status from New_Request where id=@request_id)='0') and (select contributer_id from New_Request where id=@request_id) is not null)begin
print 'ERROR'
end 
else begin 
if((select contributer_id from New_Request where id=@request_id)=@contributor_id or (select contributer_id from New_Request where id=@request_id) is null)begin
	if((select contributer_id from New_Request where id=@request_id)=@contributor_id and (select contributer_id from New_Request where id=@request_id) is not null )begin
	update New_Request
	set accept_status = @accept_status
	where id=@request_id
	end
	else begin
	if(@accept_status=1)begin
	update New_Request
	set accept_status = @accept_status
	where id=@request_id
	update New_Request
	set contributer_id = @contributor_id
	where id=@request_id
	update New_Request
	set specified = '1'
	where id=@request_id
	end
	end
end 
else begin print 'ERROR' end
end
end


GO -- batch 111
create proc Upload_Original_Content @type_id varchar(255),
@subcategory_name varchar(255), @category_id varchar(255), @contributor_id int, @link varchar(255)
as
if(not exists (select ID from Contributor where ID=@contributor_id) or @contributor_id is null)begin
	print 'ERROR' 
end
else begin
if(not exists (select [type] from Content_type where [type]=@type_id))begin
	insert into Content_type ([type]) values (@type_id);
end 
if (not exists (select [type] from Category where [type]=@category_id))begin
	insert into Category([type]) values (@category_id);
	insert into Sub_Category (category_type,name) values (@category_id,@subcategory_name);
end 
if (not exists (select category_type from Sub_Category where category_type=@category_id) and not exists (select name from Sub_Category where category_type=@subcategory_name) )begin
	insert into Sub_Category (category_type,name) values (@category_id,@subcategory_name);
end
declare @id int
set @id = ((select max(ID) from Content)+1)
insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
values (@link,CURRENT_TIMESTAMP,@contributor_id,@category_id,@subcategory_name,@type_id);
insert into Original_Content (ID) values (@id);
end


GO -- batch 113
create proc Upload_New_Content @new_request_id int, @contributor_id int,
@subcategory_name varchar(255), @category_id varchar(255), @link varchar(255)
as
if(not exists (select ID from Contributor where ID=@contributor_id) or @contributor_id is null or not exists (select id from New_Request where id=@new_request_id))begin
	print 'ERROR' 
end
else begin
if (not exists (select [type] from Category where [type]=@category_id))begin
	insert into Category([type]) values (@category_id);
	insert into Sub_Category (category_type,name) values (@category_id,@subcategory_name);
end 
if (not exists (select category_type from Sub_Category where category_type=@category_id) and not exists (select name from Sub_Category where category_type=@subcategory_name) )begin
	insert into Sub_Category (category_type,name) values (@category_id,@subcategory_name);
end
declare @id int
set @id = ((select max(ID) from Content)+1)
insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name/*,[type]*/)
values (@link,CURRENT_TIMESTAMP,@contributor_id,@category_id,@subcategory_name/*,@type_id*/);
insert into New_Content (ID,new_request_id) values (@id,@new_request_id);
end


GO -- batch 115
create proc Delete_Content @content_id int 
as
if((select review_status from Original_Content where ID=@content_id) is null)begin
if(exists(select ID from New_Content where ID=@content_id))begin
delete from New_Content where ID=@content_id
end 
else begin delete from Original_Content where ID=@content_id end 

delete from Content where ID=@content_id
end
else begin print 'ERROR' end


GO -- batch 117
create proc Receive_New_Request @contributor_id int, @can_receive bit OUTPUT
as
if(not exists (select ID from Contributor where ID=@contributor_id) or @contributor_id is null)begin
	print 'ERROR' 
end
else begin
declare @requests int
set @requests = (select count(id) from New_Request where contributer_id=@contributor_id and accept_status='1')
declare @done int
set @done = (select count(New_Content.ID) 
			from New_Content
			left join Content on New_Content.ID=Content.ID
			where contributer_id=@contributor_id )
declare @r int 
set @r = @requests - @done
if(@r >2)begin
set @can_receive = '0'
print @can_receive
end
else begin 
set @can_receive='1'
print @can_receive
end
end


GO -- batch 119
create proc reviewer_filter_content
@reviewer_id int, @original_content int, @status bit 
as
if(not exists (select ID from Staff where ID=@reviewer_id) or @reviewer_id is null)begin
	print 'ERROR' 
end
else begin 
update Original_Content 
set review_status=@status
where ID=@original_content 
update Original_Content 
set reviewer_id=@reviewer_id
where ID=@original_content 
end 
 


 GO -- batch 121
create proc content_manager_filter_content @content_manager_id int, @original_content int, @status bit
as
if(not exists (select ID from Staff where ID=@content_manager_id) or @content_manager_id is null)begin
	print 'ERROR' 
end
else begin 
declare @oid int
set @oid = @original_content
declare @ct varchar(255)
set @ct = (select [type] from Content where ID=@oid)
declare @mt varchar(255)
set @mt = (select [type] from Content_manager where ID= @content_manager_id)
if(@ct=@mt)begin
update Original_Content 
set filter_status=@status
where ID=@original_content and review_status='1'
update Original_Content 
set content_manager_id=@content_manager_id
where ID=@original_content 
end  
else begin print 'ERROR' end
end 


GO -- batch 123
create proc Staff_Create_Category @category_name varchar(255)
as
if(not exists(select [type] from Category where [type]=@category_name))begin
insert into Category ([type]) values (@category_name);
end


GO -- batch 125
create proc Staff_Create_Subcategory @category_name varchar(255),
@subcategory_name varchar(255)
as
if(not exists(select [type] from Category where [type]=@category_name))begin
insert into Category ([type]) values (@category_name);
end 
if(not exists(select category_type from Sub_Category where category_type=@category_name) and not exists(select name from Sub_Category where name=@subcategory_name))begin
insert into Sub_Category (category_type,name) values (@category_name,@subcategory_name);
end


GO -- batch 127
create proc Staff_Create_Type @type_name varchar(255)
as
if(not exists(select [type] from Content_type where [type]=@type_name))begin
insert into Content_type ([type]) values (@type_name);
end


GO -- batch 129
create proc Most_Requested_Content
as
select Original_Content.ID, count(Original_Content.ID)
from Original_Content
right join Existing_Request on Original_Content.ID=Existing_Request.original_content_id
group by Original_Content.ID
order by count(Original_Content.ID) desc


GO -- batch 131
create proc Workingplace_Category_Relation
as 
select Viewer.working_place_type as 'working_place_type',Category.[type] as 'type1'
into temp
from Category
inner join Content on Category.[type]=Content.category_type
inner join New_Content on New_Content.ID=Content.ID
inner join New_Request on  New_Content.new_request_id=New_Request.id
inner join Viewer on New_Request.viewer_id=Viewer.ID
union all
select Viewer.working_place_type as 'working_place_type',Category.[type] as 'type1'
from Category
inner join Content on Category.[type]=Content.category_type
inner join Original_Content on Original_Content.ID=Content.ID
inner join Existing_Request on  Original_Content.ID=Existing_Request.original_content_id
inner join Viewer on Existing_Request.viewer_id=Viewer.ID
select temp.working_place_type,temp.type1,count(*) as 'number of requests'
from temp 
group by temp.working_place_type,temp.type1
order by temp.working_place_type
drop table temp


GO -- batch 133
create proc Delete_Comment_Staff @viewer_id int, @original_content_id int,
@comment_time datetime
as
if (@original_content_id is not null and @comment_time is not null and @viewer_id is not null)begin
DELETE FROM comment WHERE Viewer_id=@viewer_id and original_content_id=@original_content_id /*and [date]=@comment_time*/;
end 
	else begin print 'ERROR' end 


	GO -- batch 135
create proc Delete_Original_Content @content_id int
as 
if (@content_id is not null )begin
DELETE FROM Original_Content WHERE ID=@content_id ;
DELETE FROM Content WHERE ID=@content_id ;
end 
	else begin print 'ERROR' end 



	GO -- batch 137
create proc Delete_New_Content @content_id int
as 
if (@content_id is not null )begin
DELETE FROM New_Content WHERE ID=@content_id ;
DELETE FROM Content WHERE ID=@content_id ;
end 
	else begin print 'ERROR' end 


	GO -- batch 139
create proc Assign_Contributor_Request @contributor_id int,
@new_request_id int
as
if (@contributor_id is not null and @new_request_id is not null and exists (select ID from Contributor where ID=@contributor_id))begin
	if((select specified from New_Request where id=@new_request_id)='0')begin
	update New_Request
	set contributer_id=@contributor_id
	where id=@new_request_id
	end
	else begin print 'ERROR' end 
end
else begin print 'ERROR' end 


GO -- batch 141
create proc Show_Possible_Contributors
as
select Contributor.ID, count(Content.ID) as 'number of new requests'
into temp0
from New_Content
inner join Content on New_Content.ID=Content.ID
right join Contributor on Contributor.ID=Content.contributer_id
group by Contributor.ID
order by count(Content.ID) desc


select Contributor.ID,DATEDIFF(month,Announcement.seen_at, Content.uploaded_at) as 'diff'
into temp1
from New_Content
inner join Content on New_Content.ID=Content.ID
inner join New_Request on New_Content.new_request_id=New_Request.id
left join Announcement on New_Request.notif_obj_id=Announcement.notified_object_id
right join Contributor on Contributor.ID=Content.contributer_id

select ID,avg(temp1.diff) as 'diff'
into temp2
from temp1
group by temp1.ID

select temp0.ID,max(temp0.[number of new requests]) as 'number of new requests'
from temp0
left join temp2 on temp0.ID=temp2.ID
group by temp0.ID
order by max(temp2.diff) 
drop table temp0
drop table temp1
drop table temp2

