GO -- batch 26
 set identity_insert Notified_Person on 
 insert into Notified_Person (ID) values ('1');
 insert into Notified_Person (ID) values ('2');
 insert into Notified_Person (ID) values ('3');
 insert into Notified_Person (ID) values ('4');
 insert into Notified_Person (ID) values ('5');
 insert into Notified_Person (ID) values ('6');
 insert into Notified_Person (ID) values ('7');
 insert into Notified_Person (ID) values ('8');
 insert into Notified_Person (ID) values ('9');
 insert into Notified_Person (ID) values ('10');
 set identity_insert Notified_Person off

 GO -- batch 27
 insert into Category ([type],[description]) values ('Educational','This category includes all educational institutes');
 insert into Category ([type],[description]) values ('Investment','This category includes all investment institutes');
 insert into Category ([type],[description]) values ('Tourism','This category includes all tourism institutes');

 GO -- batch 28
 insert into Sub_Category (category_type,name) values ('Educational','School of Egypt');
 insert into Sub_Category (category_type,name) values ('Educational','University of Egypt');
 insert into Sub_Category (category_type,name) values ('Investment','Company of Egypt');
 insert into Sub_Category (category_type,name) values ('Investment','startup of Egypt');
 insert into Sub_Category (category_type,name) values ('Tourism','Museum of Egypt');
 insert into Sub_Category (category_type,name) values ('Tourism','Nile of Egypt');

 GO -- batch 29
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('v1@egypt.com','mohamed','yasser','ayman','1990/9/10','v1');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('v2@egypt.com','nadine','nasser','ahmed','1999/4/6','v2');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('v3@egypt.com','gina','gamal','soliman','1980/1/15','v3');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('c1@egypt.com','ahmed','kamal','salah','2000/6/11','c1');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('c2@egypt.com','nada','alaa','gamal','2001/9/21','c2');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('c3@egypt.com','khaled','ziad','hamada','1987/5/30','c3');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('c4@egypt.com','lila','serag','ady','1982/2/21','c4');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('c5@egypt.com','ziad','hassan','farag','1998/8/24','c5');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('r1@egypt.com','alyaa','nabil','diaa','1972/3/1','r1');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('r2@egypt.com','dina','eissa','mostafa','1977/12/28','r2');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('m1@egypt.com','salma','waleed','ali','1993/11/16','m1');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('m2@egypt.com','shady','wael','salem','2010/10/6','m2');
 insert into [User] (email,first_name,middle_name,last_name,birth_date,[password]) 
 values ('m3@egypt.com','farah','loay','tarek','1990/6/13','m3');

 GO -- batch 30
 insert into Viewer (ID,working_place,working_place_type,work_place_description) 
 values ('1','GUC','University','Its a University');
 insert into Viewer (ID,working_place,working_place_type,work_place_description) 
 values ('2','Academy','School','Its a School');
 insert into Viewer (ID,working_place,working_place_type,work_place_description) 
 values ('3','Apple','Company','Its a Company');

 GO -- batch 31
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values ('4','10','c1.com','Logos','1');
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values ('5','20','c2.com','Images','2');
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values ('6','30','c3.com','Videos','3');
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values ('7','40','c4.com','Logos','4');
 insert into Contributor (ID,years_of_experience,portfolio_link,specialization,notified_id) 
 values ('8','50','c5.com','Images','5');

 GO -- batch 32
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values ('9','1990/3/1','90','9','6');
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values ('10','2000/12/28','100','10','7');
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values ('11','2005/11/16','110','11','8');
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values ('12','2016/10/6','120','12','9');
 insert into Staff (ID,hired_date,working_hours,payment_rate,notified_id) 
 values ('13','2011/6/13','130','13','10');

 GO -- batch 33
 insert into Content_manager (ID,[type]) 
 values ('11','Images');
 insert into Content_manager (ID,[type]) 
 values ('12','Logos');
 insert into Content_manager (ID,[type]) 
 values ('13','Videos');

 GO -- batch 34
 insert into Reviewer (ID) 
 values ('9');
 insert into Reviewer (ID) 
 values ('10');
 
 GO -- batch 35
 insert into Content_type ([type])
 values ('Logos');
 insert into Content_type ([type])
 values ('Images');
 insert into Content_type ([type])
 values ('Videos');

 GO -- batch 36
 set identity_insert Notification_Object on
 insert into Notification_Object (ID) values ('1');
 insert into Notification_Object (ID) values ('2');
 insert into Notification_Object (ID) values ('3');
 insert into Notification_Object (ID) values ('4');
 insert into Notification_Object (ID) values ('5');
 insert into Notification_Object (ID) values ('6');
 insert into Notification_Object (ID) values ('7');
 insert into Notification_Object (ID) values ('8');
 insert into Notification_Object (ID) values ('9');
 insert into Notification_Object (ID) values ('10');
 insert into Notification_Object (ID) values ('11');
 insert into Notification_Object (ID) values ('12');
 insert into Notification_Object (ID) values ('13');
 set identity_insert Notification_Object off

 Go -- batch 37
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('1.com','2017/1/1','4','Investment','Company of Egypt','Images');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('2.com','2017/2/2','4','Educational','School of Egypt','Logos');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('3.com','2017/3/3','4','Educational','School of Egypt','Videos');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('4.com','2017/4/4','5','Investment','Company of Egypt','Logos');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('5.com','2017/5/5','5','Investment','Company of Egypt','Images');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('6.com','2017/6/6','6','Investment','Company of Egypt','Videos');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('7.com','2017/7/7','7','Educational','School of Egypt','Logos');
 insert into Content (link,uploaded_at,contributer_id,category_type,subcategory_name,[type])
 values ('8.com','2017/8/8','8','Educational','School of Egypt','Images');

 GO -- batch 38
 insert into Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status,rating)
 values ('6','13','9','0','0','');
 insert into Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status,rating)
 values ('7','12','10','1','0','5');
 insert into Original_Content (ID,content_manager_id,reviewer_id,review_status,filter_status,rating)
 values ('8','11','9','1','1','4');

 GO -- batch 39
 insert into Existing_Request (original_content_id,viewer_id) values ('6','1');
 insert into Existing_Request (original_content_id,viewer_id) values ('8','3');

