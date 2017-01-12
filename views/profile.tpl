% include header redirectUrl='home', currentUrl='profile', username=username
<div><h2><em>Edit Your Profile</em><h2> </div>

% try:
%    firstName = userInfo['properties']['firstName'][0]['value']
%    lastName = userInfo['properties']['lastName'][0]['value']
%    email = userInfo['properties']['email'][0]['value']
% except:
%    if not defined('error'):
%		error = 'Unable to load user profile'
% 	 end
% end

% if defined('error'):
	<div class="alert alert-error">
		{{error}}
	</div>
% end



<form class="form-horizontal" action="/profile" method="POST">

	<div class="control-group">
		<label for="firstName">First name:</label>
		<input class="form-control" name="firstName"
			% if defined('firstName'):
				value="{{firstName}}"
			% end
		>
	</div>
	
	<div class="control-group">
		<label for="lastName">Last name:</label>
		<input class="form-control" name="lastName"
			% if defined('lastName'):
					value="{{lastName}}"
				% end
		>
	</div>
	
	<div class="control-group">
		<label for="email">Email address:</label>
		<input class="form-control" name="email"
			% if defined('email'):
					value="{{email}}"
				% end
		>
	</div>
	
	<button value="EditProfile" type="submit" class="btn btn-default">Update Profile</button>

</form>

% include footer