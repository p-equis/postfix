describe "cherry-picking" do
	
	before :all do
		set_up_git_repository
	end

	after :all do
		delete_git_repository
	end

	it "should append text to the original message" do
		
	end

	def set_up_git_repository
		@workspace = Dir::pwd + "/" + "workspace"
		Dir::mkdir @workspace
	end

	def delete_git_repository
		Dir::rmdir @workspace
	end
end