GO -- batch 40 
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1','5','i want image','1','1','5');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1',null,'i want image too','2','2','5');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1','4','i want logo','3','3','4');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1','4','i want logo too','1','4','4');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1',null,'i want logo plz','2','5','4');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1','6','i want video','1','6','6');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1',null,'i want logo','2','7','7');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values('1','8','i want image','3','8','8');
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values(null,null,'i want logo','1','9',null);
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values(null,null,'i want image','2','10',null);
 insert into New_Request (accept_status,specified,information,viewer_id,notif_obj_id,contributer_id)
 values(null,null,'i want video','3','11',null);

 GO -- batch 41
 insert into New_Content (ID,new_request_id) 
 values ('1','3');
 insert into New_Content (ID,new_request_id) 
 values ('2','4');
 insert into New_Content (ID,new_request_id) 
 values ('3','5');
 insert into New_Content (ID,new_request_id) 
 values ('4','1');
 insert into New_Content (ID,new_request_id) 
 values ('5','2');

 GO -- batch 42
 insert into [Event] ([description],location,city,[time],entertainer,notification_object_id,viewer_id)
 values ('e1','egypt','cairo','2018/3/3 06:00:00','mostafa','12','1');
 insert into [Event] ([description],location,city,[time],entertainer,notification_object_id,viewer_id)
 values ('e2','uk','london','2018/10/9 08:00:00','nordic giants','13','2');

 GO -- batch 43
 insert into Advertisement ([description],location,event_id,viewer_id)
 values ('for e1','egypt','1','1');
 insert into Advertisement ([description],location,event_id,viewer_id)
 values ('for e2','uk','2','2');
 insert into Advertisement ([description],location,event_id,viewer_id)
 values ('for publicity for 3','usa',null,'3');
 insert into Advertisement ([description],location,event_id,viewer_id)
 values ('for publicity for 1','egypt',null,'1');

/* GO -- batch 44
 insert into Announcement (seen_at,send_at,notification_person_id,notification_object_id)
 values ('','','','');*/
