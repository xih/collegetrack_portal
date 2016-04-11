describe SalesforceClient do 
	include SalesforceClient

	it {get_column("Race").should == "Race__c"}
	it {get_column("Gender").should == "Gender__c"}
	it {get_column("Year").should == "Class_Level__c"}
	it {get_column("High School").should == "High_School__r.Name"}
	it {get_column("Language").should == "Primary_Home_Language__c"}
	it {get_column("stem").should == "STEM__c"}
	it {get_column("gpa").should == "UC_GPA__c"}
	#it {get_column("Race").should == "duck"}
end
