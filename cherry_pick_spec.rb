require "fileutils"

describe "cherry-picking" do

	before :each do
		@repository = GitRepository.new
	end

	after :each do
		@repository.destroy
	end

	xit "should append text to the original message" do
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"

		@repository.cherry_pick ( :take=>'master', 
			:to => 'new_branch', 
			:merge_message => '[merged from trunk]' )

		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick[merged from trunk]"
	end
end

class GitRepository
	def initialize
		@workspace = Dir::pwd + "/workspace"
		@file_id = 1
		destroy
		Dir::mkdir @workspace
		bash("git init")
	end

	def destroy
		FileUtils.rm_rf @workspace
	end

	def create_commit (message)
		file_name = "#{@file_id}.txt"
		@file_id += 1
		bash("touch #{file_name}")
		bash("git add #{file_name}")
		bash("git commit -m '#{message}'")
	end

	def create_branch (name)
		bash("git branch #{name}")
	end

	def checkout_branch (name)
		bash("git checkout #{name}")
	end

	def cherry_pick (options)

	end

	def top_commit_message 
		`git log -1 --pretty=format:'%s'`
	end

	def bash (command)
		result = `(cd #{@workspace} && #{command})`
	end
end