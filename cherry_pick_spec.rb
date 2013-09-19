require "fileutils"

describe "cherry-picking" do

	before :all do
		@repository = GitRepository.new
	end

	after :all do
		@repository.destroy
	end

	it "should append text to the original message" do
		@repository.create_commit "first on trunk"
		
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"
		@repository.checkout_branch "new_branch"

		# run_cherry_pick_script " +postfix"

		#@repository.top_commit_message.should == "to cherry-pick +postfix"
	end
end

class GitRepository
	def initialize
		@workspace = Dir::pwd + "/workspace"
		@file_id = 1
		destroy
		Dir::mkdir @workspace
		Dir::chdir @workspace
		system("git init")
	end

	def destroy
		FileUtils.rm_rf @workspace
	end

	def create_commit (message)
		file_name = "#{@file_id}.txt"
		@file_id += 1
		system("touch #{file_name}")
		system("git add #{file_name}")
		system("git commit -m '#{message}'")
	end

	def create_branch (name)
		system("git branch #{name}")
	end

	def checkout_branch (name)
		system("git checkout #{name}")
	end

	def top_commit_message 
		""#system("git log -1 --pretty=format:'%s'")
	end
end