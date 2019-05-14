GO -- batch 46
 exec Original_Content_Search @typename = 'Images', @categoryname = 'Educational';

 
 GO -- batch 48
 exec Contributor_Search @fullname= 'ziad hassan farag';

 
 GO -- batch 50
 declare @user_id int 
 exec Register_User @usertype = 'Content_manager', @email = 'exp',@password = 'hmm', 
 @firstname = 'x', @middlename = 'y', @lastname = 'z',@birth_date = '1997/11/11', 
 @working_place_name = 'u',@working_place_type = 'i' , @wokring_place_description = 'o',
  @specilization = 'p', @portofolio_link = 'l.com', @years_experience = '66',
   @hire_date = '2018/1/1', @working_hours = '5',@payment_rate = '9',@user_id = @user_id output print @user_id;

 
 GO -- batch 52
 exec Check_Type @typename='M', @content_manager_id = '14';

 
 GO -- batch 54
 exec Order_Contributor;

 
 GO -- batch 56
 exec Show_Original_Content @contributor_id = '7';

 
	GO -- batch 57.1
	declare @user_id int
	exec User_login 'v100@egypt.com','v1',@user_id
	print @user_id


 
 GO -- batch 59
 usertype @userid='3';

 
GO -- batch 61

declare @email varchar(255)
declare @password varchar(255) 
declare @firstname varchar(255)  
declare @middlename varchar(255) 
declare @lastname varchar(255) 
declare @birth_date date 
declare @working_place_name varchar(255)
declare @working_place_type varchar(255) 
declare @working_place_description varchar(255)  
declare @specilization varchar(255) 
declare @portofolio_link varchar(255)  
declare @years_experience int 
declare @hire_date date  
declare @working_hours int  
declare @payment_rate int 
exec Show_Profile 
'2',
@email OUTPUT,
@password  OUTPUT,
@firstname  OUTPUT, 
@middlename  OUTPUT,
@lastname  OUTPUT, 
@birth_date  OUTPUT, 
@working_place_name  OUTPUT, 
@working_place_type  OUTPUT, 
@working_place_description  OUTPUT, 
@specilization  OUTPUT,
@portofolio_link  OUTPUT, 
@years_experience  OUTPUT, 
@hire_date  OUTPUT, 
@working_hours  OUTPUT, 
@payment_rate  OUTPUT;


GO -- batch 63
exec Edit_Profile '14',null,'changetrial',null,null,null,null,'lol',null,null,null,null,null,null,'10',null;


GO -- batch 64.1
exec Deactivate_Profile '14'


GO -- batch 66
exec Show_Event '1';



GO -- batch 68
exec Show_Notification null;


 GO -- batch 70
 exec Show_New_Content null,null;

 
GO -- batch 72
declare @event_id int
exec Viewer_Create_Event @city ='exp city' , @event_date_time  = '2020/9/9 12:00:00', @description = 'expd', 
@entartainer = 'no', 
@viewer_id ='3' ,@location='any', @event_id  = @event_id  OUTPUT;
print @event_id


GO -- batch 74
exec Viewer_Upload_Event_Photo '3','exp.com';



GO -- batch 76
exec Viewer_Upload_Event_Video '3','expv.com';


GO -- batch 78
exec Viewer_Create_Ad_From_Event '3';


GO -- batch 80
exec Apply_Existing_Request '3' , '7';


GO -- batch 82
exec Apply_New_Request 'expa', '8','1';


GO -- batch 84
exec Delete_New_Request '36';


 GO -- batch 86
 exec Rating_Original_Content '6','5','3';

 
GO -- batch 88
exec Write_Comment 'expc','1','8','2018/2/2';


GO -- batch 90
declare @t datetime
set @t=current_timestamp
declare @lt datetime
set @lt = '2018/11/15 12:13:09 AM'
exec Edit_Comment 'expc2','1','8',@lt,@t;
	

GO -- batch 92
declare @lt datetime
set @lt = '2018/11/15 04:42:43 PM'
exec Delete_Comment '1','8',@lt;



GO -- batch 94
exec Create_Ads '1','expane','Astria';


GO -- batch 96
exec Edit_Ad '6','expane2','Germany';


GO -- batch 98
exec Delete_Ads '6';


GO -- batch 100
exec Send_Message 'exp','2','5','0','2018/4/4';



GO -- batch 102
exec Show_Message '5';


GO -- batch 104
exec Highest_Rating_Original_content;


GO -- batch 106
exec Assign_New_Request '1','6';


GO -- batch 108
exec Receive_New_Requests null,'4';


GO -- batch 110
exec Respond_New_Request '6','1','15';


GO -- batch 112
exec Upload_Original_Content 'v','x','y','8','1.exp';

GO -- batch 114
exec Upload_New_Content '16','7','l','m','1.exp';


GO -- batch 116
exec Delete_Content '23';


GO -- batch 118
declare @can_receive bit
exec Receive_New_Request '8',@can_receive;


GO -- batch 120
exec reviewer_filter_content '10','6','1';


GO -- batch 122
exec content_manager_filter_content '13','6','1';


GO -- batch 124
exec Staff_Create_Category 'll';


GO -- batch 126
exec Staff_Create_Subcategory 'll','k';


GO -- batch 128
exec Staff_Create_Type 'lala';


GO -- batch 130
exec Most_Requested_Content



GO -- batch 132
exec Workingplace_Category_Relation


GO -- batch 134
declare @tt datetime
set @tt = '2018/11/15 09:18:03 PM'
exec Delete_Comment_Staff '1','8',@tt;



GO -- batch 136
exec Delete_Original_Content '9';


GO -- batch 138
exec Delete_New_Content '5';


GO -- batch 140
exec Assign_Contributor_Request '7','12';

GO -- batch 142
exec Show_Possible_Contributors
