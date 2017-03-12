FactoryGirl.define do 
	factory :registered_application do 
		name "My App Factory"
		url   { "www.#{name.parameterize}.com" if name } # "www.my-app-factory.com"
		user
	end
end

