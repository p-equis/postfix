require 'fileutils'

describe "cherry-picking" do

	before :all do
		@repository = GitRepository.new
	end

	after :all do
		@repository.destroy
	end

	it "should append text to the original message" do
		
	end
end

class GitRepository
	def initialize
		@workspace = Dir::pwd + "/workspace"
		destroy
		Dir::mkdir @workspace
		Dir::chdir @workspace
		system("git init")
	end

	def destroy
		FileUtils.rm_rf @workspace
	end
end