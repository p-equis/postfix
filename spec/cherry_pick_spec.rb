require "fileutils"
require "subshell"
require "cherry_picker"
require "testing_git_repository"

describe "cherry-picking" do

	before :each do
		@repository = TestingGitRepository.new
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
	end

	after :each do
		@repository.destroy
	end

	def cherry_pick
		@repository.cherry_pick(:take => 'master', 
									:to => 'new_branch',
									:merge_message => '[merged from trunk]')
	end

	describe "basic cases" do
		before :each do
			@repository.create_commit "to cherry-pick"
		end

		it "should append a message directly through the ruby objects" do
			cherry_pick

			@repository.checkout_branch "new_branch"
			
			@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
		end

		it "should not change the current branch" do
			cherry_pick

			@repository.current_branch_name.should == "master"
		end

		it "should append a message through the ruby-gem-like command line" do
			@repository.run_in_subshell("ruby -I#{Dir.pwd}/lib/ #{Dir.pwd}/bin/chatty_pick master new_branch")
			
			@repository.checkout_branch "new_branch"
			
			@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
		end
	end

	describe "with git-svn" do 
		it "should not preserve the git-svn id" do
			@repository.create_commit "to cherry-pick\ngit-svn-id: fake"

			cherry_pick

			@repository.checkout_branch "new_branch"

			@repository.top_commit_message.should == "to cherry-pick [merged from trunk]"
		end
	end
end