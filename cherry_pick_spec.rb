require "fileutils"

describe "cherry-picking" do

	before :each do
		@repository = GitRepository.new
	end

	after :each do
		@repository.destroy
	end

	xit "should perform a normal cherry-pick" do
		@repository.create_commit "first on trunk"
		@repository.create_branch "new_branch"
		
		@repository.create_commit "to cherry-pick"

		@repository.cherry_pick(:take => 'master', 
								:to => 'new_branch')

		@repository.checkout_branch "new_branch"
		
		@repository.top_commit_message.should == "to cherry-pick"
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
		cherry = options[:take]
		target_branch = options[:to]
		merge_message = options[:merge_message]

		checkout_branch target_branch
		ENV["GIT_EDITOR"] = "sh #{Dir::pwd}/show.sh"
		bash("git cherry-pick #{cherry} --edit")
	end

	def top_commit_message 
		bash("git log -1 --pretty=format:'%s'")
	end

	def bash (command)
		`(cd #{@workspace} && #{command})`
	end
end