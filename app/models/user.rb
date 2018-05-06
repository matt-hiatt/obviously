class User < ActiveRecord::Base

	STEP_REQUIRED_FIELDS = {1=>['username','password'], 2=>['first_name','last_name'], 3=>[]}

	
	def valid_user(step_num)

		valid_user = true
		user_errors = {}

		STEP_REQUIRED_FIELDS[step_num].each do |f|
			if(self.send(f).blank?)
				valid_user = false
				user_errors[f] = "is required"
			end
		end

		return valid_user, user_errors

	end

	def User.return_step_num(user)
		if(user.username.blank?)
			return 1
		elsif(user.first_name.blank?)
			return 2
		else
			return 3
		end
	end
end
