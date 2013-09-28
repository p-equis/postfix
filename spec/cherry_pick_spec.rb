require "fileutils"
require "subshell"
require "cherry_picker"
require "git_repository"

describe "cherry-picking" do

	before :each do
		@repository = GitRepository.new
	end

	after :each do
		@repository.destroy
	end

	it "should append a message to the cherry-pick" do
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"

		@repository.cherry_pick(:take => 'master', 
								:to => 'new_branch',
								:merge_message => '[merged from trunk]')

		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
	end

	it "should append a message through the command line" do
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"

		@repository.run_in_subshell("ruby -I#{Dir.pwd}/lib/ #{Dir.pwd}/bin/chatty_pick master new_branch")
		
		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
	end
end