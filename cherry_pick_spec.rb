require "fileutils"
require "subshell"
require "cherry_picker"

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
end

class GitRepository
	def initialize
		@workspace = Dir::pwd + "/workspace"
		@file_id = 1
		destroy
		Dir::mkdir @workspace
		run_in_subshell("git init")
	end

	def destroy
		FileUtils.rm_rf @workspace
	end

	def create_commit (message)
		file_name = "#{@file_id}.txt"
		@file_id += 1
		run_in_subshell("touch #{file_name}")
		run_in_subshell("git add #{file_name}")
		run_in_subshell("git commit -m '#{message}'")
	end

	def create_branch (name)
		run_in_subshell("git branch #{name}")
	end

	def checkout_branch (name)
		run_in_subshell("git checkout #{name}")
	end

	def cherry_pick (options)
		cherry_picker = CherryPicker.new @workspace
		cherry_picker.cherry_pick options
	end

	def top_commit_message 
		run_in_subshell("git log -1 --pretty=format:'%s'")
	end

	def run_in_subshell (command)
		subshell = Subshell.new @workspace
		subshell.run command
	end
end