require "fileutils"
require "subshell"
require "cherry_picker"
require "testing_git_repository"

describe "cherry-picking" do

	before :each do
		@repository = TestingGitRepository.new
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"
	end

	after :each do
		@repository.destroy
	end

	it "should append a message directly through the ruby objects" do
		@repository.cherry_pick(:take => 'master', 
								:to => 'new_branch',
								:merge_message => '[merged from trunk]')

		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
	end

	it "should not change the current branch" do
		@repository.cherry_pick(:take => 'master', 
								:to => 'new_branch',
								:merge_message => '[merged from trunk]')

		@repository.current_branch_name.should == "master"
	end

	it "should append a message through the ruby-gem-like command line" do
		@repository.run_in_subshell("ruby -I#{Dir.pwd}/lib/ #{Dir.pwd}/bin/chatty_pick master new_branch")
		
		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
	end
end